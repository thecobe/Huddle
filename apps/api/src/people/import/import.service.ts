import { Injectable } from '@nestjs/common';
import { sql } from 'kysely';
import { AuditService } from '../../audit/audit.service.js';
import { appError } from '../../common/errors.js';
import type { TenantAccess } from '../../common/request-context.js';
import { isValidTaxCode, normalizeTaxCode } from '../../common/tax-code.js';
import { DbContext } from '../../database/db-context.js';
import type { PersonCategory } from '../../database/types.js';
import { ImportRowStatus, type PeopleImportSummary, type PersonImportResult, type PersonImportRow } from './import.model.js';

export const MAX_IMPORT_ROWS = 2000;
const EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface PlannedRow {
  index: number;
  errors: string[];
  existingId: string | null;
  values: {
    first_name: string;
    last_name: string;
    birth_date: string | null;
    birth_place: string | null;
    tax_code: string | null;
    gender: 'F' | 'M' | null;
    email: string | null;
    phone: string | null;
    address_line: string | null;
    city: string | null;
    province: string | null;
    postal_code: string | null;
  };
  teamId: string | null;
  jerseyNumber: number | null;
  guardian: { first_name: string; last_name: string; email: string | null; phone: string | null } | null;
}

/**
 * Import delle anagrafiche. Anteprima e conferma eseguono la stessa validazione; la conferma rifiuta
 * l'intero file se anche una sola riga ha errori, così non restano import a metà.
 * Le persone esistenti si riconoscono dal codice fiscale; i tutori dall'e-mail.
 */
@Injectable()
export class PeopleImportService {
  constructor(
    private readonly ctx: DbContext,
    private readonly audit: AuditService,
  ) {}

  async preview(rows: PersonImportRow[]): Promise<PersonImportResult[]> {
    const plan = await this.plan(rows);
    return plan.map((p) => ({
      index: p.index,
      status: p.errors.length ? ImportRowStatus.ERROR : p.existingId ? ImportRowStatus.UPDATE : ImportRowStatus.CREATE,
      errors: p.errors,
      personId: p.existingId,
    }));
  }

  async commit(access: TenantAccess, rows: PersonImportRow[]): Promise<PeopleImportSummary> {
    const plan = await this.plan(rows);
    if (plan.some((p) => p.errors.length)) throw appError('BAD_USER_INPUT', 'Il file contiene righe con errori');
    const summary = { created: 0, updated: 0, guardiansLinked: 0, addedToTeams: 0 };
    const guardiansByEmail = new Map<string, string>();

    for (const p of plan) {
      let personId: string;
      if (p.existingId) {
        // Aggiorna solo i campi presenti nel file, senza cancellare dati già inseriti a mano.
        const changes = Object.fromEntries(Object.entries(p.values).filter(([, v]) => v !== null));
        await this.ctx.db.updateTable('people').set(changes).where('id', '=', p.existingId).execute();
        personId = p.existingId;
        summary.updated++;
      } else {
        const created = await this.ctx.db
          .insertInto('people')
          .values({ tenant_id: access.tenantId, ...p.values, categories: p.teamId ? ['ATHLETE'] : [] })
          .returning('id')
          .executeTakeFirstOrThrow();
        personId = created.id;
        summary.created++;
      }

      if (p.teamId) {
        const res = await this.ctx.db
          .insertInto('team_players')
          .values({ tenant_id: access.tenantId, team_id: p.teamId, person_id: personId, jersey_number: p.jerseyNumber })
          .onConflict((oc) => oc.doNothing())
          .returning('id')
          .executeTakeFirst();
        if (res) summary.addedToTeams++;
        await this.addCategory(personId, 'ATHLETE');
      }

      if (p.guardian) {
        const key = p.guardian.email?.toLowerCase() ?? `${p.guardian.first_name}|${p.guardian.last_name}|${p.guardian.phone}`;
        let guardianId = guardiansByEmail.get(key) ?? null;
        if (!guardianId && p.guardian.email) {
          const existing = await this.ctx.db.selectFrom('people').select('id').where('email', '=', p.guardian.email).executeTakeFirst();
          guardianId = existing?.id ?? null;
        }
        if (!guardianId) {
          const created = await this.ctx.db
            .insertInto('people')
            .values({ tenant_id: access.tenantId, ...p.guardian, categories: ['GUARDIAN'] })
            .returning('id')
            .executeTakeFirstOrThrow();
          guardianId = created.id;
        }
        guardiansByEmail.set(key, guardianId);
        await this.addCategory(guardianId, 'GUARDIAN');
        const res = await this.ctx.db
          .insertInto('guardianships')
          .values({ tenant_id: access.tenantId, minor_person_id: personId, guardian_person_id: guardianId })
          .onConflict((oc) => oc.doNothing())
          .returning('id')
          .executeTakeFirst();
        if (res) summary.guardiansLinked++;
      }
    }

    await this.audit.record({ action: 'person.imported', metadata: { rows: plan.length, ...summary } });
    return summary;
  }

  private async plan(rows: PersonImportRow[]): Promise<PlannedRow[]> {
    if (rows.length === 0) throw appError('BAD_USER_INPUT', 'Nessuna riga da importare');
    if (rows.length > MAX_IMPORT_ROWS) throw appError('BAD_USER_INPUT', `Al massimo ${MAX_IMPORT_ROWS} righe per import`);

    const openSeason = await this.ctx.db.selectFrom('seasons').select('id').where('status', '=', 'OPEN').executeTakeFirst();
    const teams = openSeason
      ? await this.ctx.db.selectFrom('teams').select(['id', 'name']).where('season_id', '=', openSeason.id).execute()
      : [];
    const teamByName = new Map(teams.map((t) => [t.name.trim().toLowerCase(), t.id]));

    const taxCodes = rows.map((r) => (r.taxCode?.trim() ? normalizeTaxCode(r.taxCode) : null)).filter((c): c is string => !!c);
    const existing = taxCodes.length
      ? await this.ctx.db
          .selectFrom('people')
          .select(['id', sql<string>`upper(tax_code)`.as('tax_code')])
          .where(sql`upper(tax_code)`, 'in', taxCodes)
          .execute()
      : [];
    const existingByCode = new Map(existing.map((e) => [e.tax_code, e.id]));
    const seenCodes = new Map<string, number>();

    return rows.map((r, index) => {
      const errors: string[] = [];
      const firstName = clean(r.firstName);
      const lastName = clean(r.lastName);
      if (!firstName) errors.push('FIRST_NAME_REQUIRED');
      if (!lastName) errors.push('LAST_NAME_REQUIRED');

      const birthDate = parseDate(r.birthDate);
      if (clean(r.birthDate) && !birthDate) errors.push('BIRTH_DATE_INVALID');

      let taxCode: string | null = null;
      if (clean(r.taxCode)) {
        taxCode = normalizeTaxCode(r.taxCode!);
        if (!isValidTaxCode(taxCode)) errors.push('TAX_CODE_INVALID');
        else if (seenCodes.has(taxCode)) errors.push('TAX_CODE_DUPLICATED_IN_FILE');
        seenCodes.set(taxCode, index);
      }

      const genderRaw = clean(r.gender)?.toUpperCase() ?? null;
      const gender = genderRaw === 'F' || genderRaw === 'M' ? genderRaw : null;
      if (genderRaw && !gender) errors.push('GENDER_INVALID');

      const email = clean(r.email);
      if (email && !EMAIL.test(email)) errors.push('EMAIL_INVALID');
      const province = clean(r.province)?.toUpperCase() ?? null;
      if (province && !/^[A-Z]{2}$/.test(province)) errors.push('PROVINCE_INVALID');
      const postalCode = clean(r.postalCode);
      if (postalCode && !/^[0-9]{5}$/.test(postalCode)) errors.push('POSTAL_CODE_INVALID');

      let teamId: string | null = null;
      const teamName = clean(r.teamName);
      if (teamName) {
        if (!openSeason) errors.push('NO_OPEN_SEASON');
        else {
          teamId = teamByName.get(teamName.toLowerCase()) ?? null;
          if (!teamId) errors.push('TEAM_NOT_FOUND');
        }
      }

      let guardian: PlannedRow['guardian'] = null;
      const gFirst = clean(r.guardianFirstName);
      const gLast = clean(r.guardianLastName);
      const gEmail = clean(r.guardianEmail);
      const gPhone = clean(r.guardianPhone);
      if (gFirst || gLast || gEmail || gPhone) {
        if (!gFirst || !gLast) errors.push('GUARDIAN_NAME_REQUIRED');
        if (gEmail && !EMAIL.test(gEmail)) errors.push('GUARDIAN_EMAIL_INVALID');
        if (gFirst && gLast) guardian = { first_name: gFirst, last_name: gLast, email: gEmail, phone: gPhone };
      }

      return {
        index,
        errors,
        existingId: taxCode ? (existingByCode.get(taxCode) ?? null) : null,
        values: {
          first_name: firstName ?? '',
          last_name: lastName ?? '',
          birth_date: birthDate,
          birth_place: clean(r.birthPlace),
          tax_code: taxCode,
          gender,
          email,
          phone: clean(r.phone),
          address_line: clean(r.addressLine),
          city: clean(r.city),
          province,
          postal_code: postalCode,
        },
        teamId,
        jerseyNumber: r.jerseyNumber ?? null,
        guardian,
      };
    });
  }

  private async addCategory(personId: string, category: PersonCategory): Promise<void> {
    await this.ctx.db
      .updateTable('people')
      .set({ categories: sql`array_append(categories, ${category}::person_category)` })
      .where('id', '=', personId)
      .where(sql<boolean>`NOT (${category}::person_category = ANY(categories))`)
      .execute();
  }
}

function clean(value: string | undefined | null): string | null {
  const v = value?.trim();
  return v ? v : null;
}

/** Accetta YYYY-MM-DD e GG/MM/AAAA (formato tipico dei fogli Excel italiani). */
export function parseDate(value: string | undefined | null): string | null {
  const v = clean(value);
  if (!v) return null;
  let y: number, m: number, d: number;
  const iso = v.match(/^(\d{4})-(\d{1,2})-(\d{1,2})$/);
  const it = v.match(/^(\d{1,2})[/.-](\d{1,2})[/.-](\d{4})$/);
  if (iso) [y, m, d] = [Number(iso[1]), Number(iso[2]), Number(iso[3])];
  else if (it) [d, m, y] = [Number(it[1]), Number(it[2]), Number(it[3])];
  else return null;
  const date = new Date(Date.UTC(y, m - 1, d));
  if (date.getUTCFullYear() !== y || date.getUTCMonth() !== m - 1 || date.getUTCDate() !== d) return null;
  return `${y}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
}
