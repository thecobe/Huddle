/**
 * Dati demo per prove manuali e test di integrazione dell'app, contro un'API locale in esecuzione.
 *   pnpm --filter @huddle/api seed:demo
 * Crea una società con stagione aperta, due squadre, atleti con tutori, un allenatore e un genitore
 * con account; stampa in JSON le credenziali e i magic link (letti da Mailpit).
 */
import { randomUUID } from 'node:crypto';
import { generate } from 'otplib';

const API = process.env.API_URL ?? 'http://localhost:4000/graphql';
const MAILPIT = process.env.MAILPIT_URL ?? 'http://localhost:8025';
const PASSWORD = 'password-demo-123';

type Headers = Record<string, string>;

async function gql<T = Record<string, never>>(query: string, variables: object = {}, headers: Headers = {}): Promise<T> {
  const res = await fetch(API, {
    method: 'POST',
    headers: { 'content-type': 'application/json', ...headers },
    body: JSON.stringify({ query, variables }),
  });
  const body = (await res.json()) as { data?: T; errors?: unknown[] };
  if (body.errors) throw new Error(JSON.stringify(body.errors[0]));
  return body.data!;
}

async function mailIds(to: string): Promise<string[]> {
  const search = (await (await fetch(`${MAILPIT}/api/v1/search?query=${encodeURIComponent(`to:"${to}"`)}`)).json()) as {
    messages: { ID: string }[];
  };
  return search.messages.map((m) => m.ID);
}

/** Esegue `action` e restituisce il testo della prima e-mail nuova per `to` (non confronta orari: Docker e host possono differire). */
async function mailAfter(to: string, action: () => Promise<unknown>): Promise<string> {
  const known = new Set(await mailIds(to));
  await action();
  for (let i = 0; i < 50; i++) {
    const id = (await mailIds(to)).find((m) => !known.has(m));
    if (id) return ((await (await fetch(`${MAILPIT}/api/v1/message/${id}`)).json()) as { Text: string }).Text;
    await new Promise((r) => setTimeout(r, 200));
  }
  throw new Error(`Nessuna e-mail per ${to}`);
}

const token = (text: string) => text.match(/token=([A-Za-z0-9_-]+)/)![1]!;
const age = (years: number, extraDays = 40) => {
  const d = new Date();
  d.setUTCFullYear(d.getUTCFullYear() - years);
  d.setUTCDate(d.getUTCDate() - extraDays);
  return d.toISOString().slice(0, 10);
};

const run = randomUUID().slice(0, 6);
const adminEmail = `presidente.${run}@example.test`;
const coachEmail = `allenatore.${run}@example.test`;
const parentEmail = `genitore.${run}@example.test`;

const reg = await gql<{ register: { accessToken: string } }>(
  `mutation ($i: RegisterInput!) { register(input: $i) { accessToken } }`,
  { i: { email: adminEmail, password: PASSWORD, fullName: 'Giulia Bianchi', acceptTerms: true } },
);
const auth = { authorization: `Bearer ${reg.register.accessToken}` };
const setup = await gql<{ setupTwoFactor: { secret: string } }>(`mutation { setupTwoFactor { secret } }`, {}, auth);
await gql(`mutation ($c: String!) { enableTwoFactor(code: $c) }`, { c: await generate({ secret: setup.setupTwoFactor.secret }) }, auth);
const club = await gql<{ createClub: { id: string } }>(`mutation { createClub(input: { name: "ASD Aurora" }) { id } }`, {}, auth);
const h = { ...auth, 'x-tenant-id': club.createClub.id };

const season = await gql<{ createSeason: { id: string } }>(
  `mutation { createSeason(input: { name: "2026/27", startsOn: "2026-09-01", endsOn: "2027-06-30" }) { id } }`,
  {},
  h,
);
await gql(`mutation ($id: ID!) { setSeasonStatus(id: $id, status: OPEN) { id } }`, { id: season.createSeason.id }, h);
const team = async (name: string, from: number, to: number) =>
  (
    await gql<{ createTeam: { id: string } }>(
      `mutation ($i: TeamInput!) { createTeam(input: $i) { id } }`,
      { i: { seasonId: season.createSeason.id, name, birthYearFrom: from, birthYearTo: to } },
      h,
    )
  ).createTeam.id;
await team('Under 12', 2014, 2015);
const u15 = await team('Under 15', 2011, 2012);

const rows = [
  ['Verdi', 'Giulia', age(15), 'Under 15', 7, 'Anna', 'Verdi', parentEmail, '3331234567'],
  ['Verdi', 'Marco', age(11), 'Under 12', 10, 'Anna', 'Verdi', parentEmail, '3331234567'],
  ['Rossi', 'Luca', age(14), 'Under 15', 9, 'Paola', 'Rossi', `paola.${run}@example.test`, '3402223333'],
  ['Neri', 'Sara', age(14), 'Under 15', 4, 'Davide', 'Neri', `davide.${run}@example.test`, '3473334444'],
  ['Conti', 'Tommaso', age(12), 'Under 12', 5, 'Laura', 'Conti', `laura.${run}@example.test`, '3404445555'],
  ['Conti', 'Elena', age(11), 'Under 12', 8, 'Laura', 'Conti', `laura.${run}@example.test`, '3404445555'],
].map(([lastName, firstName, birthDate, teamName, jerseyNumber, gF, gL, gE, gP]) => ({
  lastName,
  firstName,
  birthDate,
  teamName,
  jerseyNumber,
  guardianFirstName: gF,
  guardianLastName: gL,
  guardianEmail: gE,
  guardianPhone: gP,
}));
await gql(`mutation ($r: [PersonImportRow!]!) { commitPeopleImport(rows: $r) { created } }`, { r: rows }, h);

const coach = await gql<{ createPerson: { id: string } }>(
  `mutation { createPerson(input: { firstName: "Luca", lastName: "Allenatore", phone: "3489990000", categories: [STAFF] }) { id } }`,
  {},
  h,
);
await gql(
  `mutation ($t: ID!, $p: ID!) { addStaff(teamId: $t, personId: $p, role: HEAD_COACH) { id } }`,
  { t: u15, p: coach.createPerson.id },
  h,
);

async function activate(personId: string, email: string, role: string, fullName: string) {
  const mail = await mailAfter(email, () =>
    gql(
      `mutation ($p: ID!, $e: String!, $r: MembershipRole!) { invitePersonAccount(personId: $p, email: $e, role: $r) { id } }`,
      { p: personId, e: email, r: role },
      h,
    ),
  );
  await gql(`mutation ($i: AcceptInvitationInput!) { acceptInvitation(input: $i) { status } }`, {
    i: { token: token(mail), fullName, acceptTerms: true },
  });
}

async function magicLink(email: string) {
  const mail = await mailAfter(email, () => gql(`mutation ($e: String!) { requestMagicLink(email: $e) }`, { e: email }));
  return mail.match(/huddle:\/\/auth\/magic\?token=[A-Za-z0-9_-]+/)![0];
}

const people = await gql<{ people: { items: { id: string; email: string | null }[] } }>(
  `query ($s: String!) { people(filter: { search: $s }, limit: 5) { items { id email } } }`,
  { s: parentEmail },
  h,
);
await activate(coach.createPerson.id, coachEmail, 'COACH', 'Luca Allenatore');
await activate(people.people.items[0]!.id, parentEmail, 'PARENT', 'Anna Verdi');

console.log(
  JSON.stringify(
    {
      club: 'ASD Aurora',
      admin: { email: adminEmail, password: PASSWORD, totpSecret: setup.setupTwoFactor.secret },
      coach: { email: coachEmail, magicLink: await magicLink(coachEmail) },
      parent: { email: parentEmail, magicLink: await magicLink(parentEmail) },
    },
    null,
    2,
  ),
);
