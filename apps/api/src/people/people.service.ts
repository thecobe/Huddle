import { Injectable } from '@nestjs/common';
import { sql } from 'kysely';
import { AuditService } from '../audit/audit.service.js';
import { ageOn, todayInZone } from '../common/dates.js';
import { appError } from '../common/errors.js';
import type {
  GuardianRelationEnum,
  PersonCategoryEnum,
  PersonGenderEnum,
  StaffRoleEnum,
} from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { isValidTaxCode, normalizeTaxCode } from '../common/tax-code.js';
import { DbContext } from '../database/db-context.js';
import type { PersonCategory, PersonRow } from '../database/types.js';
import { hasPermission, Permission } from '../permissions/permissions.js';
import type { PeopleFilter, PeoplePage, Person, PersonContactsInput, PersonInput } from './person.model.js';
import { type Visibility, VisibilityService } from './visibility.service.js';

const ADULT_AGE = 18;

@Injectable()
export class PeopleService {
  constructor(
    private readonly ctx: DbContext,
    private readonly visibility: VisibilityService,
    private readonly audit: AuditService,
  ) {}

  async list(access: TenantAccess, userId: string, filter: PeopleFilter, limit: number, offset: number): Promise<PeoplePage> {
    const v = await this.visibility.forUser(access, userId);
    let q = this.ctx.db.selectFrom('people as p').where(this.visibility.peopleFilter(v));
    if (!filter.includeArchived) q = q.where('p.archived_at', 'is', null);
    if (filter.category) q = q.where(sql<boolean>`${filter.category}::person_category = ANY(p.categories)`);
    if (filter.teamId) {
      const teamId = filter.teamId;
      q = q.where((eb) =>
        eb.or([
          eb('p.id', 'in', eb.selectFrom('team_players').select('person_id').where('team_id', '=', teamId)),
          eb('p.id', 'in', eb.selectFrom('team_staff').select('person_id').where('team_id', '=', teamId)),
        ]),
      );
    }
    const search = filter.search?.trim();
    if (search) {
      const like = `%${search.replace(/[%_\\]/g, (c) => `\\${c}`)}%`;
      q = q.where((eb) =>
        eb.or([
          eb(sql`p.first_name || ' ' || p.last_name`, 'ilike', like),
          eb(sql`p.last_name || ' ' || p.first_name`, 'ilike', like),
          eb('p.email', 'ilike', like),
          eb('p.tax_code', 'ilike', like),
        ]),
      );
    }
    const { total } = await q.select((eb) => eb.fn.countAll<string>().as('total')).executeTakeFirstOrThrow();
    const rows = await q
      .selectAll('p')
      .orderBy(sql`lower(p.last_name)`)
      .orderBy(sql`lower(p.first_name)`)
      .limit(Math.min(Math.max(limit, 1), 200))
      .offset(Math.max(offset, 0))
      .execute();
    return { items: await this.toModels(rows, access, v), total: Number(total) };
  }

  async get(access: TenantAccess, userId: string, id: string): Promise<Person> {
    const v = await this.visibility.forUser(access, userId);
    const row = await this.ctx.db
      .selectFrom('people as p')
      .selectAll('p')
      .where('p.id', '=', id)
      .where(this.visibility.peopleFilter(v))
      .executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    const [person] = await this.toModels([row], access, v);
    return person!;
  }

  /** Scheda dell'utente e dei minori di cui è tutore (profilo nell'app). */
  async mine(access: TenantAccess, userId: string): Promise<Person[]> {
    const v = await this.visibility.forUser(access, userId);
    const ids = [...v.selfPersonIds, ...v.wardPersonIds];
    if (!ids.length) return [];
    const rows = await this.ctx.db
      .selectFrom('people')
      .selectAll()
      .where('id', 'in', ids)
      .where('archived_at', 'is', null)
      .orderBy('birth_date')
      .execute();
    return this.toModels(rows, access, v);
  }

  async create(access: TenantAccess, userId: string, input: PersonInput): Promise<Person> {
    const row = await this.ctx.db
      .insertInto('people')
      .values({ tenant_id: access.tenantId, ...toColumns(input) })
      .returningAll()
      .executeTakeFirstOrThrow()
      .catch(rethrowTaxCode);
    await this.audit.record({ action: 'person.created', entityType: 'person', entityId: row.id });
    return this.get(access, userId, row.id);
  }

  async update(access: TenantAccess, userId: string, id: string, input: PersonInput): Promise<Person> {
    const res = await this.ctx.db
      .updateTable('people')
      .set(toColumns(input))
      .where('id', '=', id)
      .executeTakeFirst()
      .catch(rethrowTaxCode);
    if (res.numUpdatedRows === 0n) throw appError('NOT_FOUND');
    await this.audit.record({ action: 'person.updated', entityType: 'person', entityId: id });
    return this.get(access, userId, id);
  }

  /** Recapiti modificabili anche dalla persona stessa e dai suoi tutori. */
  async updateContacts(access: TenantAccess, userId: string, id: string, input: PersonContactsInput): Promise<Person> {
    const v = await this.visibility.forUser(access, userId);
    const own = v.selfPersonIds.includes(id) || v.wardPersonIds.includes(id);
    if (!own && !hasPermission(access, Permission.PeopleManage)) throw appError('FORBIDDEN');
    await this.ctx.db
      .updateTable('people')
      .set({
        email: input.email?.trim() || null,
        phone: input.phone?.trim() || null,
        address_line: input.addressLine?.trim() || null,
        city: input.city?.trim() || null,
        province: input.province?.toUpperCase() || null,
        postal_code: input.postalCode || null,
      })
      .where('id', '=', id)
      .execute();
    await this.audit.record({ action: 'person.contacts_updated', entityType: 'person', entityId: id });
    return this.get(access, userId, id);
  }

  async setArchived(access: TenantAccess, userId: string, id: string, archived: boolean): Promise<Person> {
    const res = await this.ctx.db
      .updateTable('people')
      .set({ archived_at: archived ? new Date() : null })
      .where('id', '=', id)
      .executeTakeFirst();
    if (res.numUpdatedRows === 0n) throw appError('NOT_FOUND');
    await this.audit.record({ action: archived ? 'person.archived' : 'person.restored', entityType: 'person', entityId: id });
    return this.get(access, userId, id);
  }

  async addGuardian(
    access: TenantAccess,
    userId: string,
    minorId: string,
    guardianId: string,
    relation: GuardianRelationEnum,
  ): Promise<Person> {
    const people = await this.ctx.db
      .selectFrom('people')
      .select(['id', 'categories'])
      .where('id', 'in', [minorId, guardianId])
      .execute();
    if (people.length !== 2) throw appError('NOT_FOUND');
    await this.ctx.db
      .insertInto('guardianships')
      .values({ tenant_id: access.tenantId, minor_person_id: minorId, guardian_person_id: guardianId, relation })
      .execute()
      .catch((err: { code?: string }) => {
        if (err.code === '23505') throw appError('ALREADY_EXISTS');
        if (err.code === '23514') throw appError('BAD_USER_INPUT', 'Una persona non può essere tutore di sé stessa');
        throw err;
      });
    const guardian = people.find((p) => p.id === guardianId)!;
    if (!guardian.categories.includes('GUARDIAN')) {
      await this.ctx.db
        .updateTable('people')
        .set({ categories: [...guardian.categories, 'GUARDIAN'] })
        .where('id', '=', guardianId)
        .execute();
    }
    await this.audit.record({
      action: 'person.guardian_added',
      entityType: 'person',
      entityId: minorId,
      metadata: { guardianId, relation },
    });
    return this.get(access, userId, minorId);
  }

  async removeGuardian(access: TenantAccess, userId: string, guardianshipId: string): Promise<Person> {
    const row = await this.ctx.db
      .deleteFrom('guardianships')
      .where('id', '=', guardianshipId)
      .returning(['minor_person_id', 'guardian_person_id'])
      .executeTakeFirst();
    if (!row) throw appError('NOT_FOUND');
    await this.audit.record({
      action: 'person.guardian_removed',
      entityType: 'person',
      entityId: row.minor_person_id,
      metadata: { guardianId: row.guardian_person_id },
    });
    return this.get(access, userId, row.minor_person_id);
  }

  private async toModels(rows: PersonRow[], access: TenantAccess, v: Visibility): Promise<Person[]> {
    if (!rows.length) return [];
    const ids = rows.map((r) => r.id);
    const club = await this.ctx.db
      .selectFrom('clubs')
      .select('timezone')
      .where('id', '=', access.tenantId)
      .executeTakeFirstOrThrow();
    const today = todayInZone(club.timezone);

    const guardianships = await this.ctx.db
      .selectFrom('guardianships as g')
      .innerJoin('people as gp', 'gp.id', 'g.guardian_person_id')
      .innerJoin('people as mp', 'mp.id', 'g.minor_person_id')
      .select([
        'g.id',
        'g.relation',
        'g.minor_person_id',
        'g.guardian_person_id',
        'gp.first_name as g_first',
        'gp.last_name as g_last',
        'gp.email as g_email',
        'gp.phone as g_phone',
        'mp.first_name as m_first',
        'mp.last_name as m_last',
        'mp.email as m_email',
        'mp.phone as m_phone',
      ])
      .where((eb) => eb.or([eb('g.minor_person_id', 'in', ids), eb('g.guardian_person_id', 'in', ids)]))
      .execute();

    const players = await this.ctx.db
      .selectFrom('team_players as tp')
      .innerJoin('teams as t', 't.id', 'tp.team_id')
      .innerJoin('seasons as s', 's.id', 't.season_id')
      .select(['tp.person_id', 't.id as team_id', 't.name as team_name', 's.name as season_name', 'tp.jersey_number'])
      .where('tp.person_id', 'in', ids)
      .where('t.archived_at', 'is', null)
      .execute();
    const staff = await this.ctx.db
      .selectFrom('team_staff as ts')
      .innerJoin('teams as t', 't.id', 'ts.team_id')
      .innerJoin('seasons as s', 's.id', 't.season_id')
      .select(['ts.person_id', 't.id as team_id', 't.name as team_name', 's.name as season_name', 'ts.role'])
      .where('ts.person_id', 'in', ids)
      .where('t.archived_at', 'is', null)
      .execute();

    const manager = hasPermission(access, Permission.PeopleViewAll);
    return rows.map((r) => {
      const age = r.birth_date ? ageOn(r.birth_date, today) : null;
      // Dati personali completi solo per chi gestisce l'anagrafica, la persona stessa e i suoi tutori.
      const full = manager || v.selfPersonIds.includes(r.id) || v.wardPersonIds.includes(r.id);
      return {
        id: r.id,
        firstName: r.first_name,
        lastName: r.last_name,
        birthDate: r.birth_date,
        birthPlace: full ? r.birth_place : null,
        taxCode: full ? r.tax_code : null,
        gender: r.gender as PersonGenderEnum | null,
        categories: r.categories as PersonCategoryEnum[],
        email: r.email,
        phone: r.phone,
        addressLine: full ? r.address_line : null,
        city: full ? r.city : null,
        province: full ? r.province : null,
        postalCode: full ? r.postal_code : null,
        notes: full ? r.notes : null,
        age,
        isMinor: age !== null && age < ADULT_AGE,
        hasAccount: r.user_id !== null,
        archivedAt: r.archived_at,
        guardians: guardianships
          .filter((g) => g.minor_person_id === r.id)
          .map((g) => ({
            id: g.id,
            relation: g.relation as GuardianRelationEnum,
            person: { id: g.guardian_person_id, firstName: g.g_first, lastName: g.g_last, email: g.g_email, phone: g.g_phone },
          })),
        wards: guardianships
          .filter((g) => g.guardian_person_id === r.id)
          .map((g) => ({
            id: g.id,
            relation: g.relation as GuardianRelationEnum,
            person: { id: g.minor_person_id, firstName: g.m_first, lastName: g.m_last, email: g.m_email, phone: g.m_phone },
          })),
        teams: [
          ...players
            .filter((p) => p.person_id === r.id)
            .map((p) => ({
              teamId: p.team_id,
              teamName: p.team_name,
              seasonName: p.season_name,
              asPlayer: true,
              staffRole: null,
              jerseyNumber: p.jersey_number,
            })),
          ...staff
            .filter((s) => s.person_id === r.id)
            .map((s) => ({
              teamId: s.team_id,
              teamName: s.team_name,
              seasonName: s.season_name,
              asPlayer: false,
              staffRole: s.role as StaffRoleEnum,
              jerseyNumber: null,
            })),
        ],
      };
    });
  }
}

function toColumns(input: PersonInput) {
  let taxCode: string | null = null;
  if (input.taxCode?.trim()) {
    taxCode = normalizeTaxCode(input.taxCode);
    if (!isValidTaxCode(taxCode)) throw appError('BAD_USER_INPUT', 'Codice fiscale non valido');
  }
  return {
    first_name: input.firstName.trim(),
    last_name: input.lastName.trim(),
    birth_date: input.birthDate ?? null,
    birth_place: input.birthPlace?.trim() || null,
    tax_code: taxCode,
    gender: input.gender ?? null,
    categories: (input.categories ?? []) as PersonCategory[],
    email: input.email?.trim() || null,
    phone: input.phone?.trim() || null,
    address_line: input.addressLine?.trim() || null,
    city: input.city?.trim() || null,
    province: input.province?.toUpperCase() || null,
    postal_code: input.postalCode || null,
    notes: input.notes?.trim() || null,
  };
}

function rethrowTaxCode(err: { code?: string; constraint?: string }): never {
  if (err.code === '23505') throw appError('TAX_CODE_TAKEN');
  throw err;
}
