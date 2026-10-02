import './load-env.js';
import { Test } from '@nestjs/testing';
import type { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { generate } from 'otplib';
import { AppModule } from '../src/app.module.js';
import { configureApp } from '../src/bootstrap.js';
import { loadEnv } from '../src/config/env.js';
import { MailService } from '../src/mail/mail.service.js';

export interface TestApp {
  app: INestApplication;
  mail: MailService;
  gql: <T = Record<string, unknown>>(
    query: string,
    variables?: Record<string, unknown>,
    opts?: { token?: string; tenantId?: string; headers?: Record<string, string> },
  ) => Promise<{ data?: T; errors?: { message: string; extensions?: { code?: string } }[]; headers: Record<string, unknown> }>;
}

export async function createTestApp(): Promise<TestApp> {
  const moduleRef = await Test.createTestingModule({ imports: [AppModule] }).compile();
  const app = moduleRef.createNestApplication();
  configureApp(app, loadEnv());
  await app.init();
  const mail = app.get(MailService);
  return {
    app,
    mail,
    gql: async (query, variables = {}, opts = {}) => {
      const req = request(app.getHttpServer()).post('/graphql').set('content-type', 'application/json');
      if (opts.token) req.set('authorization', `Bearer ${opts.token}`);
      if (opts.tenantId) req.set('x-tenant-id', opts.tenantId);
      for (const [k, v] of Object.entries(opts.headers ?? {})) req.set(k, v);
      const res = await req.send({ query, variables });
      return { ...(res.body as object), headers: res.headers };
    },
  };
}

let counter = 0;
export const uniqueEmail = (prefix: string) => `${prefix}.${Date.now()}.${counter++}@example.test`;

export const REGISTER = /* GraphQL */ `
  mutation ($input: RegisterInput!) {
    register(input: $input) { status accessToken refreshToken user { id email memberships { clubId role } } }
  }
`;

export async function registerUser(t: TestApp, prefix = 'user') {
  const email = uniqueEmail(prefix);
  const res = await t.gql<{ register: { accessToken: string; refreshToken: string; user: { id: string } } }>(REGISTER, {
    input: { email, password: 'password-sicura-123', fullName: `Test ${prefix}`, acceptTerms: true },
  });
  if (!res.data) throw new Error(JSON.stringify(res.errors));
  return { email, token: res.data.register.accessToken, refreshToken: res.data.register.refreshToken, userId: res.data.register.user.id };
}

/** Attiva il 2FA e restituisce un generatore di codici validi. */
export async function enableTwoFactor(t: TestApp, token: string) {
  const setup = await t.gql<{ setupTwoFactor: { secret: string } }>(`mutation { setupTwoFactor { secret otpauthUri } }`, {}, { token });
  const secret = setup.data!.setupTwoFactor.secret;
  const enabled = await t.gql<{ enableTwoFactor: string[] }>(
    `mutation ($code: String!) { enableTwoFactor(code: $code) }`,
    { code: await generate({ secret }) },
    { token },
  );
  if (!enabled.data) throw new Error(JSON.stringify(enabled.errors));
  return { secret, recoveryCodes: enabled.data.enableTwoFactor, code: () => generate({ secret }) };
}

/** Admin con 2FA attivo e una società. */
export async function createAdminWithClub(t: TestApp, clubName = 'ASD Test') {
  const admin = await registerUser(t, 'admin');
  await enableTwoFactor(t, admin.token);
  const res = await t.gql<{ createClub: { id: string } }>(
    `mutation ($input: ClubInput!) { createClub(input: $input) { id name } }`,
    { input: { name: clubName } },
    { token: admin.token },
  );
  if (!res.data) throw new Error(JSON.stringify(res.errors));
  return { ...admin, clubId: res.data.createClub.id };
}

export function tokenFromMail(text: string): string {
  const m = text.match(/token=([A-Za-z0-9_-]+)/);
  if (!m?.[1]) throw new Error(`Nessun token nel messaggio: ${text}`);
  return m[1];
}
