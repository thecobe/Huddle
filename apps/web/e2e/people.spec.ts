import { expect, test } from '@playwright/test';
import { firstLink, waitForMail } from './mailpit';
import { adminWithClub, openSeason } from './session';

/**
 * M1: la segreteria importa le anagrafiche da un CSV (fratelli con lo stesso genitore), le trova nella
 * rosa della squadra con i recapiti dei tutori e invita il genitore ad attivare l'account.
 */
test('import anagrafiche, rosa e invito al genitore', async ({ page, browser }, testInfo) => {
  const stamp = `${Date.now()}${testInfo.project.name}`;
  const parentEmail = `laura.${stamp}@example.test`;
  await adminWithClub(page, stamp);
  await openSeason(page);

  await page.goto('/app/teams');
  await page.getByRole('button', { name: 'Nuova squadra' }).click();
  await page.getByLabel('Nome', { exact: true }).fill('Under 12');
  await page.getByRole('button', { name: 'Salva' }).click();
  await expect(page.getByRole('heading', { name: 'Under 12' })).toBeVisible();

  const csv = [
    'Cognome;Nome;Data di nascita;Squadra;Maglia;Nome genitore;Cognome genitore;E-mail genitore;Telefono genitore',
    `Conti;Tommaso;10/04/2014;Under 12;9;Laura;Conti;${parentEmail};3401112222`,
    `Conti;Elena;12/09/2014;Under 12;;Laura;Conti;${parentEmail};3401112222`,
  ].join('\n');
  await page.goto('/app/people/import');
  await page.getByLabel('File').setInputFiles({ name: 'iscritti.csv', mimeType: 'text/csv', buffer: Buffer.from(csv) });
  await expect(page.getByText('2 righe trovate')).toBeVisible();
  await page.getByRole('button', { name: 'Controlla' }).click();
  await expect(page.getByText('Da creare: 2')).toBeVisible();
  await page.getByRole('button', { name: 'Importa 2 righe' }).click();
  await expect(page.getByText(/Import completato: 2 create, 0 aggiornate, 2 tutori collegati, 2 inserimenti in squadra/)).toBeVisible();

  await page.goto('/app/teams');
  await page.getByRole('link', { name: /Under 12/ }).click();
  const tommaso = page.getByRole('row', { name: /Conti Tommaso/ });
  await expect(tommaso.getByText('Laura Conti')).toBeVisible();
  await expect(tommaso.getByRole('textbox')).toHaveValue('9');

  await page.goto('/app/people');
  await page.getByPlaceholder('Cerca per nome, e-mail o codice fiscale').fill('Laura');
  await page.getByRole('link', { name: 'Conti Laura' }).click();
  await expect(page.getByRole('heading', { name: 'Minori seguiti' })).toBeVisible();
  await expect(page.getByLabel('Ruolo')).toHaveValue('PARENT');
  await page.getByRole('button', { name: "Invita ad attivare l'account" }).click();
  await expect(page.getByText(`Invito inviato a ${parentEmail}`)).toBeVisible();

  // Il genitore accetta e vede i figli, non il resto dell'anagrafica.
  const link = firstLink(await waitForMail(parentEmail), '/invitations/accept');
  const ctx = await browser.newContext({ locale: 'it-IT' });
  const parent = await ctx.newPage();
  await parent.goto(link.replace(/^https?:\/\/[^/]+/, ''));
  await parent.getByLabel('Nome e cognome').fill('Laura Conti');
  await parent.getByRole('checkbox').check();
  await parent.getByRole('button', { name: 'Accetta invito' }).click();
  await expect(parent.getByRole('heading', { name: 'Benvenuto, Laura' })).toBeVisible();
  await parent.goto('/app/people');
  await expect(parent.getByRole('row')).toHaveCount(4);
  await ctx.close();
});
