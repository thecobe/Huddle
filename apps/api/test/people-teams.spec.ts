import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createAdminWithClub, createTestApp, type TestApp, tokenFromMail } from './helpers.js';

const CREATE_PERSON = `mutation ($i: PersonInput!) { createPerson(input: $i) { id taxCode isMinor age } }`;
const CREATE_SEASON = `mutation ($i: SeasonInput!) { createSeason(input: $i) { id } }`;
const CREATE_TEAM = `mutation ($i: TeamInput!) { createTeam(input: $i) { id } }`;
const ADD_PLAYER = `mutation ($t: ID!, $p: ID!, $i: PlayerInput) { addPlayer(teamId: $t, personId: $p, input: $i) { id players { id personId } } }`;
const ADD_STAFF = `mutation ($t: ID!, $p: ID!, $r: StaffRole!) { addStaff(teamId: $t, personId: $p, role: $r) { id staff { id personId } } }`;
const ADD_GUARDIAN = `mutation ($m: ID!, $g: ID!, $r: GuardianRelation!) { addGuardian(minorId: $m, guardianId: $g, relation: $r) { id guardians { id } } }`;
const INVITE_ACCOUNT = `mutation ($p: ID!, $e: String!, $r: MembershipRole!) { invitePersonAccount(personId: $p, email: $e, role: $r) { id } }`;
const ACCEPT = `mutation ($i: AcceptInvitationInput!) { acceptInvitation(input: $i) { accessToken } }`;

/** Data di nascita per una persona che compie `years` anni oggi meno `daysOffset` giorni. */
function birthDateForAge(years: number, daysOffset = 30): string {
  const d = new Date();
  d.setUTCFullYear(d.getUTCFullYear() - years);
  d.setUTCDate(d.getUTCDate() - daysOffset);
  return d.toISOString().slice(0, 10);
}

let seq = 0;
const email = (p: string) => `${p}.${Date.now()}.${seq++}@example.test`;

describe('anagrafiche, squadre e visibilità', () => {
  let t: TestApp;
  let admin: Awaited<ReturnType<typeof createAdminWithClub>>;
  let opts: { token: string; tenantId: string };
  let seasonId: string;

  async function person(input: Record<string, unknown>) {
    const res = await t.gql<{ createPerson: { id: string } }>(CREATE_PERSON, { i: input }, opts);
    if (!res.data) throw new Error(JSON.stringify(res.errors));
    return res.data.createPerson.id;
  }

  async function team(name: string) {
    const res = await t.gql<{ createTeam: { id: string } }>(CREATE_TEAM, { i: { seasonId, name } }, opts);
    if (!res.data) throw new Error(JSON.stringify(res.errors));
    return res.data.createTeam.id;
  }

  /** Invita la persona e accetta l'invito: restituisce il token di accesso del nuovo account. */
  async function activate(personId: string, role: string, by = opts) {
    const to = email(role.toLowerCase());
    const inv = await t.gql(INVITE_ACCOUNT, { p: personId, e: to, r: role }, by);
    if (inv.errors) throw new Error(JSON.stringify(inv.errors));
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === to)!.text);
    const acc = await t.gql<{ acceptInvitation: { accessToken: string } }>(ACCEPT, {
      i: { token, fullName: 'Persona Test', acceptTerms: true },
    });
    if (!acc.data) throw new Error(JSON.stringify(acc.errors));
    return acc.data.acceptInvitation.accessToken;
  }

  beforeAll(async () => {
    t = await createTestApp();
    admin = await createAdminWithClub(t, 'ASD Anagrafiche');
    opts = { token: admin.token, tenantId: admin.clubId };
    const s = await t.gql<{ createSeason: { id: string } }>(
      CREATE_SEASON,
      { i: { name: '2026/27', startsOn: '2026-09-01', endsOn: '2027-06-30' } },
      opts,
    );
    seasonId = s.data!.createSeason.id;
  });
  afterAll(() => t.app.close());

  it('valida il codice fiscale e lo vuole unico nella società', async () => {
    const bad = await t.gql(CREATE_PERSON, { i: { firstName: 'Mario', lastName: 'Rossi', taxCode: 'RSSMRA85T10A562X' } }, opts);
    expect(bad.errors?.[0]?.extensions?.code).toBe('BAD_USER_INPUT');
    const ok = await t.gql<{ createPerson: { taxCode: string } }>(
      CREATE_PERSON,
      { i: { firstName: 'Mario', lastName: 'Rossi', taxCode: 'rssmra85t10a562s' } },
      opts,
    );
    expect(ok.data?.createPerson.taxCode).toBe('RSSMRA85T10A562S');
    const dup = await t.gql(CREATE_PERSON, { i: { firstName: 'Altro', lastName: 'Rossi', taxCode: 'RSSMRA85T10A562S' } }, opts);
    expect(dup.errors?.[0]?.extensions?.code).toBe('TAX_CODE_TAKEN');
  });

  it('calcola età e minore età', async () => {
    const res = await t.gql<{ createPerson: { age: number; isMinor: boolean } }>(
      CREATE_PERSON,
      { i: { firstName: 'Luca', lastName: 'Bianchi', birthDate: birthDateForAge(12) } },
      opts,
    );
    expect(res.data?.createPerson).toMatchObject({ age: 12, isMinor: true });
  });

  it('non collega dati di un’altra società', async () => {
    const other = await createAdminWithClub(t, 'Altra società');
    const otherOpts = { token: other.token, tenantId: other.clubId };
    const foreignPerson = (
      await t.gql<{ createPerson: { id: string } }>(CREATE_PERSON, { i: { firstName: 'Estraneo', lastName: 'X' } }, otherOpts)
    ).data!.createPerson.id;
    const foreignSeason = (
      await t.gql<{ createSeason: { id: string } }>(
        CREATE_SEASON,
        { i: { name: 'Stagione estranea', startsOn: '2026-09-01', endsOn: '2027-06-30' } },
        otherOpts,
      )
    ).data!.createSeason.id;

    const teamId = await team('Esordienti');
    const addForeign = await t.gql(ADD_PLAYER, { t: teamId, p: foreignPerson }, opts);
    expect(addForeign.errors?.[0]?.extensions?.code).toBe('NOT_FOUND');
    const teamInForeignSeason = await t.gql(CREATE_TEAM, { i: { seasonId: foreignSeason, name: 'Intrusa' } }, opts);
    expect(teamInForeignSeason.errors?.[0]?.extensions?.code).toBe('NOT_FOUND');
    const foreignRead = await t.gql(`query ($id: ID!) { person(id: $id) { id } }`, { id: foreignPerson }, opts);
    expect(foreignRead.errors?.[0]?.extensions?.code).toBe('NOT_FOUND');
  });

  it('numero di maglia unico nella squadra', async () => {
    const teamId = await team('Pulcini');
    const a = await person({ firstName: 'A', lastName: 'Uno' });
    const b = await person({ firstName: 'B', lastName: 'Due' });
    await t.gql(ADD_PLAYER, { t: teamId, p: a, i: { jerseyNumber: 10 } }, opts);
    const dup = await t.gql(ADD_PLAYER, { t: teamId, p: b, i: { jerseyNumber: 10 } }, opts);
    expect(dup.errors?.[0]?.extensions?.code).toBe('JERSEY_TAKEN');
  });

  describe('allenatore e genitore', () => {
    let u15: string;
    let u17: string;
    let child: string;
    let otherKid: string;
    let parentPerson: string;
    let coachToken: string;
    let parentToken: string;

    beforeAll(async () => {
      u15 = await team('Under 15');
      u17 = await team('Under 17');
      child = await person({ firstName: 'Giulia', lastName: 'Verdi', birthDate: birthDateForAge(14) });
      otherKid = await person({ firstName: 'Paolo', lastName: 'Neri', birthDate: birthDateForAge(13), notes: 'Nota riservata' });
      const u17Kid = await person({ firstName: 'Sara', lastName: 'Gialli', birthDate: birthDateForAge(16) });
      parentPerson = await person({ firstName: 'Anna', lastName: 'Verdi', phone: '3331234567' });
      const coachPerson = await person({ firstName: 'Marco', lastName: 'Allenatore' });

      await t.gql(ADD_PLAYER, { t: u15, p: child, i: { jerseyNumber: 7 } }, opts);
      await t.gql(ADD_PLAYER, { t: u15, p: otherKid }, opts);
      await t.gql(ADD_PLAYER, { t: u17, p: u17Kid }, opts);
      await t.gql(ADD_GUARDIAN, { m: child, g: parentPerson, r: 'MOTHER' }, opts);
      await t.gql(ADD_STAFF, { t: u15, p: coachPerson, r: 'HEAD_COACH' }, opts);

      coachToken = await activate(coachPerson, 'COACH');
      parentToken = await activate(parentPerson, 'PARENT');
    });

    it('l’allenatore vede la sua squadra, con i recapiti dei tutori ma senza dati riservati', async () => {
      const c = { token: coachToken, tenantId: admin.clubId };
      const teams = await t.gql<{ teams: { name: string }[] }>(`{ teams { name } }`, {}, c);
      expect(teams.data?.teams.map((x) => x.name)).toEqual(['Under 15']);

      const roster = await t.gql<{ team: { players: { personId: string; guardians: { phone: string }[] }[] } }>(
        `query ($id: ID!) { team(id: $id) { players { personId guardians { phone } } } }`,
        { id: u15 },
        c,
      );
      const giulia = roster.data?.team.players.find((p) => p.personId === child);
      expect(giulia?.guardians[0]?.phone).toBe('3331234567');

      const other = await t.gql(`query ($id: ID!) { team(id: $id) { id } }`, { id: u17 }, c);
      expect(other.errors?.[0]?.extensions?.code).toBe('NOT_FOUND');

      const kid = await t.gql<{ person: { notes: string | null; firstName: string } }>(
        `query ($id: ID!) { person(id: $id) { firstName notes } }`,
        { id: otherKid },
        c,
      );
      expect(kid.data?.person).toEqual({ firstName: 'Paolo', notes: null });

      const edit = await t.gql(CREATE_PERSON, { i: { firstName: 'X', lastName: 'Y' } }, c);
      expect(edit.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
    });

    it('il genitore vede sé stesso e la figlia, non gli altri atleti', async () => {
      const p = { token: parentToken, tenantId: admin.clubId };
      const mine = await t.gql<{ myPeople: { id: string; teams: { teamName: string }[] }[] }>(
        `{ myPeople { id teams { teamName } } }`,
        {},
        p,
      );
      expect(mine.data?.myPeople.map((x) => x.id).sort()).toEqual([child, parentPerson].sort());
      expect(mine.data?.myPeople.find((x) => x.id === child)?.teams[0]?.teamName).toBe('Under 15');

      const list = await t.gql<{ people: { total: number } }>(`{ people { total } }`, {}, p);
      expect(list.data?.people.total).toBe(2);

      const other = await t.gql(`query ($id: ID!) { person(id: $id) { id } }`, { id: otherKid }, p);
      expect(other.errors?.[0]?.extensions?.code).toBe('NOT_FOUND');

      const contacts = await t.gql<{ updatePersonContacts: { phone: string } }>(
        `mutation ($id: ID!) { updatePersonContacts(id: $id, input: { phone: "3339999999" }) { phone } }`,
        { id: child },
        p,
      );
      expect(contacts.data?.updatePersonContacts.phone).toBe('3339999999');
      const notMine = await t.gql(
        `mutation ($id: ID!) { updatePersonContacts(id: $id, input: { phone: "3330000000" }) { phone } }`,
        { id: otherKid },
        p,
      );
      expect(notMine.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
    });

    it('D1: il genitore attiva l’account della figlia dai 14 anni, non sotto', async () => {
      const p = { token: parentToken, tenantId: admin.clubId };
      const young = await person({ firstName: 'Piccolo', lastName: 'Verdi', birthDate: birthDateForAge(13) });
      await t.gql(ADD_GUARDIAN, { m: young, g: parentPerson, r: 'MOTHER' }, opts);

      const tooYoung = await t.gql(INVITE_ACCOUNT, { p: young, e: email('piccolo'), r: 'ATHLETE' }, p);
      expect(tooYoung.errors?.[0]?.extensions?.code).toBe('ATHLETE_TOO_YOUNG');

      const notWard = await t.gql(INVITE_ACCOUNT, { p: otherKid, e: email('altro'), r: 'ATHLETE' }, p);
      expect(notWard.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');

      const otherRole = await t.gql(INVITE_ACCOUNT, { p: child, e: email('ruolo'), r: 'COACH' }, p);
      expect(otherRole.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');

      const athleteToken = await activate(child, 'ATHLETE', p);
      const me = await t.gql<{ myPeople: { id: string; hasAccount: boolean }[] }>(
        `{ myPeople { id hasAccount } }`,
        {},
        { token: athleteToken, tenantId: admin.clubId },
      );
      expect(me.data?.myPeople).toEqual([{ id: child, hasAccount: true }]);

      const again = await t.gql(INVITE_ACCOUNT, { p: child, e: email('doppio'), r: 'ATHLETE' }, opts);
      expect(again.errors?.[0]?.extensions?.code).toBe('PERSON_ALREADY_LINKED');
    });

    it('un invito come atleta senza scheda viene rifiutato', async () => {
      const res = await t.gql(
        `mutation ($i: InviteMemberInput!) { inviteMember(input: $i) { id } }`,
        { i: { email: email('senza-scheda'), role: 'ATHLETE' } },
        opts,
      );
      expect(res.errors?.[0]?.extensions?.code).toBe('BAD_USER_INPUT');
    });

    it('togliere l’allenatore dalla squadra gli toglie l’accesso', async () => {
      const assistant = await person({ firstName: 'Vice', lastName: 'Allenatore' });
      const added = await t.gql<{ addStaff: { staff: { id: string; personId: string }[] } }>(
        ADD_STAFF,
        { t: u17, p: assistant, r: 'ASSISTANT_COACH' },
        opts,
      );
      const token = await activate(assistant, 'COACH');
      const c = { token, tenantId: admin.clubId };
      expect((await t.gql<{ teams: { name: string }[] }>(`{ teams { name } }`, {}, c)).data?.teams.map((x) => x.name)).toEqual([
        'Under 17',
      ]);

      const staffId = added.data!.addStaff.staff.find((s) => s.personId === assistant)!.id;
      await t.gql(`mutation ($id: ID!) { removeStaff(staffId: $id) { id } }`, { id: staffId }, opts);
      expect((await t.gql<{ teams: unknown[] }>(`{ teams { name } }`, {}, c)).data?.teams).toEqual([]);
    });
  });

  it('passaggio di stagione: copia squadre e staff, gli atleti solo a richiesta', async () => {
    const teamId = await team('Allievi');
    const coach = await person({ firstName: 'Coach', lastName: 'Copia' });
    const athlete = await person({ firstName: 'Atleta', lastName: 'Copia' });
    await t.gql(ADD_STAFF, { t: teamId, p: coach, r: 'HEAD_COACH' }, opts);
    await t.gql(ADD_PLAYER, { t: teamId, p: athlete }, opts);
    const next = (
      await t.gql<{ createSeason: { id: string } }>(
        CREATE_SEASON,
        { i: { name: '2027/28', startsOn: '2027-09-01', endsOn: '2028-06-30' } },
        opts,
      )
    ).data!.createSeason.id;

    const copied = await t.gql<{ copyTeams: { name: string; playerCount: number; staffCount: number }[] }>(
      `mutation ($i: CopyTeamsInput!) { copyTeams(input: $i) { name playerCount staffCount } }`,
      { i: { fromSeasonId: seasonId, toSeasonId: next, includePlayers: false } },
      opts,
    );
    expect(copied.data?.copyTeams.find((x) => x.name === 'Allievi')).toEqual({ name: 'Allievi', playerCount: 0, staffCount: 1 });
  });

  it('ricerca e paginazione', async () => {
    const res = await t.gql<{ people: { total: number; items: { lastName: string }[] } }>(
      `{ people(filter: { search: "verdi" }, limit: 1) { total items { lastName } } }`,
      {},
      opts,
    );
    expect(res.data?.people.total).toBeGreaterThanOrEqual(2);
    expect(res.data?.people.items).toHaveLength(1);
    expect(res.data?.people.items[0]?.lastName).toBe('Verdi');
  });
});
