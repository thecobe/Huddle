import request from 'supertest';
import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createAdminWithClub, createTestApp, type TestApp, tokenFromMail } from './helpers.js';

const SERIES_FIELDS = 'id weekdays startTime durationMinutes startsOn endsOn upcomingCount';
const EVENT_FIELDS = 'id teamId kind title startsAt endsAt status seriesId detached canEdit opponent isHome';

type Ev = { id: string; startsAt: string; endsAt: string; status: string; detached: boolean; teamId: string | null; kind: string };

describe('calendario', () => {
  let t: TestApp;
  let opts: { token: string; tenantId: string };
  let clubId: string;
  let u15: string;
  let u17: string;
  let coachOpts: { token: string; tenantId: string };
  let parentOpts: { token: string; tenantId: string };

  const gql = async <T>(q: string, v: Record<string, unknown> = {}, o = opts) => {
    const res = await t.gql<T>(q, v, o);
    if (!res.data) throw new Error(JSON.stringify(res.errors));
    return res.data;
  };
  const events = (from: string, to: string, o = opts, teamId?: string) =>
    gql<{ events: Ev[] }>(
      `query ($f: DateTime!, $t: DateTime!, $team: ID) { events(from: $f, to: $t, teamId: $team) { ${EVENT_FIELDS} } }`,
      { f: from, t: to, team: teamId },
      o,
    ).then((d) => d.events);

  async function activate(personId: string, role: string) {
    const email = `${role.toLowerCase()}.${Date.now()}.${Math.random().toString(36).slice(2)}@example.test`;
    await gql(`mutation ($p: ID!, $e: String!, $r: MembershipRole!) { invitePersonAccount(personId: $p, email: $e, role: $r) { id } }`, {
      p: personId,
      e: email,
      r: role,
    });
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === email)!.text);
    const acc = await t.gql<{ acceptInvitation: { accessToken: string } }>(
      `mutation ($i: AcceptInvitationInput!) { acceptInvitation(input: $i) { accessToken } }`,
      { i: { token, fullName: 'Test', acceptTerms: true } },
    );
    return { token: acc.data!.acceptInvitation.accessToken, tenantId: clubId };
  }

  const person = (input: Record<string, unknown>) =>
    gql<{ createPerson: { id: string } }>(`mutation ($i: PersonInput!) { createPerson(input: $i) { id } }`, { i: input }).then(
      (d) => d.createPerson.id,
    );

  beforeAll(async () => {
    t = await createTestApp();
    const admin = await createAdminWithClub(t, 'ASD Calendario');
    clubId = admin.clubId;
    opts = { token: admin.token, tenantId: clubId };
    // Stagione futura: i test non dipendono dalla data di oggi.
    const season = await gql<{ createSeason: { id: string } }>(
      `mutation { createSeason(input: { name: "2027/28", startsOn: "2027-09-01", endsOn: "2028-06-30" }) { id } }`,
    );
    const team = (name: string) =>
      gql<{ createTeam: { id: string } }>(`mutation ($i: TeamInput!) { createTeam(input: $i) { id } }`, {
        i: { seasonId: season.createSeason.id, name },
      }).then((d) => d.createTeam.id);
    u15 = await team('Under 15');
    u17 = await team('Under 17');

    const coach = await person({ firstName: 'Coach', lastName: 'U15' });
    await gql(`mutation ($t: ID!, $p: ID!) { addStaff(teamId: $t, personId: $p, role: HEAD_COACH) { id } }`, { t: u15, p: coach });
    coachOpts = await activate(coach, 'COACH');

    const kid = await person({ firstName: 'Kid', lastName: 'U15', birthDate: '2013-05-05' });
    const parent = await person({ firstName: 'Parent', lastName: 'U15' });
    await gql(`mutation ($t: ID!, $p: ID!) { addPlayer(teamId: $t, personId: $p) { id } }`, { t: u15, p: kid });
    await gql(`mutation ($m: ID!, $g: ID!) { addGuardian(minorId: $m, guardianId: $g, relation: MOTHER) { id } }`, { m: kid, g: parent });
    parentOpts = await activate(parent, 'PARENT');
  });
  afterAll(() => t.app.close());

  it('genera le occorrenze settimanali con l’ora locale corretta anche dopo il cambio dell’ora legale', async () => {
    const s = await gql<{ createEventSeries: { upcomingCount: number; startsOn: string; endsOn: string } }>(
      `mutation ($i: SeriesInput!) { createEventSeries(input: $i) { ${SERIES_FIELDS} } }`,
      { i: { teamId: u15, weekdays: [1, 3], startTime: '18:00', durationMinutes: 90, location: 'Campo comunale' } },
    );
    expect(s.createEventSeries).toMatchObject({ startsOn: '2027-09-01', endsOn: '2028-06-30' });
    // Lunedì e mercoledì tra 1/9/2027 e 30/6/2028.
    expect(s.createEventSeries.upcomingCount).toBe(87);

    const list = await events('2027-10-25T00:00:00Z', '2027-11-02T00:00:00Z', opts, u15);
    // Ora legale fino al 31/10/2027: 18:00 a Roma = 16:00 UTC, poi 17:00 UTC.
    expect(list.map((e) => e.startsAt)).toEqual([
      '2027-10-25T16:00:00.000Z',
      '2027-10-27T16:00:00.000Z',
      '2027-11-01T17:00:00.000Z',
    ]);
    expect(list[0]!.endsAt).toBe('2027-10-25T17:30:00.000Z');
  });

  it('modificare la serie non tocca le date modificate o annullate a mano', async () => {
    const created = await gql<{ createEventSeries: { id: string } }>(
      `mutation ($i: SeriesInput!) { createEventSeries(input: $i) { id } }`,
      { i: { teamId: u17, weekdays: [2], startTime: '17:00', durationMinutes: 60, startsOn: '2027-09-01', endsOn: '2027-12-31' } },
    );
    const seriesId = created.createEventSeries.id;
    const sept = await events('2027-09-01T00:00:00Z', '2027-10-01T00:00:00Z', opts, u17);
    expect(sept).toHaveLength(4);
    await gql(`mutation ($id: ID!) { setEventCancelled(id: $id, cancelled: true, reason: "Festa") { id } }`, { id: sept[1]!.id });

    await gql(`mutation ($id: ID!, $i: SeriesInput!, $f: String) { updateEventSeries(id: $id, input: $i, fromDate: $f) { id } }`, {
      id: seriesId,
      i: { teamId: u17, weekdays: [2], startTime: '19:00', durationMinutes: 60, startsOn: '2027-09-01', endsOn: '2027-12-31' },
      f: '2027-09-01',
    });
    const after = await events('2027-09-01T00:00:00Z', '2027-10-01T00:00:00Z', opts, u17);
    expect(after).toHaveLength(4);
    expect(after.find((e) => e.id === sept[1]!.id)).toMatchObject({ status: 'CANCELLED', detached: true });
    // Le altre seguono il nuovo orario (19:00 a Roma = 17:00 UTC in settembre).
    expect(after.filter((e) => e.status === 'SCHEDULED').every((e) => e.startsAt.endsWith('T17:00:00.000Z'))).toBe(true);

    await gql(`mutation ($id: ID!) { endEventSeries(id: $id, fromDate: "2027-10-01") }`, { id: seriesId });
    expect(await events('2027-10-01T00:00:00Z', '2028-01-01T00:00:00Z', opts, u17)).toHaveLength(0);
  });

  it('annulla tutti gli eventi in un periodo di chiusura', async () => {
    const count = await gql<{ cancelEventsInRange: number }>(
      `mutation { cancelEventsInRange(input: { fromDate: "2027-12-24", toDate: "2028-01-06", reason: "Vacanze di Natale" }) }`,
    );
    expect(count.cancelEventsInRange).toBe(4);
    const xmas = await events('2027-12-24T00:00:00Z', '2028-01-07T00:00:00Z', opts, u15);
    expect(xmas.every((e) => e.status === 'CANCELLED')).toBe(true);
  });

  it('gare: i campi della partita valgono solo per le gare', async () => {
    const res = await gql<{ createEvent: { kind: string; opponent: string; isHome: boolean } }>(
      `mutation ($i: EventInput!) { createEvent(input: $i) { ${EVENT_FIELDS} } }`,
      {
        i: {
          teamId: u15,
          kind: 'MATCH',
          startsAt: '2027-10-09T13:00:00Z',
          endsAt: '2027-10-09T15:00:00Z',
          opponent: 'ASD Rivali',
          isHome: true,
          competition: 'Campionato provinciale',
        },
      },
    );
    expect(res.createEvent).toMatchObject({ kind: 'MATCH', opponent: 'ASD Rivali', isHome: true });
    const other = await gql<{ createEvent: { opponent: string | null } }>(
      `mutation ($i: EventInput!) { createEvent(input: $i) { opponent } }`,
      { i: { teamId: u15, kind: 'OTHER', title: 'Riunione', startsAt: '2027-10-10T17:00:00Z', endsAt: '2027-10-10T18:00:00Z', opponent: 'X' } },
    );
    expect(other.createEvent.opponent).toBeNull();
  });

  it('l’allenatore gestisce solo il calendario delle sue squadre', async () => {
    const own = await t.gql(`mutation ($i: SeriesInput!) { createEventSeries(input: $i) { id } }`, {
      i: { teamId: u15, weekdays: [5], startTime: '18:30', durationMinutes: 60, startsOn: '2027-09-01', endsOn: '2027-09-30' },
    }, coachOpts);
    expect(own.errors).toBeUndefined();
    const other = await t.gql(`mutation ($i: SeriesInput!) { createEventSeries(input: $i) { id } }`, {
      i: { teamId: u17, weekdays: [5], startTime: '18:30', durationMinutes: 60 },
    }, coachOpts);
    expect(other.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
    const clubWide = await t.gql(`mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: { kind: 'OTHER', title: 'Festa', startsAt: '2027-12-20T18:00:00Z', endsAt: '2027-12-20T22:00:00Z' },
    }, coachOpts);
    expect(clubWide.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
  });

  it('agenda del genitore: squadra della figlia ed eventi di società, non le altre squadre', async () => {
    await gql(`mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: { kind: 'OTHER', title: 'Festa di società', startsAt: '2027-09-20T17:00:00Z', endsAt: '2027-09-20T21:00:00Z' },
    });
    const agenda = await gql<{ myAgenda: Ev[] }>(
      `query { myAgenda(from: "2027-09-01T00:00:00Z", to: "2027-10-01T00:00:00Z") { ${EVENT_FIELDS} } }`,
      {},
      parentOpts,
    );
    expect(agenda.myAgenda.length).toBeGreaterThan(0);
    expect(agenda.myAgenda.every((e) => e.teamId === u15 || e.teamId === null)).toBe(true);
    expect(agenda.myAgenda.some((e) => e.teamId === null)).toBe(true);
    expect(agenda.myAgenda.every((e) => !(e as unknown as { canEdit: boolean }).canEdit)).toBe(true);

    const u17Events = await t.gql(`query ($t: ID!) { events(from: "2027-09-01T00:00:00Z", to: "2027-10-01T00:00:00Z", teamId: $t) { id } }`, { t: u17 }, parentOpts);
    expect(u17Events.data).toEqual({ events: [] });
  });

  it('limita l’intervallo delle richieste', async () => {
    const res = await t.gql(`{ events(from: "2027-09-01T00:00:00Z", to: "2028-06-30T00:00:00Z") { id } }`, {}, opts);
    expect(res.errors?.[0]?.extensions?.code).toBe('BAD_USER_INPUT');
  });

  it('link iCal personale: mostra solo ciò che l’utente vede ed è revocabile', async () => {
    // Il feed copre un anno da oggi: crea un evento vicino nel tempo per la squadra della figlia.
    const soon = new Date(Date.now() + 7 * 86_400_000);
    await gql(`mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: { teamId: u15, kind: 'MATCH', opponent: 'Squadra, Ospite', startsAt: soon.toISOString(), endsAt: new Date(soon.getTime() + 7_200_000).toISOString() },
    });
    await gql(`mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: { teamId: u17, kind: 'TRAINING', title: 'Segreto U17', startsAt: soon.toISOString(), endsAt: new Date(soon.getTime() + 3_600_000).toISOString() },
    });

    const feed = await gql<{ createCalendarFeed: { url: string } }>(`mutation { createCalendarFeed { url } }`, {}, parentOpts);
    const path = new URL(feed.createCalendarFeed.url).pathname;
    const res = await request(t.app.getHttpServer()).get(path);
    expect(res.status).toBe(200);
    expect(res.headers['content-type']).toContain('text/calendar');
    expect(res.text).toContain('SUMMARY:Gara vs Squadra\\, Ospite · Under 15');
    expect(res.text).not.toContain('Segreto U17');

    await gql(`mutation { revokeCalendarFeed }`, {}, parentOpts);
    expect((await request(t.app.getHttpServer()).get(path)).status).toBe(404);
  });
});
