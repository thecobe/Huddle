import { randomUUID } from 'node:crypto';
import pg from 'pg';
import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createAdminWithClub, createTestApp, type TestApp, tokenFromMail } from './helpers.js';

const HOUR = 3_600_000;
const DAY = 24 * HOUR;
const RECORD = `mutation ($e: [AttendanceEntryInput!]!) { recordAttendance(entries: $e) { clientMutationId result code } }`;
const ROLL_CALL = `query ($id: ID!) { rollCall(eventId: $id) { completedAt editable players { personId status note formerPlayer absenceNotice { id reason } } } }`;

type Opts = { token: string; tenantId: string };
type Result = { clientMutationId: string; result: string; code: string | null };

describe('presenze', () => {
  let t: TestApp;
  let admin: Opts;
  let coach: Opts;
  let parent: Opts;
  let u15: string;
  let u17: string;
  let kid: string;
  let otherKid: string;
  let u17Kid: string;

  const gql = async <T>(q: string, v: Record<string, unknown> = {}, o: Opts = admin) => {
    const res = await t.gql<T>(q, v, o);
    if (!res.data) throw new Error(JSON.stringify(res.errors));
    return res.data;
  };
  const person = (i: Record<string, unknown>) =>
    gql<{ createPerson: { id: string } }>(`mutation ($i: PersonInput!) { createPerson(input: $i) { id } }`, { i }).then((d) => d.createPerson.id);
  const event = (teamId: string, startOffsetMs: number, kind = 'TRAINING') =>
    gql<{ createEvent: { id: string } }>(`mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: {
        teamId,
        kind,
        opponent: kind === 'MATCH' ? 'Rivali' : null,
        startsAt: new Date(Date.now() + startOffsetMs).toISOString(),
        endsAt: new Date(Date.now() + startOffsetMs + 1.5 * HOUR).toISOString(),
      },
    }).then((d) => d.createEvent.id);
  const entry = (eventId: string, personId: string, status: string, recordedAt = new Date(), note?: string) => ({
    clientMutationId: randomUUID(),
    eventId,
    personId,
    status,
    note,
    recordedAt: recordedAt.toISOString(),
  });
  const record = (entries: ReturnType<typeof entry>[], o: Opts = coach) =>
    gql<{ recordAttendance: Result[] }>(RECORD, { e: entries }, o).then((d) => d.recordAttendance);
  const rollCall = (id: string, o: Opts = coach) =>
    gql<{ rollCall: { completedAt: string | null; editable: boolean; players: { personId: string; status: string | null; note: string | null; absenceNotice: { id: string; reason: string } | null }[] } }>(
      ROLL_CALL,
      { id },
      o,
    ).then((d) => d.rollCall);

  async function activate(personId: string, role: string): Promise<Opts> {
    const email = `${role.toLowerCase()}.${randomUUID().slice(0, 8)}@example.test`;
    await gql(`mutation ($p: ID!, $e: String!, $r: MembershipRole!) { invitePersonAccount(personId: $p, email: $e, role: $r) { id } }`, { p: personId, e: email, r: role });
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === email)!.text);
    const acc = await t.gql<{ acceptInvitation: { accessToken: string } }>(
      `mutation ($i: AcceptInvitationInput!) { acceptInvitation(input: $i) { accessToken } }`,
      { i: { token, fullName: 'Test', acceptTerms: true } },
    );
    return { token: acc.data!.acceptInvitation.accessToken, tenantId: admin.tenantId };
  }

  beforeAll(async () => {
    t = await createTestApp();
    const a = await createAdminWithClub(t, 'ASD Presenze');
    admin = { token: a.token, tenantId: a.clubId };
    const day = (offset: number) => new Date(Date.now() + offset * DAY).toISOString().slice(0, 10);
    const season = await gql<{ createSeason: { id: string } }>(`mutation ($i: SeasonInput!) { createSeason(input: $i) { id } }`, {
      i: { name: 'Corrente', startsOn: day(-60), endsOn: day(120) },
    });
    const team = (name: string) =>
      gql<{ createTeam: { id: string } }>(`mutation ($i: TeamInput!) { createTeam(input: $i) { id } }`, {
        i: { seasonId: season.createSeason.id, name },
      }).then((d) => d.createTeam.id);
    u15 = await team('Under 15');
    u17 = await team('Under 17');
    kid = await person({ firstName: 'Giulia', lastName: 'Verdi', birthDate: '2012-03-03' });
    otherKid = await person({ firstName: 'Paolo', lastName: 'Neri', birthDate: '2012-04-04' });
    u17Kid = await person({ firstName: 'Sara', lastName: 'Gialli', birthDate: '2010-05-05' });
    const parentPerson = await person({ firstName: 'Anna', lastName: 'Verdi' });
    const coachPerson = await person({ firstName: 'Coach', lastName: 'U15' });
    for (const [teamId, p] of [[u15, kid], [u15, otherKid], [u17, u17Kid]] as const) {
      await gql(`mutation ($t: ID!, $p: ID!) { addPlayer(teamId: $t, personId: $p) { id } }`, { t: teamId, p });
    }
    await gql(`mutation ($m: ID!, $g: ID!) { addGuardian(minorId: $m, guardianId: $g, relation: MOTHER) { id } }`, { m: kid, g: parentPerson });
    await gql(`mutation ($t: ID!, $p: ID!) { addStaff(teamId: $t, personId: $p, role: HEAD_COACH) { id } }`, { t: u15, p: coachPerson });
    coach = await activate(coachPerson, 'COACH');
    parent = await activate(parentPerson, 'PARENT');
  });
  afterAll(() => t.app.close());

  it('registra l’appello e ignora i reinvii della stessa riga', async () => {
    const ev = await event(u15, -HOUR);
    const rows = [entry(ev, kid, 'PRESENT'), entry(ev, otherKid, 'ABSENT', new Date(), 'Influenza')];
    expect((await record(rows)).map((r) => r.result)).toEqual(['APPLIED', 'APPLIED']);
    // La rete cade dopo l'invio: l'app rimanda le stesse righe.
    expect((await record(rows)).map((r) => r.result)).toEqual(['DUPLICATE', 'DUPLICATE']);

    const rc = await rollCall(ev);
    expect(rc.editable).toBe(true);
    expect(rc.players.find((p) => p.personId === otherKid)).toMatchObject({ status: 'ABSENT', note: 'Influenza' });
  });

  it('conflitti: vince la registrazione più recente, anche se arriva per ultima quella vecchia', async () => {
    const ev = await event(u15, -HOUR);
    const older = entry(ev, kid, 'ABSENT', new Date(Date.now() - 10 * 60_000));
    const newer = entry(ev, kid, 'LATE', new Date(Date.now() - 60_000));
    expect((await record([newer]))[0]!.result).toBe('APPLIED');
    // Il telefono di un vice allenatore era offline e invia ora una registrazione precedente.
    expect((await record([older]))[0]!.result).toBe('SUPERSEDED');
    expect((await rollCall(ev)).players.find((p) => p.personId === kid)!.status).toBe('LATE');

    // Entrambe le scritture restano nel registro append-only.
    const pool = new pg.Pool({ connectionString: process.env.DATABASE_OWNER_URL });
    const writes = await pool.query(`select outcome from attendance_writes where event_id = $1 order by id`, [ev]);
    await pool.end();
    expect(writes.rows.map((r) => r.outcome)).toEqual(['APPLIED', 'SUPERSEDED']);
  });

  it('un orologio del telefono avanti non blocca le correzioni successive', async () => {
    const ev = await event(u15, -HOUR);
    await record([entry(ev, kid, 'ABSENT', new Date(Date.now() + 365 * DAY))]);
    expect((await record([entry(ev, kid, 'PRESENT')]))[0]!.result).toBe('APPLIED');
    expect((await rollCall(ev)).players.find((p) => p.personId === kid)!.status).toBe('PRESENT');
  });

  it('righe rifiutate con il motivo, senza bloccare le altre', async () => {
    const ok = await event(u15, -HOUR);
    const tooEarly = await event(u15, 5 * HOUR);
    const tooLate = await event(u15, -9 * DAY);
    const cancelled = await event(u15, -HOUR);
    await gql(`mutation ($id: ID!) { setEventCancelled(id: $id, cancelled: true) { id } }`, { id: cancelled });
    const otherTeam = await event(u17, -HOUR);

    const results = await record([
      entry(ok, kid, 'PRESENT'),
      entry(tooEarly, kid, 'PRESENT'),
      entry(tooLate, kid, 'PRESENT'),
      entry(cancelled, kid, 'PRESENT'),
      entry(otherTeam, u17Kid, 'PRESENT'),
      entry(ok, u17Kid, 'PRESENT'),
    ]);
    expect(results.map((r) => r.code ?? r.result)).toEqual([
      'APPLIED',
      'OUT_OF_WINDOW',
      'OUT_OF_WINDOW',
      'EVENT_CANCELLED',
      'FORBIDDEN',
      'NOT_IN_ROSTER',
    ]);

    // Oltre i 7 giorni la segreteria può ancora correggere, e resta traccia nel log.
    expect((await record([entry(tooLate, kid, 'PRESENT')], admin))[0]!.result).toBe('APPLIED');
    const audit = await gql<{ auditEvents: { action: string }[] }>(`{ auditEvents(limit: 5) { action } }`);
    expect(audit.auditEvents.map((a) => a.action)).toContain('attendance.late_correction');
  });

  it('il genitore non può fare l’appello', async () => {
    const ev = await event(u15, -HOUR);
    expect((await record([entry(ev, kid, 'PRESENT')], parent))[0]!.code).toBe('FORBIDDEN');
  });

  it('conferma dell’appello idempotente', async () => {
    const ev = await event(u15, -HOUR);
    const first = await gql<{ completeRollCall: { completedAt: string } }>(`mutation ($id: ID!) { completeRollCall(eventId: $id) { completedAt } }`, { id: ev }, coach);
    const second = await gql<{ completeRollCall: { completedAt: string } }>(`mutation ($id: ID!) { completeRollCall(eventId: $id) { completedAt } }`, { id: ev }, coach);
    expect(second.completeRollCall.completedAt).toBe(first.completeRollCall.completedAt);
  });

  it('assenza annunciata dal genitore: compare nell’appello, si ritira prima dell’inizio', async () => {
    const future = await event(u15, 2 * DAY);
    const PART = `{ personId absenceNotice { id reason } canReport }`;
    const reported = await gql<{ reportAbsence: { absenceNotice: { id: string; reason: string } }[] }>(
      `mutation ($e: ID!, $p: ID!) { reportAbsence(eventId: $e, personId: $p, reason: "Gita scolastica") ${PART} }`,
      { e: future, p: kid },
      parent,
    );
    expect(reported.reportAbsence[0]!.absenceNotice.reason).toBe('Gita scolastica');
    expect((await rollCall(future)).players.find((p) => p.personId === kid)!.absenceNotice!.reason).toBe('Gita scolastica');

    const notMine = await t.gql(`mutation ($e: ID!, $p: ID!) { reportAbsence(eventId: $e, personId: $p) ${PART} }`, { e: future, p: otherKid }, parent);
    expect(notMine.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');

    await gql(`mutation ($id: ID!) { withdrawAbsence(noticeId: $id) ${PART} }`, { id: reported.reportAbsence[0]!.absenceNotice.id }, parent);
    expect((await rollCall(future)).players.find((p) => p.personId === kid)!.absenceNotice).toBeNull();

    const past = await event(u15, -HOUR);
    const late = await t.gql(`mutation ($e: ID!, $p: ID!) { reportAbsence(eventId: $e, personId: $p) ${PART} }`, { e: past, p: kid }, parent);
    expect(late.errors?.[0]?.extensions?.code).toBe('EVENT_STARTED');
  });

  it('registro: percentuali sugli eventi registrati, filtro per tipo, solo per lo staff', async () => {
    const t1 = await event(u15, -3 * DAY);
    const t2 = await event(u15, -2 * DAY);
    const m1 = await event(u15, -1 * DAY, 'MATCH');
    await record([entry(t1, kid, 'PRESENT'), entry(t2, kid, 'ABSENT'), entry(m1, kid, 'LATE'), entry(t1, otherKid, 'EXCUSED')]);

    const REG = `query ($t: ID!, $f: DateTime!, $to: DateTime!, $k: EventKind) { attendanceRegister(teamId: $t, from: $f, to: $to, kind: $k) { events { id kind } players { personId recorded attended excused percentage } cells { eventId personId status } } }`;
    const vars = { t: u15, f: new Date(Date.now() - 4 * DAY).toISOString(), to: new Date(Date.now() - DAY / 2).toISOString() };
    const all = await gql<{ attendanceRegister: { players: { personId: string; percentage: number; recorded: number; excused: number }[]; events: { kind: string }[] } }>(REG, vars);
    const giulia = all.attendanceRegister.players.find((p) => p.personId === kid)!;
    expect(giulia).toMatchObject({ recorded: 3, percentage: 67 });
    expect(all.attendanceRegister.players.find((p) => p.personId === otherKid)).toMatchObject({ excused: 1, percentage: 0 });

    const matches = await gql<{ attendanceRegister: { events: { kind: string }[] } }>(REG, { ...vars, k: 'MATCH' });
    expect(matches.attendanceRegister.events.map((e) => e.kind)).toEqual(['MATCH']);

    const forbidden = await t.gql(REG, { ...vars, t: u15 }, parent);
    expect(forbidden.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
  });

  it('D10: il genitore vede le presenze della figlia, non quelle degli altri', async () => {
    const H = `query ($p: ID!) { personAttendance(personId: $p) { status teamName } }`;
    const mine = await gql<{ personAttendance: { status: string }[] }>(H, { p: kid }, parent);
    expect(mine.personAttendance.length).toBeGreaterThan(0);
    const other = await t.gql(H, { p: otherKid }, parent);
    expect(other.errors?.[0]?.extensions?.code).toBe('FORBIDDEN');
  });
});
