import type { INestApplication } from '@nestjs/common';
import cookieParser from 'cookie-parser';
import type { Env } from './config/env.js';

/** Configurazione HTTP condivisa da main.ts e dai test end-to-end. */
export function configureApp(app: INestApplication, env: Env): void {
  app.use(cookieParser());
  app.enableCors({
    origin: env.CORS_ORIGINS,
    credentials: true,
    allowedHeaders: ['content-type', 'authorization', 'x-tenant-id', 'x-huddle-client'],
  });
  app.enableShutdownHooks();
}
