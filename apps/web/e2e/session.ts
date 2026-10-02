import { randomUUID } from 'node:crypto';
import { expect, type Page } from '@playwright/test';
import { generate } from 'otplib';

/** Registra un amministratore, crea la società e attiva il 2FA richiesto dal ruolo. */
export async function adminWithClub(page: Page, stamp: string, clubName = `ASD ${stamp}`) {
  await page.goto('/register');
  await page.getByLabel('Nome e cognome').fill('Giulia Bianchi');
  // Suffisso casuale: test paralleli possono avere lo stesso timestamp.
  await page.getByLabel('E-mail').fill(`presidente.${stamp}.${randomUUID().slice(0, 8)}@example.test`);
  await page.getByLabel('Password').fill('password-sicura-123');
  await page.getByRole('checkbox').check();
  await page.getByRole('button', { name: 'Crea account' }).click();
  await page.getByLabel('Nome', { exact: true }).fill(clubName);
  await page.getByRole('button', { name: 'Crea una società' }).click();
  await expect(page).toHaveURL(/\/account\/security/);
  await page.getByRole('button', { name: 'Configura' }).click();
  const secret = (await page.locator('code.secret').textContent())!.trim();
  await page.getByLabel("Codice generato dall'app").fill(await generate({ secret }));
  await page.getByRole('button', { name: 'Attiva', exact: true }).click();
  await page.getByRole('button', { name: 'Li ho salvati' }).click();
}

export async function openSeason(page: Page, name = '2026/27') {
  await page.goto('/app/seasons');
  await page.getByRole('button', { name: 'Nuova stagione' }).click();
  await page.getByLabel('Nome', { exact: true }).fill(name);
  await page.getByLabel('Inizio').fill('2026-09-01');
  await page.getByLabel('Fine').fill('2027-06-30');
  await page.getByRole('button', { name: 'Salva' }).click();
  await page.getByRole('row', { name: new RegExp(name.replace('/', '\\/')) }).getByRole('button', { name: 'Apri', exact: true }).click();
}

export async function createTeam(page: Page, name: string) {
  await page.goto('/app/teams');
  await page.getByRole('button', { name: 'Nuova squadra' }).click();
  await page.getByLabel('Nome', { exact: true }).fill(name);
  await page.getByRole('button', { name: 'Salva' }).click();
  await expect(page.getByRole('heading', { name })).toBeVisible();
}
