import { readFile } from 'node:fs/promises';
import { randomUUID } from 'node:crypto';
import { expect, type Page, test } from '@playwright/test';
import { adminWithClub, createTeam, openSeason } from './session';

/** Chiamata GraphQL dal browser con la sessione corrente (refresh token nel cookie httpOnly). */
async function gql<T>(page: Page, query: string, variables: Record<string, unknown> = {}): Promise<T> {
  return page.evaluate(
    async ({ query, variables }) => {
      const headers = { 'content-type': 'application/json', 'x-huddle-client': 'web' };
      const refresh = await fetch('/graphql', {
        method: 'POST',
        headers,
        body: JSON.stringify({ query: 'mutation { refreshSession { accessToken } }' }),
      }).then((r) => r.json());
      const token = refresh.data.refreshSession.accessToken as string;
      const clubId = localStorage.getItem('huddle.clubId')!;
      const res = await fetch('/graphql', {
        method: 'POST',
        headers: { ...headers, authorization: `Bearer ${token}`, 'x-tenant-id': clubId },
        body: JSON.stringify({ query, variables }),
      }).then((r) => r.json());
      if (res.errors) throw new Error(JSON.stringify(res.errors));
      return res.data;
    },
    { query, variables },
  ) as Promise<T>;
}

/** M3: registro presenze con percentuali, appello mancante evidenziato ed esportazione CSV. */
test('registro presenze', async ({ page }, testInfo) => {
  const stamp = `${Date.now()}${testInfo.project.name}`;
  await adminWithClub(page, stamp);
  await openSeason(page);
  await createTeam(page, 'Under 15');

  const csv = ['Cognome;Nome;Squadra;Maglia', 'Conti;Tommaso;Under 15;9', 'Conti;Elena;Under 15;8'].join('\n');
  await page.goto('/app/people/import');
  await page.getByLabel('File').setInputFiles({ name: 'iscritti.csv', mimeType: 'text/csv', buffer: Buffer.from(csv) });
  await page.getByRole('button', { name: 'Controlla' }).click();
  await page.getByRole('button', { name: 'Importa 2 righe' }).click();
  await expect(page.getByText(/Import completato/)).toBeVisible();

  // Due allenamenti ieri e l'altro ieri; solo il primo ha l'appello confermato.
  const ctx = await gql<{ teams: { id: string }[]; people: { items: { id: string; firstName: string }[] } }>(
    page,
    `{ teams { id } people { items { id firstName } } }`,
  );
  const teamId = ctx.teams[0]!.id;
  const idOf = (name: string) => ctx.people.items.find((p) => p.firstName === name)!.id;
  const tommaso = idOf('Tommaso');
  const elena = idOf('Elena');
  const event = async (daysAgo: number) => {
    const start = new Date(Date.now() - daysAgo * 86_400_000);
    const r = await gql<{ createEvent: { id: string } }>(page, `mutation ($i: EventInput!) { createEvent(input: $i) { id } }`, {
      i: { teamId, kind: 'TRAINING', startsAt: start.toISOString(), endsAt: new Date(start.getTime() + 5_400_000).toISOString() },
    });
    return r.createEvent.id;
  };
  const e1 = await event(2);
  const e2 = await event(1);
  const entry = (eventId: string, personId: string, status: string) => ({
    clientMutationId: randomUUID(),
    eventId,
    personId,
    status,
    recordedAt: new Date().toISOString(),
  });
  await gql(page, `mutation ($e: [AttendanceEntryInput!]!) { recordAttendance(entries: $e) { result } }`, {
    e: [entry(e1, tommaso, 'PRESENT'), entry(e1, elena, 'ABSENT'), entry(e2, tommaso, 'PRESENT'), entry(e2, elena, 'PRESENT')],
  });
  await gql(page, `mutation ($id: ID!) { completeRollCall(eventId: $id) { eventId } }`, { id: e1 });

  await page.goto('/app/attendance');
  const tom = page.getByRole('row', { name: /Conti Tommaso/ });
  const ele = page.getByRole('row', { name: /Conti Elena/ });
  await expect(tom.getByText('100%')).toBeVisible();
  await expect(ele.getByText('50%')).toBeVisible();
  await expect(ele.getByText('A', { exact: true })).toBeVisible();
  await expect(page.locator('th.ev.missing')).toHaveCount(1);

  const download = page.waitForEvent('download');
  await page.getByRole('button', { name: 'Esporta CSV' }).click();
  const file = await (await download).path();
  const text = await readFile(file, 'utf8');
  expect(text).toContain('"Conti Elena"');
  expect(text).toContain('"Assente"');
  expect(text).toContain('"50%"');
});
