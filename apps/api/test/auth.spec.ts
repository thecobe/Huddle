import { afterAll, beforeAll, describe, expect, it } from 'vitest';
import { createTestApp, enableTwoFactor, registerUser, type TestApp, tokenFromMail } from './helpers.js';

const LOGIN = `mutation ($input: LoginInput!) { login(input: $input) { status accessToken refreshToken challengeToken user { email } } }`;
const REFRESH = `mutation ($t: String) { refreshSession(refreshToken: $t) { accessToken refreshToken } }`;

describe('autenticazione', () => {
  let t: TestApp;
  beforeAll(async () => {
    t = await createTestApp();
  });
  afterAll(() => t.app.close());

  it('registrazione e login con password', async () => {
    const u = await registerUser(t);
    const me = await t.gql<{ me: { email: string } }>(`{ me { email twoFactorEnabled } }`, {}, { token: u.token });
    expect(me.data?.me.email).toBe(u.email);

    const ok = await t.gql<{ login: { status: string; accessToken: string } }>(LOGIN, {
      input: { email: u.email, password: 'password-sicura-123' },
    });
    expect(ok.data?.login.status).toBe('AUTHENTICATED');

    const ko = await t.gql(LOGIN, { input: { email: u.email, password: 'sbagliata-123456' } });
    expect(ko.errors?.[0]?.extensions?.code).toBe('INVALID_CREDENTIALS');
  });

  it('registra i consensi a privacy e termini', async () => {
    const u = await registerUser(t);
    const res = await t.gql<{ myConsents: { kind: string; granted: boolean }[] }>(
      `{ myConsents { kind granted version } }`,
      {},
      { token: u.token },
    );
    expect(res.data?.myConsents.map((c) => c.kind).sort()).toEqual(['PRIVACY_POLICY', 'TERMS_OF_SERVICE']);
  });

  it('rifiuta e-mail già registrata', async () => {
    const u = await registerUser(t);
    const res = await t.gql(`mutation ($i: RegisterInput!) { register(input: $i) { status } }`, {
      i: { email: u.email, password: 'password-sicura-123', fullName: 'Dup', acceptTerms: true },
    });
    expect(res.errors?.[0]?.extensions?.code).toBe('EMAIL_TAKEN');
  });

  it('richiede autenticazione', async () => {
    const res = await t.gql(`{ me { id } }`);
    expect(res.errors?.[0]?.extensions?.code).toBe('UNAUTHENTICATED');
  });

  it('ruota il refresh token e revoca la famiglia in caso di riuso', async () => {
    const u = await registerUser(t);
    const first = await t.gql<{ refreshSession: { refreshToken: string } }>(REFRESH, { t: u.refreshToken });
    const rotated = first.data!.refreshSession.refreshToken;
    expect(rotated).not.toBe(u.refreshToken);

    // Riuso del token vecchio: rifiutato e anche il nuovo viene revocato.
    const reuse = await t.gql(REFRESH, { t: u.refreshToken });
    expect(reuse.errors?.[0]?.extensions?.code).toBe('INVALID_TOKEN');
    const afterReuse = await t.gql(REFRESH, { t: rotated });
    expect(afterReuse.errors?.[0]?.extensions?.code).toBe('INVALID_TOKEN');
  });

  it('client web: refresh token in cookie httpOnly', async () => {
    const u = await registerUser(t);
    const res = await t.gql<{ login: { refreshToken: string | null } }>(
      LOGIN,
      { input: { email: u.email, password: 'password-sicura-123' } },
      { headers: { 'x-huddle-client': 'web' } },
    );
    expect(res.data?.login.refreshToken).toBeNull();
    const cookie = String((res.headers['set-cookie'] as string[])[0]);
    expect(cookie).toMatch(/huddle_rt=.+HttpOnly/);
    const refreshed = await t.gql<{ refreshSession: { accessToken: string } }>(REFRESH, {}, {
      headers: { 'x-huddle-client': 'web', cookie: cookie.split(';')[0]! },
    });
    expect(refreshed.data?.refreshSession.accessToken).toBeTruthy();
  });

  it('magic link: accesso monouso e nessuna enumerazione degli utenti', async () => {
    const u = await registerUser(t);
    const unknown = await t.gql<{ requestMagicLink: boolean }>(`mutation { requestMagicLink(email: "nessuno@example.test") }`);
    expect(unknown.data?.requestMagicLink).toBe(true);

    await t.gql(`mutation ($e: String!) { requestMagicLink(email: $e) }`, { e: u.email });
    const mail = t.mail.outbox.findLast((m) => m.to === u.email)!;
    expect(mail.text).toContain('huddle://auth/magic?token=');
    const token = tokenFromMail(mail.text);

    const CONSUME = `mutation ($t: String!) { consumeMagicLink(token: $t) { status accessToken } }`;
    const ok = await t.gql<{ consumeMagicLink: { status: string } }>(CONSUME, { t: token });
    expect(ok.data?.consumeMagicLink.status).toBe('AUTHENTICATED');
    const again = await t.gql(CONSUME, { t: token });
    expect(again.errors?.[0]?.extensions?.code).toBe('INVALID_TOKEN');
  });

  it('reset password revoca le sessioni esistenti', async () => {
    const u = await registerUser(t);
    await t.gql(`mutation ($e: String!) { requestPasswordReset(email: $e) }`, { e: u.email });
    const token = tokenFromMail(t.mail.outbox.findLast((m) => m.to === u.email)!.text);
    const reset = await t.gql(`mutation ($t: String!, $p: String!) { resetPassword(token: $t, newPassword: $p) }`, {
      t: token,
      p: 'nuova-password-456',
    });
    expect(reset.errors).toBeUndefined();
    const old = await t.gql(REFRESH, { t: u.refreshToken });
    expect(old.errors?.[0]?.extensions?.code).toBe('INVALID_TOKEN');
    const login = await t.gql<{ login: { status: string } }>(LOGIN, { input: { email: u.email, password: 'nuova-password-456' } });
    expect(login.data?.login.status).toBe('AUTHENTICATED');
  });

  it('2FA: sfida al login, codice errato non invalida la sfida, codice di recupero monouso', async () => {
    const u = await registerUser(t);
    const tfa = await enableTwoFactor(t, u.token);
    expect(tfa.recoveryCodes).toHaveLength(8);

    const login = await t.gql<{ login: { status: string; accessToken: string | null; challengeToken: string } }>(LOGIN, {
      input: { email: u.email, password: 'password-sicura-123' },
    });
    expect(login.data?.login.status).toBe('TWO_FACTOR_REQUIRED');
    expect(login.data?.login.accessToken).toBeNull();

    const VERIFY = `mutation ($c: String!, $code: String!) { verifyTwoFactor(challengeToken: $c, code: $code) { status accessToken } }`;
    const challenge = login.data!.login.challengeToken;
    const wrong = await t.gql(VERIFY, { c: challenge, code: '000000' });
    expect(wrong.errors?.[0]?.extensions?.code).toBe('INVALID_TWO_FACTOR_CODE');
    const ok = await t.gql<{ verifyTwoFactor: { status: string } }>(VERIFY, { c: challenge, code: await tfa.code() });
    expect(ok.data?.verifyTwoFactor.status).toBe('AUTHENTICATED');

    const recovery = tfa.recoveryCodes[0]!;
    const second = await t.gql<{ login: { challengeToken: string } }>(LOGIN, {
      input: { email: u.email, password: 'password-sicura-123' },
    });
    const viaRecovery = await t.gql<{ verifyTwoFactor: { status: string } }>(VERIFY, {
      c: second.data!.login.challengeToken,
      code: recovery,
    });
    expect(viaRecovery.data?.verifyTwoFactor.status).toBe('AUTHENTICATED');

    const third = await t.gql<{ login: { challengeToken: string } }>(LOGIN, {
      input: { email: u.email, password: 'password-sicura-123' },
    });
    const reused = await t.gql(VERIFY, { c: third.data!.login.challengeToken, code: recovery });
    expect(reused.errors?.[0]?.extensions?.code).toBe('INVALID_TWO_FACTOR_CODE');
  });

  it('i login falliti finiscono nel registro di audit nonostante il rollback', async () => {
    const u = await registerUser(t);
    await t.gql(LOGIN, { input: { email: u.email, password: 'sbagliata-123456' } });
    const pg = await import('pg');
    const pool = new pg.default.Pool({ connectionString: process.env.DATABASE_OWNER_URL });
    const r = await pool.query(`select count(*)::int as n from audit_events where action = 'auth.login_failed' and actor_user_id = $1`, [u.userId]);
    await pool.end();
    expect(r.rows[0].n).toBe(1);
  });
});
