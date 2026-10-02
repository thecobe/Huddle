import { defineConfig, devices } from '@playwright/test';

// Richiede API (porta 4000) con database migrato e Mailpit attivi: `pnpm dev:infra && pnpm dev:api`.
export default defineConfig({
  testDir: './e2e',
  use: { baseURL: 'http://localhost:5173', locale: 'it-IT', trace: 'retain-on-failure' },
  webServer: { command: 'pnpm dev', url: 'http://localhost:5173', reuseExistingServer: true },
  projects: [
    { name: 'desktop', use: { ...devices['Desktop Chrome'] } },
    { name: 'mobile', use: { ...devices['Pixel 7'] } },
  ],
});
