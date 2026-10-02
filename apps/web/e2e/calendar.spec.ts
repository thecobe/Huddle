import { expect, test } from '@playwright/test';
import { adminWithClub, createTeam, openSeason } from './session';

/** M2: allenamenti ricorrenti, annullamento di una data, gara, chiusura e link iCal. */
test('calendario della squadra', async ({ page }, testInfo) => {
  const stamp = `${Date.now()}${testInfo.project.name}`;
  await adminWithClub(page, stamp);
  await openSeason(page);
  await createTeam(page, 'Under 15');

  await page.goto('/app/calendar');
  await page.getByRole('button', { name: 'Allenamenti ricorrenti' }).click();
  await page.getByRole('button', { name: 'Nuova serie' }).click();
  // Tutti i giorni: ogni settimana del mese ha almeno un allenamento visibile.
  for (const day of ['Lun', 'Mar', 'Mer', 'Gio', 'Ven']) await page.getByRole('checkbox', { name: day }).check();
  await page.getByLabel('Luogo').fill('Campo comunale, via Roma 1');
  await page.getByRole('button', { name: 'Salva' }).click();
  await expect(page.getByText(/Creati \d+ allenamenti/)).toBeVisible();

  await page.getByRole('button', { name: 'Elenco' }).click();
  const first = page.locator('.item').first();
  await expect(first).toContainText('18:00–19:30');
  await first.click();
  const panel = page.getByRole('dialog');
  await expect(panel.getByText('Fa parte di una serie')).toBeVisible();
  await panel.getByLabel('Motivo').fill('Campo allagato');
  await panel.getByRole('button', { name: 'Annulla evento' }).click();
  await expect(panel.getByText('Campo allagato')).toBeVisible();
  await expect(panel.getByText('Annullato', { exact: true })).toBeVisible();
  await panel.getByRole('button', { name: 'Chiudi' }).click();

  await page.getByRole('button', { name: 'Nuovo evento' }).click();
  await panel.getByLabel('Tipo').selectOption('MATCH');
  await panel.getByLabel('Avversario').fill('ASD Rivali');
  await panel.getByLabel('Inizio').fill('15:00');
  await panel.getByLabel('Fine').fill('17:00');
  await panel.getByRole('button', { name: 'Salva' }).click();
  await expect(page.locator('.item', { hasText: 'vs ASD Rivali' })).toBeVisible();

  // Link della squadra: quello personale dell'amministratore contiene solo le sue squadre (nessuna).
  await page.getByRole('button', { name: 'Abbonati' }).click();
  await page.getByLabel('Squadra', { exact: true }).last().selectOption({ label: 'Under 15' });
  await page.getByRole('button', { name: 'Genera link' }).click();
  const url = await page.getByRole('textbox', { name: 'Abbonati al calendario' }).inputValue();
  const ics = await page.request.get(new URL(url).pathname);
  expect(ics.status()).toBe(200);
  expect(await ics.text()).toContain('SUMMARY:Gara vs ASD Rivali · Under 15');
});
