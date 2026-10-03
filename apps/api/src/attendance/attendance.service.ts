import { Injectable } from '@nestjs/common';
import { AuditService } from '../audit/audit.service.js';
import { appError, type ErrorCode } from '../common/errors.js';
import { AttendanceResultEnum, type AttendanceStatusEnum, type EventKindEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import { assertInTenant } from '../database/tenant-guard.js';
import { type Visibility, VisibilityService } from '../people/visibility.service.js';
import { hasPermission, Permission } from '../permissions/permissions.js';
import type {
  AttendanceEntryInput,
  AttendanceEntryResult,
  AttendanceRegister,
  Participation,
  PersonAttendance,
  RollCall,
} from './attendance.model.js';

/** D8: lo staff può fare o correggere l'appello da 2 ore prima dell'inizio a 7 giorni dopo la fine. */
export const ROLL_CALL_OPENS_BEFORE_MS = 2 * 3_600_000;
export const ROLL_CALL_CLOSES_AFTER_MS = 7 * 86_400_000;
const MAX_ENTRIES = 500;
const MAX_REGISTER_DAYS = 366;

interface EventInfo {
  id: string;
  team_id: string | null;
  status: string;
  starts_at: Date;
  ends_at: Date;
}

/** Esito del controllo di accesso a un evento per l'appello. */
type Gate = { ok: true } | { ok: false; code: ErrorCode };

@Injectable()
export class AttendanceService {
  constructor(
    private readonly ctx: DbContext,
    private readonly visibility: VisibilityService,
    private readonly audit: AuditService,
  ) {}

  async rollCall(access: TenantAccess, userId: string, eventId: string): Promise<RollCall> {
    const v = await this.visibility.forUser(access, userId);
    const event = await this.ctx.db
      .selectFrom('events as e')
      .innerJoin('teams as t', 't.id', 'e.team_id')
      .select(['e.id', 'e.team_id', 't.name as team_name', 'e.kind', 'e.title', 'e.opponent', 'e.starts_at', 'e.ends_at', 'e.status', 'e.roll_call_at'])
      .where('e.id', '=', eventId)
      .executeTakeFirst();
    if (!event || !this.canSeeTeamAttendance(access, v, event.team_id)) throw appError('NOT_FOUND');

    const roster = await this.ctx.db
      .selectFrom('team_players as tp')
      .innerJoin('people as p', 'p.id', 'tp.person_id')
      .select(['p.id', 'p.first_name', 'p.last_name', 'tp.jersey_number'])
      .where('tp.team_id', '=', event.team_id)
      .execute();
    const records = await this.ctx.db
      .selectFrom('attendance as a')
      .innerJoin('people as p', 'p.id', 'a.person_id')
      .select(['a.person_id', 'a.status', 'a.note', 'p.first_name', 'p.last_name'])
      .where('a.event_id', '=', eventId)
      .execute();
    const notices = await this.ctx.db
      .selectFrom('absence_notices')
      .select(['id', 'person_id', 'reason', 'created_at'])
      .where('event_id', '=', eventId)
      .where('withdrawn_at', 'is', null)
      .execute();

    const inRoster = new Set(roster.map((r) => r.id));
    const players = [
      ...roster.map((r) => ({ personId: r.id, firstName: r.first_name, lastName: r.last_name, jerseyNumber: r.jersey_number, formerPlayer: false })),
      ...records
        .filter((r) => !inRoster.has(r.person_id))
        .map((r) => ({ personId: r.person_id, firstName: r.first_name, lastName: r.last_name, jerseyNumber: null, formerPlayer: true })),
    ]
      .map((p) => {
        const rec = records.find((r) => r.person_id === p.personId);
        const notice = notices.find((n) => n.person_id === p.personId);
        return {
          ...p,
          status: (rec?.status ?? null) as AttendanceStatusEnum | null,
          note: rec?.note ?? null,
          absenceNotice: notice ? { id: notice.id, reason: notice.reason, createdAt: notice.created_at } : null,
        };
      })
      .sort((a, b) => (a.jerseyNumber ?? 999) - (b.jerseyNumber ?? 999) || a.lastName.localeCompare(b.lastName));

    const gate = this.gate(access, v, event, new Date());
    const staffOnly = !hasPermission(access, Permission.AttendanceManageAll);
    return {
      eventId: event.id,
      teamId: event.team_id!,
      teamName: event.team_name,
      kind: event.kind as EventKindEnum,
      title: event.title,
      opponent: event.opponent,
      startsAt: event.starts_at,
      endsAt: event.ends_at,
      cancelled: event.status === 'CANCELLED',
      completedAt: event.roll_call_at,
      editable: gate.ok,
      editableUntil: staffOnly ? new Date(event.ends_at.getTime() + ROLL_CALL_CLOSES_AFTER_MS) : null,
      players,
    };
  }

  /**
   * Registra un lotto di presenze, tipicamente inviato dalla coda offline dell'app. Ogni riga ha un esito
   * proprio; una riga rifiutata non blocca le altre. Vince la registrazione con `recordedAt` più recente.
   */
  async record(access: TenantAccess, userId: string, entries: AttendanceEntryInput[]): Promise<AttendanceEntryResult[]> {
    if (entries.length > MAX_ENTRIES) throw appError('BAD_USER_INPUT', `Al massimo ${MAX_ENTRIES} righe per invio`);
    const v = await this.visibility.forUser(access, userId);
    const now = new Date();
    const events = await this.loadEvents(entries.map((e) => e.eventId));
    const rosters = await this.loadRosters([...events.values()].map((e) => e.team_id).filter((t): t is string => !!t));
    const results: AttendanceEntryResult[] = [];
    let applied = 0;

    for (const entry of entries) {
      const done = (result: AttendanceResultEnum, code: string | null = null) =>
        results.push({ clientMutationId: entry.clientMutationId, result, code });

      const previous = await this.ctx.db
        .selectFrom('attendance_writes')
        .select('id')
        .where('client_mutation_id', '=', entry.clientMutationId)
        .executeTakeFirst();
      if (previous) {
        done(AttendanceResultEnum.DUPLICATE);
        continue;
      }
      const event = events.get(entry.eventId);
      const gate = event ? this.gate(access, v, event, now) : ({ ok: false, code: 'NOT_FOUND' } as const);
      if (!gate.ok) {
        done(AttendanceResultEnum.REJECTED, gate.code);
        continue;
      }
      if (!rosters.get(event!.team_id!)?.has(entry.personId)) {
        done(AttendanceResultEnum.REJECTED, 'NOT_IN_ROSTER');
        continue;
      }

      // Un orologio del telefono avanti non deve vincere sulle registrazioni successive.
      const recordedAt = entry.recordedAt > now ? now : entry.recordedAt;
      const current = await this.ctx.db
        .selectFrom('attendance')
        .select('recorded_at')
        .where('event_id', '=', entry.eventId)
        .where('person_id', '=', entry.personId)
        .executeTakeFirst();
      const superseded = current !== undefined && current.recorded_at > recordedAt;

      const write = await this.ctx.db
        .insertInto('attendance_writes')
        .values({
          tenant_id: access.tenantId,
          client_mutation_id: entry.clientMutationId,
          event_id: entry.eventId,
          person_id: entry.personId,
          status: entry.status,
          note: entry.note?.trim() || null,
          recorded_by: userId,
          recorded_at: recordedAt,
          outcome: superseded ? 'SUPERSEDED' : 'APPLIED',
        })
        .onConflict((oc) => oc.column('client_mutation_id').doNothing())
        .returning('id')
        .executeTakeFirst();
      if (!write) {
        // Stessa riga arrivata in parallelo da un'altra richiesta.
        done(AttendanceResultEnum.DUPLICATE);
        continue;
      }
      if (superseded) {
        done(AttendanceResultEnum.SUPERSEDED);
        continue;
      }
      await this.ctx.db
        .insertInto('attendance')
        .values({
          tenant_id: access.tenantId,
          event_id: entry.eventId,
          person_id: entry.personId,
          status: entry.status,
          note: entry.note?.trim() || null,
          recorded_by: userId,
          recorded_at: recordedAt,
        })
        .onConflict((oc) =>
          oc.columns(['event_id', 'person_id']).doUpdateSet((eb) => ({
            status: eb.ref('excluded.status'),
            note: eb.ref('excluded.note'),
            recorded_by: eb.ref('excluded.recorded_by'),
            recorded_at: eb.ref('excluded.recorded_at'),
            updated_at: now,
          })),
        )
        .execute();
      applied++;
      done(AttendanceResultEnum.APPLIED);
    }

    // Correzioni oltre la finestra dello staff: restano tracciate nel log di audit.
    const late = entries.filter((e) => {
      const ev = events.get(e.eventId);
      return ev && now.getTime() > ev.ends_at.getTime() + ROLL_CALL_CLOSES_AFTER_MS;
    });
    if (applied && late.length) {
      await this.audit.record({ action: 'attendance.late_correction', metadata: { events: [...new Set(late.map((e) => e.eventId))] } });
    }
    return results;
  }

  /** Segna l'appello come confermato. Idempotente: la prima conferma resta. */
  async complete(access: TenantAccess, userId: string, eventId: string): Promise<RollCall> {
    const v = await this.visibility.forUser(access, userId);
    const event = (await this.loadEvents([eventId])).get(eventId);
    if (!event || !this.canSeeTeamAttendance(access, v, event.team_id)) throw appError('NOT_FOUND');
    const gate = this.gate(access, v, event, new Date());
    if (!gate.ok) throw appError(gate.code);
    await this.ctx.db
      .updateTable('events')
      .set({ roll_call_at: new Date(), roll_call_by: userId })
      .where('id', '=', eventId)
      .where('roll_call_at', 'is', null)
      .execute();
    return this.rollCall(access, userId, eventId);
  }

  async register(access: TenantAccess, userId: string, teamId: string, from: Date, to: Date, kind: EventKindEnum | null): Promise<AttendanceRegister> {
    if (to <= from || to.getTime() - from.getTime() > MAX_REGISTER_DAYS * 86_400_000) {
      throw appError('BAD_USER_INPUT', `Periodo non valido (massimo ${MAX_REGISTER_DAYS} giorni)`);
    }
    await assertInTenant(this.ctx, 'teams', [teamId]);
    const v = await this.visibility.forUser(access, userId);
    if (!this.canSeeTeamAttendance(access, v, teamId)) throw appError('FORBIDDEN');

    let eq = this.ctx.db
      .selectFrom('events')
      .select(['id', 'starts_at', 'kind', 'title', 'opponent', 'roll_call_at'])
      .where('team_id', '=', teamId)
      .where('status', '=', 'SCHEDULED')
      .where('starts_at', '>=', from)
      .where('starts_at', '<', to);
    if (kind) eq = eq.where('kind', '=', kind);
    const events = await eq.orderBy('starts_at').execute();
    const eventIds = events.map((e) => e.id);
    const cells = eventIds.length
      ? await this.ctx.db.selectFrom('attendance').select(['event_id', 'person_id', 'status', 'note']).where('event_id', 'in', eventIds).execute()
      : [];
    const roster = await this.ctx.db
      .selectFrom('team_players as tp')
      .innerJoin('people as p', 'p.id', 'tp.person_id')
      .select(['p.id', 'p.first_name', 'p.last_name', 'tp.jersey_number'])
      .where('tp.team_id', '=', teamId)
      .execute();
    const extraIds = [...new Set(cells.map((c) => c.person_id))].filter((id) => !roster.some((r) => r.id === id));
    const extra = extraIds.length
      ? await this.ctx.db.selectFrom('people').select(['id', 'first_name', 'last_name']).where('id', 'in', extraIds).execute()
      : [];

    const people = [
      ...roster.map((r) => ({ id: r.id, first_name: r.first_name, last_name: r.last_name, jersey_number: r.jersey_number })),
      ...extra.map((p) => ({ ...p, jersey_number: null })),
    ];
    return {
      events: events.map((e) => ({
        id: e.id,
        startsAt: e.starts_at,
        kind: e.kind as EventKindEnum,
        title: e.title,
        opponent: e.opponent,
        rollCallDone: e.roll_call_at !== null,
      })),
      players: people
        .map((p) => {
          const own = cells.filter((c) => c.person_id === p.id);
          const attended = own.filter((c) => c.status === 'PRESENT' || c.status === 'LATE').length;
          return {
            personId: p.id,
            firstName: p.first_name,
            lastName: p.last_name,
            jerseyNumber: p.jersey_number,
            recorded: own.length,
            attended,
            excused: own.filter((c) => c.status === 'EXCUSED').length,
            percentage: own.length ? Math.round((attended / own.length) * 100) : null,
          };
        })
        .sort((a, b) => a.lastName.localeCompare(b.lastName) || a.firstName.localeCompare(b.firstName)),
      cells: cells.map((c) => ({ eventId: c.event_id, personId: c.person_id, status: c.status as AttendanceStatusEnum, note: c.note })),
    };
  }

  /** Partecipazione all'evento dell'utente e dei figli: presenza e assenza annunciata. */
  async participation(access: TenantAccess, userId: string, eventId: string): Promise<Participation[]> {
    const v = await this.visibility.forUser(access, userId);
    const own = [...v.selfPersonIds, ...v.wardPersonIds];
    const event = (await this.loadEvents([eventId])).get(eventId);
    if (!event?.team_id || !own.length) return [];
    const players = await this.ctx.db
      .selectFrom('team_players as tp')
      .innerJoin('people as p', 'p.id', 'tp.person_id')
      .leftJoin('attendance as a', (j) => j.onRef('a.person_id', '=', 'p.id').on('a.event_id', '=', eventId))
      .leftJoin('absence_notices as n', (j) =>
        j.onRef('n.person_id', '=', 'p.id').on('n.event_id', '=', eventId).on('n.withdrawn_at', 'is', null),
      )
      .select(['p.id', 'p.first_name', 'p.last_name', 'a.status', 'n.id as notice_id', 'n.reason', 'n.created_at'])
      .where('tp.team_id', '=', event.team_id)
      .where('p.id', 'in', own)
      .execute();
    const canReport = event.status === 'SCHEDULED' && event.starts_at > new Date();
    return players.map((p) => ({
      personId: p.id,
      firstName: p.first_name,
      lastName: p.last_name,
      status: (p.status ?? null) as AttendanceStatusEnum | null,
      absenceNotice: p.notice_id ? { id: p.notice_id, reason: p.reason, createdAt: p.created_at! } : null,
      canReport,
    }));
  }

  /** Assenza annunciata da un tutore o dall'atleta stesso, solo per eventi futuri. Aggiorna il motivo se già presente. */
  async reportAbsence(access: TenantAccess, userId: string, eventId: string, personId: string, reason: string | null): Promise<Participation[]> {
    const v = await this.visibility.forUser(access, userId);
    if (![...v.selfPersonIds, ...v.wardPersonIds].includes(personId)) throw appError('FORBIDDEN');
    const event = (await this.loadEvents([eventId])).get(eventId);
    if (!event?.team_id) throw appError('NOT_FOUND');
    if (event.status === 'CANCELLED') throw appError('EVENT_CANCELLED');
    if (event.starts_at <= new Date()) throw appError('EVENT_STARTED');
    if (!(await this.loadRosters([event.team_id])).get(event.team_id)?.has(personId)) throw appError('NOT_IN_ROSTER');

    const existing = await this.ctx.db
      .selectFrom('absence_notices')
      .select('id')
      .where('event_id', '=', eventId)
      .where('person_id', '=', personId)
      .where('withdrawn_at', 'is', null)
      .executeTakeFirst();
    if (existing) {
      await this.ctx.db.updateTable('absence_notices').set({ reason: reason?.trim() || null }).where('id', '=', existing.id).execute();
    } else {
      await this.ctx.db
        .insertInto('absence_notices')
        .values({ tenant_id: access.tenantId, event_id: eventId, person_id: personId, reason: reason?.trim() || null, created_by: userId })
        .execute();
    }
    return this.participation(access, userId, eventId);
  }

  async withdrawAbsence(access: TenantAccess, userId: string, noticeId: string): Promise<Participation[]> {
    const v = await this.visibility.forUser(access, userId);
    const notice = await this.ctx.db
      .selectFrom('absence_notices as n')
      .innerJoin('events as e', 'e.id', 'n.event_id')
      .select(['n.id', 'n.person_id', 'n.event_id', 'e.starts_at'])
      .where('n.id', '=', noticeId)
      .where('n.withdrawn_at', 'is', null)
      .executeTakeFirst();
    if (!notice || ![...v.selfPersonIds, ...v.wardPersonIds].includes(notice.person_id)) throw appError('NOT_FOUND');
    if (notice.starts_at <= new Date()) throw appError('EVENT_STARTED');
    await this.ctx.db.updateTable('absence_notices').set({ withdrawn_at: new Date() }).where('id', '=', noticeId).execute();
    return this.participation(access, userId, notice.event_id);
  }

  /** D10: storico presenze della persona stessa o di un figlio. */
  async personHistory(access: TenantAccess, userId: string, personId: string, limit: number): Promise<PersonAttendance[]> {
    const v = await this.visibility.forUser(access, userId);
    const allowed =
      [...v.selfPersonIds, ...v.wardPersonIds].includes(personId) || hasPermission(access, Permission.AttendanceManageAll);
    if (!allowed) throw appError('FORBIDDEN');
    const rows = await this.ctx.db
      .selectFrom('attendance as a')
      .innerJoin('events as e', 'e.id', 'a.event_id')
      .innerJoin('teams as t', 't.id', 'e.team_id')
      .select(['e.id', 'e.starts_at', 'e.kind', 'e.title', 'e.opponent', 't.name as team_name', 'a.status'])
      .where('a.person_id', '=', personId)
      .orderBy('e.starts_at', 'desc')
      .limit(Math.min(Math.max(limit, 1), 100))
      .execute();
    return rows.map((r) => ({
      eventId: r.id,
      startsAt: r.starts_at,
      kind: r.kind as EventKindEnum,
      title: r.title,
      opponent: r.opponent,
      teamName: r.team_name,
      status: r.status as AttendanceStatusEnum,
    }));
  }

  // --- interni ---------------------------------------------------------------------------------

  private canSeeTeamAttendance(access: TenantAccess, v: Visibility, teamId: string | null): boolean {
    if (!teamId) return false;
    return hasPermission(access, Permission.AttendanceManageAll) || v.staffTeamIds.includes(teamId);
  }

  /** Permesso e finestra temporale (D8) per modificare l'appello di un evento. */
  private gate(access: TenantAccess, v: Visibility, event: EventInfo, now: Date): Gate {
    if (!this.canSeeTeamAttendance(access, v, event.team_id)) return { ok: false, code: 'FORBIDDEN' };
    if (event.status === 'CANCELLED') return { ok: false, code: 'EVENT_CANCELLED' };
    if (now.getTime() < event.starts_at.getTime() - ROLL_CALL_OPENS_BEFORE_MS) return { ok: false, code: 'OUT_OF_WINDOW' };
    const staffOnly = !hasPermission(access, Permission.AttendanceManageAll);
    if (staffOnly && now.getTime() > event.ends_at.getTime() + ROLL_CALL_CLOSES_AFTER_MS) return { ok: false, code: 'OUT_OF_WINDOW' };
    return { ok: true };
  }

  private async loadEvents(ids: string[]): Promise<Map<string, EventInfo>> {
    const unique = [...new Set(ids)];
    if (!unique.length) return new Map();
    const rows = await this.ctx.db
      .selectFrom('events')
      .select(['id', 'team_id', 'status', 'starts_at', 'ends_at'])
      .where('id', 'in', unique)
      .execute();
    return new Map(rows.map((r) => [r.id, r]));
  }

  private async loadRosters(teamIds: string[]): Promise<Map<string, Set<string>>> {
    const unique = [...new Set(teamIds)];
    const map = new Map<string, Set<string>>(unique.map((t) => [t, new Set()]));
    if (!unique.length) return map;
    const rows = await this.ctx.db.selectFrom('team_players').select(['team_id', 'person_id']).where('team_id', 'in', unique).execute();
    for (const r of rows) map.get(r.team_id)!.add(r.person_id);
    return map;
  }
}
