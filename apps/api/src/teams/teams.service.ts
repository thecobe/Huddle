import { Injectable } from '@nestjs/common';
import { AuditService } from '../audit/audit.service.js';
import { appError } from '../common/errors.js';
import type { GuardianRelationEnum, PlayerAvailabilityEnum, StaffRoleEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import { assertInTenant } from '../database/tenant-guard.js';
import type { StaffRole } from '../database/types.js';
import { MembersService } from '../members/members.service.js';
import { VisibilityService } from '../people/visibility.service.js';
import type { CopyTeamsInput, PlayerInput, Team, TeamDetail, TeamInput } from './team.model.js';

@Injectable()
export class TeamsService {
  constructor(
    private readonly ctx: DbContext,
    private readonly visibility: VisibilityService,
    private readonly members: MembersService,
    private readonly audit: AuditService,
  ) {}

  async list(access: TenantAccess, userId: string, seasonId: string | null, includeArchived: boolean): Promise<Team[]> {
    const v = await this.visibility.forUser(access, userId);
    let q = this.baseQuery().where(this.visibility.teamsFilter(v));
    if (seasonId) q = q.where('t.season_id', '=', seasonId);
    if (!includeArchived) q = q.where('t.archived_at', 'is', null);
    const rows = await q.orderBy('s.starts_on', 'desc').orderBy('t.name').execute();
    return rows.map(toTeam);
  }

  async get(access: TenantAccess, userId: string, id: string): Promise<TeamDetail> {
    const v = await this.visibility.forUser(access, userId);
    const row = await this.baseQuery().where('t.id', '=', id).where(this.visibility.teamsFilter(v)).executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');

    const players = await this.ctx.db
      .selectFrom('team_players as tp')
      .innerJoin('people as p', 'p.id', 'tp.person_id')
      .select([
        'tp.id',
        'tp.person_id',
        'p.first_name',
        'p.last_name',
        'p.birth_date',
        'p.email',
        'p.phone',
        'tp.jersey_number',
        'tp.position',
        'tp.availability',
        'tp.availability_note',
      ])
      .where('tp.team_id', '=', id)
      .orderBy('tp.jersey_number')
      .orderBy('p.last_name')
      .execute();
    const guardians = players.length
      ? await this.ctx.db
          .selectFrom('guardianships as g')
          .innerJoin('people as gp', 'gp.id', 'g.guardian_person_id')
          .select(['g.minor_person_id', 'g.guardian_person_id', 'g.relation', 'gp.first_name', 'gp.last_name', 'gp.email', 'gp.phone'])
          .where('g.minor_person_id', 'in', players.map((p) => p.person_id))
          .execute()
      : [];
    const staff = await this.ctx.db
      .selectFrom('team_staff as ts')
      .innerJoin('people as p', 'p.id', 'ts.person_id')
      .select(['ts.id', 'ts.person_id', 'p.first_name', 'p.last_name', 'p.email', 'p.phone', 'p.user_id', 'ts.role'])
      .where('ts.team_id', '=', id)
      .orderBy('ts.role')
      .orderBy('p.last_name')
      .execute();

    return {
      ...toTeam(row),
      players: players.map((p) => ({
        id: p.id,
        personId: p.person_id,
        firstName: p.first_name,
        lastName: p.last_name,
        birthDate: p.birth_date,
        jerseyNumber: p.jersey_number,
        position: p.position,
        availability: p.availability as PlayerAvailabilityEnum,
        availabilityNote: p.availability_note,
        email: p.email,
        phone: p.phone,
        guardians: guardians
          .filter((g) => g.minor_person_id === p.person_id)
          .map((g) => ({
            personId: g.guardian_person_id,
            name: `${g.first_name} ${g.last_name}`,
            relation: g.relation as GuardianRelationEnum,
            email: g.email,
            phone: g.phone,
          })),
      })),
      staff: staff.map((s) => ({
        id: s.id,
        personId: s.person_id,
        firstName: s.first_name,
        lastName: s.last_name,
        role: s.role as StaffRoleEnum,
        email: s.email,
        phone: s.phone,
        hasAccount: s.user_id !== null,
      })),
    };
  }

  async create(access: TenantAccess, userId: string, input: TeamInput): Promise<TeamDetail> {
    assertYears(input);
    await assertInTenant(this.ctx, 'seasons', [input.seasonId]);
    const row = await this.ctx.db
      .insertInto('teams')
      .values({ tenant_id: access.tenantId, ...toColumns(input) })
      .returning('id')
      .executeTakeFirstOrThrow()
      .catch(rethrowDuplicate);
    await this.audit.record({ action: 'team.created', entityType: 'team', entityId: row.id });
    return this.get(access, userId, row.id);
  }

  async update(access: TenantAccess, userId: string, id: string, input: TeamInput): Promise<TeamDetail> {
    assertYears(input);
    await assertInTenant(this.ctx, 'seasons', [input.seasonId]);
    const res = await this.ctx.db
      .updateTable('teams')
      .set(toColumns(input))
      .where('id', '=', id)
      .executeTakeFirst()
      .catch(rethrowDuplicate);
    if (res.numUpdatedRows === 0n) throw appError('NOT_FOUND');
    await this.audit.record({ action: 'team.updated', entityType: 'team', entityId: id });
    return this.get(access, userId, id);
  }

  async setArchived(access: TenantAccess, userId: string, id: string, archived: boolean): Promise<TeamDetail> {
    const res = await this.ctx.db
      .updateTable('teams')
      .set({ archived_at: archived ? new Date() : null })
      .where('id', '=', id)
      .executeTakeFirst();
    if (res.numUpdatedRows === 0n) throw appError('NOT_FOUND');
    await this.audit.record({ action: archived ? 'team.archived' : 'team.restored', entityType: 'team', entityId: id });
    return this.get(access, userId, id);
  }

  /** Passaggio di stagione: copia squadre e staff, e a richiesta gli atleti. Salta le squadre già presenti. */
  async copy(access: TenantAccess, userId: string, input: CopyTeamsInput): Promise<Team[]> {
    if (input.fromSeasonId === input.toSeasonId) throw appError('BAD_USER_INPUT', 'Stagioni uguali');
    await assertInTenant(this.ctx, 'seasons', [input.fromSeasonId, input.toSeasonId]);
    const source = await this.ctx.db
      .selectFrom('teams')
      .selectAll()
      .where('season_id', '=', input.fromSeasonId)
      .where('archived_at', 'is', null)
      .execute();
    const existing = new Set(
      (await this.ctx.db.selectFrom('teams').select('name').where('season_id', '=', input.toSeasonId).execute()).map((t) => t.name),
    );
    const touchedPeople = new Set<string>();
    for (const team of source.filter((t) => !existing.has(t.name))) {
      const created = await this.ctx.db
        .insertInto('teams')
        .values({
          tenant_id: access.tenantId,
          season_id: input.toSeasonId,
          name: team.name,
          category: team.category,
          birth_year_from: team.birth_year_from,
          birth_year_to: team.birth_year_to,
          color: team.color,
        })
        .returning('id')
        .executeTakeFirstOrThrow();
      const staff = await this.ctx.db.selectFrom('team_staff').select(['person_id', 'role']).where('team_id', '=', team.id).execute();
      for (const s of staff) {
        await this.ctx.db
          .insertInto('team_staff')
          .values({ tenant_id: access.tenantId, team_id: created.id, person_id: s.person_id, role: s.role })
          .execute();
        touchedPeople.add(s.person_id);
      }
      if (input.includePlayers) {
        await this.ctx.db
          .insertInto('team_players')
          .columns(['tenant_id', 'team_id', 'person_id', 'jersey_number', 'position'])
          .expression((eb) =>
            eb
              .selectFrom('team_players')
              .select([
                eb.val(access.tenantId).as('tenant_id'),
                eb.val(created.id).as('team_id'),
                'person_id',
                'jersey_number',
                'position',
              ])
              .where('team_id', '=', team.id),
          )
          .execute();
      }
    }
    for (const personId of touchedPeople) await this.members.syncStaffMemberships(personId);
    await this.audit.record({
      action: 'team.season_copied',
      metadata: { fromSeasonId: input.fromSeasonId, toSeasonId: input.toSeasonId, includePlayers: input.includePlayers },
    });
    return this.list(access, userId, input.toSeasonId, false);
  }

  async addPlayer(access: TenantAccess, userId: string, teamId: string, personId: string, input: PlayerInput): Promise<TeamDetail> {
    await assertInTenant(this.ctx, 'teams', [teamId]);
    await assertInTenant(this.ctx, 'people', [personId]);
    await this.ctx.db
      .insertInto('team_players')
      .values({
        tenant_id: access.tenantId,
        team_id: teamId,
        person_id: personId,
        jersey_number: input.jerseyNumber ?? null,
        position: input.position?.trim() || null,
      })
      .execute()
      .catch(rethrowRoster);
    await this.ensureCategory(personId, 'ATHLETE');
    await this.audit.record({ action: 'team.player_added', entityType: 'team', entityId: teamId, metadata: { personId } });
    return this.get(access, userId, teamId);
  }

  async updatePlayer(access: TenantAccess, userId: string, rosterId: string, input: PlayerInput): Promise<TeamDetail> {
    const row = await this.ctx.db
      .updateTable('team_players')
      .set({ jersey_number: input.jerseyNumber ?? null, position: input.position?.trim() || null })
      .where('id', '=', rosterId)
      .returning('team_id')
      .executeTakeFirst()
      .catch(rethrowRoster);
    if (!row) throw appError('NOT_FOUND');
    return this.get(access, userId, row.team_id);
  }

  async removePlayer(access: TenantAccess, userId: string, rosterId: string): Promise<TeamDetail> {
    const row = await this.ctx.db
      .deleteFrom('team_players')
      .where('id', '=', rosterId)
      .returning(['team_id', 'person_id'])
      .executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    await this.audit.record({
      action: 'team.player_removed',
      entityType: 'team',
      entityId: row.team_id,
      metadata: { personId: row.person_id },
    });
    return this.get(access, userId, row.team_id);
  }

  async addStaff(access: TenantAccess, userId: string, teamId: string, personId: string, role: StaffRoleEnum): Promise<TeamDetail> {
    await assertInTenant(this.ctx, 'teams', [teamId]);
    await assertInTenant(this.ctx, 'people', [personId]);
    await this.ctx.db
      .insertInto('team_staff')
      .values({ tenant_id: access.tenantId, team_id: teamId, person_id: personId, role: role as StaffRole })
      .execute()
      .catch(rethrowRoster);
    await this.ensureCategory(personId, 'STAFF');
    await this.members.syncStaffMemberships(personId);
    await this.audit.record({ action: 'team.staff_added', entityType: 'team', entityId: teamId, metadata: { personId, role } });
    return this.get(access, userId, teamId);
  }

  async removeStaff(access: TenantAccess, userId: string, staffId: string): Promise<TeamDetail> {
    const row = await this.ctx.db
      .deleteFrom('team_staff')
      .where('id', '=', staffId)
      .returning(['team_id', 'person_id', 'role'])
      .executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    await this.members.syncStaffMemberships(row.person_id);
    await this.audit.record({
      action: 'team.staff_removed',
      entityType: 'team',
      entityId: row.team_id,
      metadata: { personId: row.person_id, role: row.role },
    });
    return this.get(access, userId, row.team_id);
  }

  private baseQuery() {
    return this.ctx.db
      .selectFrom('teams as t')
      .innerJoin('seasons as s', 's.id', 't.season_id')
      .selectAll('t')
      .select('s.name as season_name')
      .select((eb) => [
        eb.selectFrom('team_players').select(eb.fn.countAll<string>().as('n')).whereRef('team_id', '=', 't.id').as('player_count'),
        eb.selectFrom('team_staff').select(eb.fn.countAll<string>().as('n')).whereRef('team_id', '=', 't.id').as('staff_count'),
      ]);
  }

  private async ensureCategory(personId: string, category: 'ATHLETE' | 'STAFF'): Promise<void> {
    const person = await this.ctx.db.selectFrom('people').select('categories').where('id', '=', personId).executeTakeFirst();
    if (person && !person.categories.includes(category)) {
      await this.ctx.db
        .updateTable('people')
        .set({ categories: [...person.categories, category] })
        .where('id', '=', personId)
        .execute();
    }
  }
}

type TeamQueryRow = {
  id: string;
  season_id: string;
  season_name: string;
  name: string;
  category: string | null;
  birth_year_from: number | null;
  birth_year_to: number | null;
  color: string | null;
  archived_at: Date | null;
  player_count: string | null;
  staff_count: string | null;
};

function toTeam(r: TeamQueryRow): Team {
  return {
    id: r.id,
    seasonId: r.season_id,
    seasonName: r.season_name,
    name: r.name,
    category: r.category,
    birthYearFrom: r.birth_year_from,
    birthYearTo: r.birth_year_to,
    color: r.color,
    playerCount: Number(r.player_count ?? 0),
    staffCount: Number(r.staff_count ?? 0),
    archivedAt: r.archived_at,
  };
}

function toColumns(input: TeamInput) {
  return {
    season_id: input.seasonId,
    name: input.name.trim(),
    category: input.category?.trim() || null,
    birth_year_from: input.birthYearFrom ?? null,
    birth_year_to: input.birthYearTo ?? null,
    color: input.color ?? null,
  };
}

function assertYears(input: TeamInput) {
  if (input.birthYearFrom && input.birthYearTo && input.birthYearFrom > input.birthYearTo) {
    throw appError('BAD_USER_INPUT', 'Anni di nascita non validi');
  }
}

function rethrowDuplicate(err: { code?: string }): never {
  if (err.code === '23505') throw appError('ALREADY_EXISTS', 'Esiste già una squadra con questo nome nella stagione');
  throw err;
}

function rethrowRoster(err: { code?: string; constraint?: string }): never {
  if (err.code === '23505') {
    throw appError(err.constraint === 'team_players_jersey_idx' ? 'JERSEY_TAKEN' : 'ALREADY_EXISTS');
  }
  if (err.code === '23503') throw appError('NOT_FOUND');
  throw err;
}
