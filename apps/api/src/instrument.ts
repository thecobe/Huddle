import * as Sentry from '@sentry/nestjs';
import { loadEnv } from './config/env.js';

// Importato per primo in main.ts: Sentry deve inizializzarsi prima degli altri moduli.
const env = loadEnv();
if (env.SENTRY_DSN) {
  Sentry.init({ dsn: env.SENTRY_DSN, environment: env.NODE_ENV, tracesSampleRate: 0.1 });
}
