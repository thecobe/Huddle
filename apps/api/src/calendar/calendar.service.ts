import { Injectable } from '@nestjs/common';
import { sql } from 'kysely';
import { AuditService } from '../audit/audit.service.js';
import { todayInZone } from '../common/dates.js';
import { appError } from '../common/errors.js';
import type { EventKindEnum, EventStatusEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import { assertInTenant } from '../database/tenant-guard.js';
import type { EventSeriesRow } from '../database/types.js';
import { type Visibility, VisibilityService } from '../people/visibility.service.js';
import { hasPermission, Permission } from '../permissions/permissions.js';
import type { CalendarEvent, CancelRangeInput, EventInput, EventSeries, SeriesInput } from './calendar.model.js';

/** Finestra massima di una singola richiesta di eventi. */
const MAX_RANGE_DAYS = 120;

type EventQueryRow = {
  id: string;
  team_id: string | null;
  team_name: string | null;
  team_color: string | null;
  series_id: string | null;
  detached: boolean;
  kind: string;
  title: string | null;
  starts_at: Date;
  ends_at: Date;
  location: string | null;
  notes: string | null;
  status: string;
  cancel_reason: string | null;
  opponent: string | null;
  is_home: boolean | null;
  competition: string | null;
};

@Injectable()
export class CalendarService {
  constructor(
    private readonly ctx: DbContext,
    private readonly visibility: VisibilityService,
    private readonly audit: AuditService,
  ) {}

  /** Calendario: eventi delle squadre visibili più quelli di tutta la società. */
  async events(access: TenantAccess, userId: string, from: Date, to: Date, teamId: string | null): Promise<CalendarEvent[]> {
    assertRange(from, to);
    const v = await this.visibility.forUser(access, userId);
    let q = this.baseQuery()
      .where('e.starts_at', '<', to)
      .where('e.ends_at', '>', from)
      .where((eb) => eb.or([eb('e.team_id', 'is', null), eb('e.team_id', 'in', this.visibleTeams(v))]));
    if (teamId) q = q.where('e.team_id', '=', teamId);
    const rows = await q.orderBy('e.starts_at').execute();
    return rows.map((r) => this.toModel(r, access, v));
  }

  /**
   * Agenda personale: eventi delle squadre in cui l'utente gioca o è nello staff, di quelle dei figli
   * e quelli di tutta la società. Per la direzione non include tutte le squadre: solo le proprie.
   */
  async agenda(access: TenantAccess, userId: string, from: Date, to: Date): Promise<CalendarEvent[]> {
    assertRange(from, to);
    const v = await this.visibility.forUser(access, userId);
    const personal: Visibility = { ...v, all: false };
    const rows = await this.baseQuery()
      .where('e.starts_at', '<', to)
      .where('e.ends_at', '>', from)
      .where((eb) => eb.or([eb('e.team_id', 'is', null), eb('e.team_id', 'in', this.visibleTeams(personal))]))
      .orderBy('e.starts_at')
      .execute();
    return rows.map((r) => this.toModel(r, access, v));
  }

  /**
   * Eventi per l'abbonamento iCal: un mese indietro e un anno avanti, senza il limite delle richieste
   * interattive. Con `teamId` solo quella squadra (se visibile), altrimenti l'agenda personale.
   */
  async feedEvents(access: TenantAccess, userId: string, teamId: string | null): Promise<(CalendarEvent & { updatedAt: Date })[]> {
    const v = await this.visibility.forUser(access, userId);
    const scope: Visibility = teamId ? v : { ...v, all: false };
    const from = new Date(Date.now() - 30 * 86_400_000);
    const to = new Date(Date.now() + 365 * 86_400_000);
    let q = this.baseQuery()
      .select('e.updated_at')
      .where('e.starts_at', '<', to)
      .where('e.ends_at', '>', from)
      .where((eb) => eb.or([eb('e.team_id', 'is', null), eb('e.team_id', 'in', this.visibleTeams(scope))]));
    if (teamId) q = q.where('e.team_id', '=', teamId);
    const rows = await q.orderBy('e.starts_at').execute();
    return rows.map((r) => ({ ...this.toModel(r, access, v), updatedAt: r.updated_at }));
  }

  async event(access: TenantAccess, userId: string, id: string): Promise<CalendarEvent> {
    const v = await this.visibility.forUser(access, userId);
    const row = await this.baseQuery()
      .where('e.id', '=', id)
      .where((eb) => eb.or([eb('e.team_id', 'is', null), eb('e.team_id', 'in', this.visibleTeams(v))]))
      .executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    return this.toModel(row, access, v);
  }

  async seriesList(access: TenantAccess, userId: string, teamId: string | null): Promise<EventSeries[]> {
    const v = await this.visibility.forUser(access, userId);
    const today = await this.today(access.tenantId);
    let q = this.ctx.db
      .selectFrom('event_series as s')
      .innerJoin('teams as t', 't.id', 's.team_id')
      .selectAll('s')
      .select('t.name as team_name')
      .select((eb) =>
        eb
          .selectFrom('events')
          .select(eb.fn.countAll<string>().as('n'))
          .whereRef('series_id', '=', 's.id')
          .where('series_date', '>=', today)
          .where('status', '=', 'SCHEDULED')
          .as('upcoming'),
      )
      .where('s.team_id', 'in', this.visibleTeams(v))
      .where('s.ends_on', '>=', today);
    if (teamId) q = q.where('s.team_id', '=', teamId);
    const rows = await q.orderBy('t.name').orderBy('s.start_time').execute();
    return rows.map((r) => toSeries(r, r.team_name, Number(r.upcoming ?? 0)));
  }

  async createSeries(access: TenantAccess, userId: string, input: SeriesInput): Promise<EventSeries> {
    await this.assertCanManageTeam(access, userId, input.teamId);
    const bounds = await this.seriesBounds(access.tenantId, input);
    const row = await this.ctx.db
      .insertInto('event_series')
      .values({
        tenant_id: access.tenantId,
        team_id: input.teamId,
        title: input.title?.trim() || null,
        weekdays: uniqueSorted(input.weekdays),
        start_time: input.startTime,
        duration_minutes: input.durationMinutes,
        location: input.location?.trim() || null,
        starts_on: bounds.startsOn,
        ends_on: bounds.endsOn,
        created_by: userId,
      })
      .returning('id')
      .executeTakeFirstOrThrow();
    const count = await this.generate(row.id, bounds.startsOn);
    await this.audit.record({ action: 'calendar.series_created', entityType: 'event_series', entityId: row.id, metadata: { count } });
    return this.oneSeries(access, userId, row.id);
  }

  /**
   * Modifica la serie a partire da `fromDate` (mai prima di oggi): le occorrenze future non modificate
   * singolarmente vengono rigenerate; quelle passate e quelle modificate a mano restano com'erano.
   */
  async updateSeries(access: TenantAccess, userId: string, id: string, input: SeriesInput, fromDate: string | null): Promise<EventSeries> {
    const series = await this.loadSeries(id);
    await this.assertCanManageTeam(access, userId, series.team_id);
    if (input.teamId !== series.team_id) throw appError('BAD_USER_INPUT', 'Una serie non può cambiare squadra');
    const from = maxDate(fromDate ?? series.starts_on, await this.today(access.tenantId));
    const bounds = await this.seriesBounds(access.tenantId, { ...input, startsOn: input.startsOn ?? series.starts_on });
    await this.ctx.db
      .deleteFrom('events')
      .where('series_id', '=', id)
      .where('detached', '=', false)
      .where('series_date', '>=', from)
      .execute();
    await this.ctx.db
      .updateTable('event_series')
      .set({
        title: input.title?.trim() || null,
        weekdays: uniqueSorted(input.weekdays),
        start_time: input.startTime,
        duration_minutes: input.durationMinutes,
        location: input.location?.trim() || null,
        starts_on: bounds.startsOn,
        ends_on: bounds.endsOn,
      })
      .where('id', '=', id)
      .execute();
    const count = await this.generate(id, from);
    await this.audit.record({ action: 'calendar.series_updated', entityType: 'event_series', entityId: id, metadata: { from, count } });
    return this.oneSeries(access, userId, id);
  }

  /** Termina la serie: elimina le occorrenze da `fromDate` (non modificate a mano) e accorcia la serie. */
  async endSeries(access: TenantAccess, userId: string, id: string, fromDate: string): Promise<boolean> {
    const series = await this.loadSeries(id);
    await this.assertCanManageTeam(access, userId, series.team_id);
    const from = maxDate(fromDate, await this.today(access.tenantId));
    await this.ctx.db
      .deleteFrom('events')
      .where('series_id', '=', id)
      .where('detached', '=', false)
      .where('series_date', '>=', from)
      .execute();
    await this.ctx.db
      .updateTable('event_series')
      .set({ ends_on: sql`greatest(starts_on, ${from}::date - 1)` })
      .where('id', '=', id)
      .execute();
    await this.audit.record({ action: 'calendar.series_ended', entityType: 'event_series', entityId: id, metadata: { from } });
    return true;
  }

  async createEvent(access: TenantAccess, userId: string, input: EventInput): Promise<CalendarEvent> {
    await this.assertCanManage(access, userId, input.teamId ?? null);
    assertTimes(input);
    const row = await this.ctx.db
      .insertInto('events')
      .values({ tenant_id: access.tenantId, ...eventColumns(input), created_by: userId })
      .returning('id')
      .executeTakeFirstOrThrow();
    await this.audit.record({ action: 'calendar.event_created', entityType: 'event', entityId: row.id });
    return this.event(access, userId, row.id);
  }

  /** Modifica una singola occorrenza: da quel momento non segue più la serie. */
  async updateEvent(access: TenantAccess, userId: string, id: string, input: EventInput): Promise<CalendarEvent> {
    const current = await this.loadEvent(access, userId, id);
    await this.assertCanManage(access, userId, current.team_id);
    if ((input.teamId ?? null) !== current.team_id) await this.assertCanManage(access, userId, input.teamId ?? null);
    assertTimes(input);
    await this.ctx.db
      .updateTable('events')
      .set({ ...eventColumns(input), detached: current.series_id !== null })
      .where('id', '=', id)
      .execute();
    await this.audit.record({ action: 'calendar.event_updated', entityType: 'event', entityId: id });
    return this.event(access, userId, id);
  }

  async setCancelled(access: TenantAccess, userId: string, id: string, cancelled: boolean, reason: string | null): Promise<CalendarEvent> {
    const current = await this.loadEvent(access, userId, id);
    await this.assertCanManage(access, userId, current.team_id);
    await this.ctx.db
      .updateTable('events')
      .set({
        status: cancelled ? 'CANCELLED' : 'SCHEDULED',
        cancel_reason: cancelled ? reason?.trim() || null : null,
        detached: current.series_id !== null,
      })
      .where('id', '=', id)
      .execute();
    await this.audit.record({
      action: cancelled ? 'calendar.event_cancelled' : 'calendar.event_restored',
      entityType: 'event',
      entityId: id,
    });
    return this.event(access, userId, id);
  }

  async deleteEvent(access: TenantAccess, userId: string, id: string): Promise<boolean> {
    const current = await this.loadEvent(access, userId, id);
    await this.assertCanManage(access, userId, current.team_id);
    if (current.series_id) throw appError('BAD_USER_INPUT', "Un'occorrenza di una serie si annulla, non si elimina");
    await this.ctx.db.deleteFrom('events').where('id', '=', id).execute();
    await this.audit.record({ action: 'calendar.event_deleted', entityType: 'event', entityId: id });
    return true;
  }

  /** Annulla tutti gli eventi in un periodo (festività, chiusura impianto), di una squadra o di tutte. */
  async cancelRange(access: TenantAccess, userId: string, input: CancelRangeInput): Promise<number> {
    if (input.toDate < input.fromDate) throw appError('BAD_USER_INPUT', 'Periodo non valido');
    await this.assertCanManage(access, userId, input.teamId ?? null);
    const club = await this.ctx.db.selectFrom('clubs').select('timezone').where('id', '=', access.tenantId).executeTakeFirstOrThrow();
    let q = this.ctx.db
      .updateTable('events')
      .set({ status: 'CANCELLED', cancel_reason: input.reason?.trim() || null, detached: sql`series_id IS NOT NULL` })
      .where('status', '=', 'SCHEDULED')
      .where('starts_at', '>=', sql<Date>`(${input.fromDate}::date)::timestamp AT TIME ZONE ${club.timezone}`)
      .where('starts_at', '<', sql<Date>`(${input.toDate}::date + 1)::timestamp AT TIME ZONE ${club.timezone}`);
    if (input.teamId) q = q.where('team_id', '=', input.teamId);
    const res = await q.executeTakeFirst();
    const count = Number(res.numUpdatedRows);
    await this.audit.record({ action: 'calendar.range_cancelled', metadata: { ...input, count } });
    return count;
  }

  async visibleTeamIds(access: TenantAccess, userId: string): Promise<string[]> {
    const v = await this.visibility.forUser(access, userId);
    const rows = await this.ctx.db.selectFrom('teams as t').select('t.id').where(this.visibility.teamsFilter(v)).execute();
    return rows.map((r) => r.id);
  }

  /** Squadre i cui eventi l'utente può gestire, o 'ALL'. */
  async manageableTeams(access: TenantAccess, userId: string): Promise<'ALL' | string[]> {
    if (hasPermission(access, Permission.CalendarManageAll)) return 'ALL';
    return (await this.visibility.forUser(access, userId)).staffTeamIds;
  }

  // --- interni ---------------------------------------------------------------------------------

  /** Genera le occorrenze della serie da `from` in poi; le date già presenti restano invariate. */
  private async generate(seriesId: string, from: string): Promise<number> {
    const res = await sql`
      INSERT INTO events (tenant_id, team_id, series_id, series_date, kind, title, starts_at, ends_at, location, created_by)
      SELECT s.tenant_id, s.team_id, s.id, d::date, s.kind, s.title,
             (d::date + s.start_time) AT TIME ZONE c.timezone,
             (d::date + s.start_time) AT TIME ZONE c.timezone + make_interval(mins => s.duration_minutes),
             s.location, s.created_by
      FROM event_series s
      JOIN clubs c ON c.id = s.tenant_id
      CROSS JOIN LATERAL generate_series(greatest(s.starts_on, ${from}::date), s.ends_on, interval '1 day') AS d
      WHERE s.id = ${seriesId} AND extract(isodow FROM d)::int = ANY(s.weekdays)
      ON CONFLICT (series_id, series_date) DO NOTHING`.execute(this.ctx.db);
    return Number(res.numAffectedRows ?? 0);
  }

  private async seriesBounds(tenantId: string, input: { teamId: string; startsOn?: string | null; endsOn?: string | null }) {
    const season = await this.ctx.db
      .selectFrom('teams as t')
      .innerJoin('seasons as s', 's.id', 't.season_id')
      .select(['s.starts_on', 's.ends_on'])
      .where('t.id', '=', input.teamId)
      .executeTakeFirst();
    if (!season) throw appError('NOT_FOUND');
    const today = await this.today(tenantId);
    const startsOn = input.startsOn ?? maxDate(season.starts_on, today);
    const endsOn = input.endsOn ?? season.ends_on;
    if (endsOn < startsOn) throw appError('BAD_USER_INPUT', 'La fine deve seguire l’inizio');
    if (startsOn < season.starts_on || endsOn > season.ends_on) {
      throw appError('BAD_USER_INPUT', 'La serie deve stare dentro la stagione della squadra');
    }
    return { startsOn, endsOn };
  }

  private async assertCanManageTeam(access: TenantAccess, userId: string, teamId: string): Promise<void> {
    await assertInTenant(this.ctx, 'teams', [teamId]);
    const teams = await this.manageableTeams(access, userId);
    if (teams !== 'ALL' && !teams.includes(teamId)) throw appError('FORBIDDEN');
  }

  /** `teamId` null = evento di società: solo direzione e segreteria. */
  private async assertCanManage(access: TenantAccess, userId: string, teamId: string | null): Promise<void> {
    if (teamId) return this.assertCanManageTeam(access, userId, teamId);
    if (!hasPermission(access, Permission.CalendarManageAll)) throw appError('FORBIDDEN');
  }

  private async loadSeries(id: string): Promise<EventSeriesRow> {
    const row = await this.ctx.db.selectFrom('event_series').selectAll().where('id', '=', id).executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    return row;
  }

  private async loadEvent(access: TenantAccess, userId: string, id: string) {
    await this.event(access, userId, id);
    return this.ctx.db.selectFrom('events').select(['team_id', 'series_id']).where('id', '=', id).executeTakeFirstOrThrow();
  }

  private async oneSeries(access: TenantAccess, userId: string, id: string): Promise<EventSeries> {
    const list = await this.seriesList(access, userId, null);
    const found = list.find((s) => s.id === id);
    if (found) return found;
    // Serie già terminata: non compare tra quelle attive ma va comunque restituita.
    const row = await this.loadSeries(id);
    const team = await this.ctx.db.selectFrom('teams').select('name').where('id', '=', row.team_id).executeTakeFirstOrThrow();
    return toSeries(row, team.name, 0);
  }

  /** Sottoquery degli id delle squadre visibili, da usare con `in`. */
  private visibleTeams(v: Visibility) {
    return this.ctx.db.selectFrom('teams as t').select('t.id').where(this.visibility.teamsFilter(v));
  }

  private baseQuery() {
    return this.ctx.db
      .selectFrom('events as e')
      .leftJoin('teams as t', 't.id', 'e.team_id')
      .select([
        'e.id',
        'e.team_id',
        't.name as team_name',
        't.color as team_color',
        'e.series_id',
        'e.detached',
        'e.kind',
        'e.title',
        'e.starts_at',
        'e.ends_at',
        'e.location',
        'e.notes',
        'e.status',
        'e.cancel_reason',
        'e.opponent',
        'e.is_home',
        'e.competition',
      ]);
  }

  private toModel(r: EventQueryRow, access: TenantAccess, v: Visibility): CalendarEvent {
    const all = hasPermission(access, Permission.CalendarManageAll);
    return {
      id: r.id,
      teamId: r.team_id,
      teamName: r.team_name,
      teamColor: r.team_color,
      seriesId: r.series_id,
      detached: r.detached,
      kind: r.kind as EventKindEnum,
      title: r.title,
      startsAt: r.starts_at,
      endsAt: r.ends_at,
      location: r.location,
      notes: r.notes,
      status: r.status as EventStatusEnum,
      cancelReason: r.cancel_reason,
      opponent: r.opponent,
      isHome: r.is_home,
      competition: r.competition,
      canEdit: all || (r.team_id !== null && v.staffTeamIds.includes(r.team_id)),
    };
  }

  private async today(tenantId: string): Promise<string> {
    const club = await this.ctx.db.selectFrom('clubs').select('timezone').where('id', '=', tenantId).executeTakeFirstOrThrow();
    return todayInZone(club.timezone);
  }
}

function toSeries(r: EventSeriesRow, teamName: string, upcoming: number): EventSeries {
  return {
    id: r.id,
    teamId: r.team_id,
    teamName,
    kind: r.kind as EventKindEnum,
    title: r.title,
    weekdays: r.weekdays,
    startTime: r.start_time.slice(0, 5),
    durationMinutes: r.duration_minutes,
    location: r.location,
    startsOn: r.starts_on,
    endsOn: r.ends_on,
    upcomingCount: upcoming,
  };
}

function eventColumns(input: EventInput) {
  const match = input.kind === 'MATCH';
  return {
    team_id: input.teamId ?? null,
    kind: input.kind,
    title: input.title?.trim() || null,
    starts_at: input.startsAt,
    ends_at: input.endsAt,
    location: input.location?.trim() || null,
    notes: input.notes?.trim() || null,
    opponent: match ? input.opponent?.trim() || null : null,
    is_home: match ? (input.isHome ?? null) : null,
    competition: match ? input.competition?.trim() || null : null,
  };
}

function assertTimes(input: EventInput) {
  if (input.endsAt <= input.startsAt) throw appError('BAD_USER_INPUT', 'La fine deve seguire l’inizio');
  if (input.endsAt.getTime() - input.startsAt.getTime() > 3 * 86_400_000) {
    throw appError('BAD_USER_INPUT', 'Un evento non può durare più di 3 giorni');
  }
}

function assertRange(from: Date, to: Date) {
  if (to <= from) throw appError('BAD_USER_INPUT', 'Intervallo non valido');
  if (to.getTime() - from.getTime() > MAX_RANGE_DAYS * 86_400_000) {
    throw appError('BAD_USER_INPUT', `Al massimo ${MAX_RANGE_DAYS} giorni per richiesta`);
  }
}

const maxDate = (a: string, b: string) => (a > b ? a : b);
const uniqueSorted = (days: number[]) => [...new Set(days)].sort((a, b) => a - b);
