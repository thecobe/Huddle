import { existsSync } from 'node:fs';
import { z } from 'zod';

const boolFromString = z
  .enum(['true', 'false'])
  .default('true')
  .transform((v) => v === 'true');

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.coerce.number().int().default(4000),
  WEB_URL: z.url(),
  CORS_ORIGINS: z
    .string()
    .default('')
    .transform((v) => v.split(',').map((s) => s.trim()).filter(Boolean)),
  DATABASE_URL: z.string().min(1),
  DATABASE_OWNER_URL: z.string().min(1),
  JWT_SECRET: z.string().min(32),
  ENCRYPTION_KEY: z
    .string()
    .refine((v) => Buffer.from(v, 'base64').length === 32, 'ENCRYPTION_KEY deve essere 32 byte in base64'),
  SMTP_URL: z.string().min(1),
  MAIL_FROM: z.string().min(1),
  MOBILE_DEEP_LINK_SCHEME: z.string().default('huddle'),
  PRIVACY_POLICY_VERSION: z.string().min(1),
  TERMS_VERSION: z.string().min(1),
  REQUIRE_2FA_FOR_ADMIN_ROLES: boolFromString,
  SENTRY_DSN: z.string().optional(),
});

export type Env = z.infer<typeof envSchema>;

let cached: Env | undefined;

export function loadEnv(): Env {
  if (cached) return cached;
  if (process.env.NODE_ENV !== 'test' && existsSync('.env')) {
    process.loadEnvFile('.env');
  }
  cached = envSchema.parse(process.env);
  return cached;
}

export const ENV = Symbol('ENV');
