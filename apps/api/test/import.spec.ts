import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createAdminWithClub, createTestApp, type TestApp } from './helpers.js';

const PREVIEW = `mutation ($r: [PersonImportRow!]!) { previewPeopleImport(rows: $r) { index status errors personId } }`;
const COMMIT = `mutation ($r: [PersonImportRow!]!) { commitPeopleImport(rows: $r) { created updated guardiansLinked addedToTeams } }`;

describe('import anagrafiche', () => {
  let t: TestApp;
  let opts: { token: string; tenantId: string };

  beforeAll(async () => {
    t = await createTestApp();
    const admin = await createAdminWithClub(t, 'ASD Import');
    opts = { token: admin.token, tenantId: admin.clubId };
    const season = await t.gql<{ createSeason: { id: string } }>(
      `mutation { createSeason(input: { name: "2026/27", startsOn: "2026-09-01", endsOn: "2027-06-30" }) { id } }`,
      {},
      opts,
    );
    const seasonId = season.data!.createSeason.id;
    await t.gql(`mutation ($id: ID!) { setSeasonStatus(id: $id, status: OPEN) { id } }`, { id: seasonId }, opts);
    await t.gql(`mutation ($s: ID!) { createTeam(input: { seasonId: $s, name: "Under 12" }) { id } }`, { s: seasonId }, opts);
  });
  afterAll(() => t.app.close());

  it('anteprima: segnala gli errori riga per riga e la conferma rifiuta il file', async () => {
    const rows = [
      { firstName: 'Ok', lastName: 'Riga', birthDate: '01/02/2014' },
      { firstName: '', lastName: 'Senza nome', taxCode: 'XXXXXX00X00X000X', teamName: 'Inesistente' },
      { firstName: 'Data', lastName: 'Sbagliata', birthDate: '31/02/2014', email: 'non-una-mail' },
    ];
    const preview = await t.gql<{ previewPeopleImport: { status: string; errors: string[] }[] }>(PREVIEW, { r: rows }, opts);
    const [ok, bad1, bad2] = preview.data!.previewPeopleImport;
    expect(ok).toMatchObject({ status: 'CREATE', errors: [] });
    expect(bad1!.errors.sort()).toEqual(['FIRST_NAME_REQUIRED', 'TAX_CODE_INVALID', 'TEAM_NOT_FOUND']);
    expect(bad2!.errors.sort()).toEqual(['BIRTH_DATE_INVALID', 'EMAIL_INVALID']);

    const commit = await t.gql(COMMIT, { r: rows }, opts);
    expect(commit.errors?.[0]?.extensions?.code).toBe('BAD_USER_INPUT');
    const people = await t.gql<{ people: { total: number } }>(`{ people { total } }`, {}, opts);
    expect(people.data?.people.total).toBe(0);
  });

  it('importa atleti, squadra e tutori; i fratelli condividono il genitore', async () => {
    const parent = { guardianFirstName: 'Laura', guardianLastName: 'Conti', guardianEmail: 'laura.conti@example.test', guardianPhone: '3401112222' };
    const rows: Record<string, unknown>[] = [
      { firstName: 'Tommaso', lastName: 'Conti', birthDate: '2014-04-10', taxCode: 'CNTTMS14D10F205X', teamName: 'under 12', jerseyNumber: 9, ...parent },
      { firstName: 'Elena', lastName: 'Conti', birthDate: '12/09/2014', teamName: 'Under 12', ...parent },
    ];
    const preview = await t.gql<{ previewPeopleImport: { errors: string[] }[] }>(PREVIEW, { r: rows }, opts);
    // Il codice fiscale di esempio non ha il carattere di controllo corretto: viene segnalato.
    expect(preview.data!.previewPeopleImport[0]!.errors).toEqual(['TAX_CODE_INVALID']);

    rows[0]!.taxCode = 'RSSMRA85T10A562S';
    const summary = await t.gql<{ commitPeopleImport: Record<string, number> }>(COMMIT, { r: rows }, opts);
    expect(summary.data?.commitPeopleImport).toEqual({ created: 2, updated: 0, guardiansLinked: 2, addedToTeams: 2 });

    const guardians = await t.gql<{ people: { items: { firstName: string; wards: unknown[]; categories: string[] }[] } }>(
      `{ people(filter: { category: GUARDIAN }) { items { firstName categories wards { id } } } }`,
      {},
      opts,
    );
    expect(guardians.data?.people.items).toEqual([{ firstName: 'Laura', categories: ['GUARDIAN'], wards: [{ id: expect.any(String) }, { id: expect.any(String) }] }]);
  });

  it('riconosce le persone esistenti dal codice fiscale e non cancella i dati presenti', async () => {
    const rows = [{ firstName: 'Tommaso', lastName: 'Conti', taxCode: 'rssmra85t10a562s', phone: '3330001111' }];
    const preview = await t.gql<{ previewPeopleImport: { status: string; personId: string }[] }>(PREVIEW, { r: rows }, opts);
    expect(preview.data!.previewPeopleImport[0]!.status).toBe('UPDATE');

    await t.gql(COMMIT, { r: rows }, opts);
    const person = await t.gql<{ person: { phone: string; birthDate: string } }>(
      `query ($id: ID!) { person(id: $id) { phone birthDate } }`,
      { id: preview.data!.previewPeopleImport[0]!.personId },
      opts,
    );
    expect(person.data?.person).toEqual({ phone: '3330001111', birthDate: '2014-04-10' });
  });

  it('segnala codici fiscali duplicati nello stesso file', async () => {
    const rows = [
      { firstName: 'A', lastName: 'B', taxCode: 'RSSMRA85T10A562S' },
      { firstName: 'C', lastName: 'D', taxCode: 'RSSMRA85T10A562S' },
    ];
    const preview = await t.gql<{ previewPeopleImport: { errors: string[] }[] }>(PREVIEW, { r: rows }, opts);
    expect(preview.data!.previewPeopleImport[1]!.errors).toEqual(['TAX_CODE_DUPLICATED_IN_FILE']);
  });
});
