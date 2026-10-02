import { Inject, Injectable } from '@nestjs/common';
import { ENV, type Env } from '../config/env.js';
import { AuditService } from '../audit/audit.service.js';
import { appError } from '../common/errors.js';
import { ConsentsService } from '../consents/consents.service.js';
import { DbContext } from '../database/db-context.js';
import { MailService } from '../mail/mail.service.js';
import { UsersService } from '../users/users.service.js';
import { AuthPayload, AuthStatus, type RegisterInput, type TwoFactorSetup } from './auth.models.js';
import { PasswordService } from './password.service.js';
import { type Session, TokenService } from './token.service.js';
import { TotpService } from './totp.service.js';

export interface ClientInfo {
  ip: string | null;
  userAgent: string | null;
}

export type AuthResult =
  | { status: AuthStatus.AUTHENTICATED; session: Session; payload: AuthPayload }
  | { status: AuthStatus.TWO_FACTOR_REQUIRED; payload: AuthPayload };

@Injectable()
export class AuthService {
  constructor(
    @Inject(ENV) private readonly env: Env,
    private readonly ctx: DbContext,
    private readonly passwords: PasswordService,
    private readonly tokens: TokenService,
    private readonly totp: TotpService,
    private readonly users: UsersService,
    private readonly consents: ConsentsService,
    private readonly mail: MailService,
    private readonly audit: AuditService,
  ) {}

  async register(input: RegisterInput, client: ClientInfo): Promise<AuthResult> {
    const existing = await this.findUserByEmail(input.email);
    if (existing) throw appError('EMAIL_TAKEN');
    const user = await this.ctx.db
      .insertInto('users')
      .values({
        email: input.email.trim(),
        full_name: input.fullName.trim(),
        password_hash: await this.passwords.hash(input.password),
        locale: input.locale ?? 'it',
      })
      .returning('id')
      .executeTakeFirstOrThrow()
      .catch((err: { code?: string }) => {
        // Registrazione concorrente con la stessa e-mail.
        if (err.code === '23505') throw appError('EMAIL_TAKEN');
        throw err;
      });
    await this.consents.acceptPlatformTerms(user.id, client.ip);
    await this.audit.record({ action: 'auth.register', tenantId: null, actorUserId: user.id, ...auditClient(client) });
    return this.completeLogin(user.id, client, { skipTwoFactor: true });
  }

  async login(email: string, password: string, client: ClientInfo): Promise<AuthResult> {
    const user = await this.findUserByEmail(email);
    const ok = await this.passwords.verify(user?.password_hash ?? null, password);
    if (!user || !ok) {
      await this.audit.recordDetached({
        action: 'auth.login_failed',
        tenantId: null,
        actorUserId: user?.id ?? null,
        metadata: { email },
        ...auditClient(client),
      });
      throw appError('INVALID_CREDENTIALS');
    }
    return this.completeLogin(user.id, client);
  }

  /** Crea sessione o, se l'utente ha il 2FA attivo, una sfida da completare con verifyTwoFactor. */
  async completeLogin(userId: string, client: ClientInfo, opts: { skipTwoFactor?: boolean } = {}): Promise<AuthResult> {
    const user = await this.ctx.db
      .selectFrom('users')
      .select(['totp_enabled_at'])
      .where('id', '=', userId)
      .executeTakeFirstOrThrow();
    if (user.totp_enabled_at && !opts.skipTwoFactor) {
      const challengeToken = await this.tokens.issueOneTimeToken(userId, 'TWO_FACTOR_CHALLENGE');
      return {
        status: AuthStatus.TWO_FACTOR_REQUIRED,
        payload: { ...emptyPayload(AuthStatus.TWO_FACTOR_REQUIRED), challengeToken },
      };
    }
    const session = await this.tokens.createSession(userId, client.userAgent);
    await this.audit.record({ action: 'auth.login', tenantId: null, actorUserId: userId, ...auditClient(client) });
    return {
      status: AuthStatus.AUTHENTICATED,
      session,
      payload: {
        ...emptyPayload(AuthStatus.AUTHENTICATED),
        accessToken: session.accessToken,
        accessTokenExpiresAt: session.accessTokenExpiresAt,
        refreshToken: session.refreshToken,
        user: await this.users.getMe(userId),
      },
    };
  }

  async verifyTwoFactor(challengeToken: string, code: string, client: ClientInfo): Promise<AuthResult> {
    const userId = await this.tokens.peekOneTimeToken(challengeToken, 'TWO_FACTOR_CHALLENGE');
    const user = await this.ctx.db
      .selectFrom('users')
      .select(['totp_secret_enc', 'totp_recovery_hashes'])
      .where('id', '=', userId)
      .executeTakeFirstOrThrow();
    let valid = user.totp_secret_enc ? await this.totp.verifyCode(user.totp_secret_enc, code) : false;
    if (!valid) {
      const remaining = this.totp.consumeRecoveryCode(user.totp_recovery_hashes, code);
      if (remaining) {
        valid = true;
        await this.ctx.db.updateTable('users').set({ totp_recovery_hashes: remaining }).where('id', '=', userId).execute();
        await this.audit.record({ action: 'auth.recovery_code_used', tenantId: null, actorUserId: userId });
      }
    }
    if (!valid) {
      await this.audit.recordDetached({ action: 'auth.two_factor_failed', tenantId: null, actorUserId: userId, ...auditClient(client) });
      throw appError('INVALID_TWO_FACTOR_CODE');
    }
    await this.tokens.consumeOneTimeToken(challengeToken, 'TWO_FACTOR_CHALLENGE');
    return this.completeLogin(userId, client, { skipTwoFactor: true });
  }

  /** Risponde sempre true: non rivela se l'e-mail è registrata. */
  async requestMagicLink(email: string): Promise<boolean> {
    const user = await this.findUserByEmail(email);
    if (!user) return true;
    const token = await this.tokens.issueOneTimeToken(user.id, 'MAGIC_LINK');
    await this.mail.send(user.email, user.locale, {
      kind: 'magic-link',
      webUrl: `${this.env.WEB_URL}/auth/magic?token=${token}`,
      appUrl: `${this.env.MOBILE_DEEP_LINK_SCHEME}://auth/magic?token=${token}`,
    });
    return true;
  }

  async consumeMagicLink(token: string, client: ClientInfo): Promise<AuthResult> {
    const userId = await this.tokens.consumeOneTimeToken(token, 'MAGIC_LINK');
    return this.completeLogin(userId, client);
  }

  async requestPasswordReset(email: string): Promise<boolean> {
    const user = await this.findUserByEmail(email);
    if (!user) return true;
    const token = await this.tokens.issueOneTimeToken(user.id, 'PASSWORD_RESET');
    await this.mail.send(user.email, user.locale, {
      kind: 'password-reset',
      webUrl: `${this.env.WEB_URL}/auth/reset-password?token=${token}`,
    });
    return true;
  }

  async resetPassword(token: string, newPassword: string, client: ClientInfo): Promise<boolean> {
    const passwordHash = await this.passwords.hash(newPassword);
    const userId = await this.tokens.consumeOneTimeToken(token, 'PASSWORD_RESET');
    await this.ctx.db.updateTable('users').set({ password_hash: passwordHash }).where('id', '=', userId).execute();
    await this.tokens.revokeAllForUser(userId);
    await this.audit.record({ action: 'auth.password_reset', tenantId: null, actorUserId: userId, ...auditClient(client) });
    return true;
  }

  async changePassword(userId: string, currentPassword: string, newPassword: string): Promise<boolean> {
    const user = await this.ctx.db.selectFrom('users').select('password_hash').where('id', '=', userId).executeTakeFirstOrThrow();
    // Chi ha sempre usato il magic link non ha password: può impostarla senza quella attuale.
    if (user.password_hash && !(await this.passwords.verify(user.password_hash, currentPassword))) {
      throw appError('INVALID_CREDENTIALS');
    }
    const passwordHash = await this.passwords.hash(newPassword);
    await this.ctx.db.updateTable('users').set({ password_hash: passwordHash }).where('id', '=', userId).execute();
    await this.audit.record({ action: 'auth.password_changed', tenantId: null, actorUserId: userId });
    return true;
  }

  refresh(refreshToken: string, client: ClientInfo): Promise<Session> {
    return this.tokens.rotate(refreshToken, client.userAgent);
  }

  logout(refreshToken: string): Promise<void> {
    return this.tokens.revoke(refreshToken);
  }

  async setupTwoFactor(userId: string): Promise<TwoFactorSetup> {
    const user = await this.ctx.db
      .selectFrom('users')
      .select(['email', 'totp_enabled_at'])
      .where('id', '=', userId)
      .executeTakeFirstOrThrow();
    if (user.totp_enabled_at) throw appError('BAD_USER_INPUT', '2FA già attivo');
    const { secret, secretEnc, otpauthUri } = this.totp.createSecret(user.email);
    await this.ctx.db.updateTable('users').set({ totp_secret_enc: secretEnc }).where('id', '=', userId).execute();
    return { secret, otpauthUri };
  }

  /** Attiva il 2FA dopo aver verificato un codice; restituisce i codici di recupero (mostrati una sola volta). */
  async enableTwoFactor(userId: string, code: string): Promise<string[]> {
    const user = await this.ctx.db
      .selectFrom('users')
      .select(['totp_secret_enc', 'totp_enabled_at'])
      .where('id', '=', userId)
      .executeTakeFirstOrThrow();
    if (user.totp_enabled_at) throw appError('BAD_USER_INPUT', '2FA già attivo');
    if (!user.totp_secret_enc || !(await this.totp.verifyCode(user.totp_secret_enc, code))) {
      throw appError('INVALID_TWO_FACTOR_CODE');
    }
    const { codes, hashes } = this.totp.createRecoveryCodes();
    await this.ctx.db
      .updateTable('users')
      .set({ totp_enabled_at: new Date(), totp_recovery_hashes: hashes })
      .where('id', '=', userId)
      .execute();
    await this.audit.record({ action: 'auth.two_factor_enabled', tenantId: null, actorUserId: userId });
    return codes;
  }

  async disableTwoFactor(userId: string, code: string): Promise<boolean> {
    const user = await this.ctx.db
      .selectFrom('users')
      .select(['totp_secret_enc', 'totp_enabled_at'])
      .where('id', '=', userId)
      .executeTakeFirstOrThrow();
    if (!user.totp_enabled_at || !user.totp_secret_enc) return true;
    if (!(await this.totp.verifyCode(user.totp_secret_enc, code))) throw appError('INVALID_TWO_FACTOR_CODE');
    await this.ctx.db
      .updateTable('users')
      .set({ totp_enabled_at: null, totp_secret_enc: null, totp_recovery_hashes: [] })
      .where('id', '=', userId)
      .execute();
    await this.audit.record({ action: 'auth.two_factor_disabled', tenantId: null, actorUserId: userId });
    return true;
  }

  findUserByEmail(email: string) {
    return this.ctx.db
      .selectFrom('users')
      .select(['id', 'email', 'password_hash', 'locale'])
      .where('email', '=', email.trim())
      .executeTakeFirst();
  }
}

function emptyPayload(status: AuthStatus): AuthPayload {
  return {
    status,
    accessToken: null,
    accessTokenExpiresAt: null,
    refreshToken: null,
    challengeToken: null,
    user: null,
  };
}

function auditClient(client: ClientInfo) {
  return { ip: client.ip, userAgent: client.userAgent };
}
