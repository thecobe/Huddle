import { expect, test } from '@playwright/test';
import { generate } from 'otplib';
import { firstLink, waitForMail } from './mailpit';

/**
 * Percorso completo della Fase 0: un presidente crea la società, attiva il 2FA richiesto dal ruolo,
 * apre la stagione e invita un allenatore, che accetta senza impostare una password.
 */
test('onboarding società e invito allenatore', async ({ page, browser }, testInfo) => {
  const stamp = `${Date.now()}${testInfo.project.name}`;
  const adminEmail = `presidente.${stamp}@example.test`;
  const coachEmail = `allenatore.${stamp}@example.test`;

  await page.goto('/register');
  await page.getByLabel('Nome e cognome').fill('Giulia Bianchi');
  await page.getByLabel('E-mail').fill(adminEmail);
  await page.getByLabel('Password').fill('password-sicura-123');
  await page.getByRole('checkbox').check();
  await page.getByRole('button', { name: 'Crea account' }).click();

  await expect(page.getByRole('heading', { name: 'Nuova società' })).toBeVisible();
  await page.getByLabel('Nome', { exact: true }).fill(`ASD Aurora ${stamp}`);
  await page.getByRole('button', { name: 'Crea una società' }).click();

  // L'amministratore viene portato ad attivare il 2FA.
  await expect(page).toHaveURL(/\/account\/security/);
  await page.getByRole('button', { name: 'Configura' }).click();
  const secret = (await page.locator('code.secret').textContent())!.trim();
  await page.getByLabel("Codice generato dall'app").fill(await generate({ secret }));
  await page.getByRole('button', { name: 'Attiva', exact: true }).click();
  await expect(page.getByRole('heading', { name: 'Codici di recupero' })).toBeVisible();
  await page.getByRole('button', { name: 'Li ho salvati' }).click();

  await page.goto('/app/seasons');
  await page.getByRole('button', { name: 'Nuova stagione' }).click();
  await page.getByLabel('Nome', { exact: true }).fill('2026/27');
  await page.getByLabel('Inizio').fill('2026-09-01');
  await page.getByLabel('Fine').fill('2027-06-30');
  await page.getByRole('button', { name: 'Salva' }).click();
  const row = page.getByRole('row', { name: /2026\/27/ });
  await row.getByRole('button', { name: 'Apri', exact: true }).click();
  await expect(row.getByText('Aperta')).toBeVisible();

  await page.goto('/app/members');
  await page.getByRole('button', { name: 'Invita' }).click();
  await page.getByLabel('E-mail').fill(coachEmail);
  await page.getByRole('button', { name: 'Invita' }).click();
  await expect(page.getByText(`Invito inviato a ${coachEmail}`)).toBeVisible();

  const link = firstLink(await waitForMail(coachEmail), '/invitations/accept');
  const coachContext = await browser.newContext();
  const coach = await coachContext.newPage();
  await coach.goto(link.replace(/^https?:\/\/[^/]+/, ''));
  await expect(coach.getByText(/ti ha invitato su Huddle come Allenatore/)).toBeVisible();
  await coach.getByLabel('Nome e cognome').fill('Luca Verdi');
  await coach.getByRole('checkbox').check();
  await coach.getByRole('button', { name: 'Accetta invito' }).click();

  await expect(coach.getByRole('heading', { name: 'Benvenuto, Luca' })).toBeVisible();
  await expect(coach.getByText('Allenatore').first()).toBeVisible();
  // L'allenatore non vede la gestione delle persone.
  await expect(coach.getByRole('link', { name: 'Persone' })).toHaveCount(0);
  await coachContext.close();
});
