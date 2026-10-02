import { randomUUID } from 'node:crypto';
import { Inject, Injectable } from '@nestjs/common';
import { jwtVerify, SignJWT } from 'jose';
import { ENV, type Env } from '../config/env.js';
import { randomToken, sha256 } from '../common/crypto.js';
import { appError } from '../common/errors.js';
import { DbContext } from '../database/db-context.js';
import type { AuthTokenPurpose } from '../database/types.js';

export const ACCESS_TOKEN_TTL_SECONDS = 15 * 60;
export const REFRESH_TOKEN_TTL_DAYS = 30;

const TOKEN_TTL_MINUTES: Record<AuthTokenPurpose, number> = {
  MAGIC_LINK: 15,
  PASSWORD_RESET: 30,
  TWO_FACTOR_CHALLENGE: 5,
};

export interface Session {
  userId: string;
  accessToken: string;
  accessTokenExpiresAt: Date;
  refreshToken: string;
}

@Injectable()
export class TokenService {
  private readonly key: Uint8Array;

  constructor(
    @Inject(ENV) env: Env,
    private readonly ctx: DbContext,
  ) {
    this.key = new TextEncoder().encode(env.JWT_SECRET);
  }

  async verifyAccessToken(token: string): Promise<string> {
    try {
      const { payload } = await jwtVerify(token, this.key, { algorithms: ['HS256'], audience: 'huddle' });
      if (payload.typ !== 'access' || typeof payload.sub !== 'string') throw new Error('typ');
      return payload.sub;
    } catch {
      throw appError('UNAUTHENTICATED');
    }
  }

  async createSession(userId: string, userAgent: string | null, familyId: string = randomUUID()): Promise<Session> {
    const accessTokenExpiresAt = new Date(Date.now() + ACCESS_TOKEN_TTL_SECONDS * 1000);
    const accessToken = await new SignJWT({ typ: 'access' })
      .setProtectedHeader({ alg: 'HS256' })
      .setSubject(userId)
      .setAudience('huddle')
      .setIssuedAt()
      .setExpirationTime(accessTokenExpiresAt)
      .sign(this.key);

    const refreshToken = randomToken();
    await this.ctx.db
      .insertInto('refresh_tokens')
      .values({
        user_id: userId,
        family_id: familyId,
        token_hash: sha256(refreshToken),
        expires_at: new Date(Date.now() + REFRESH_TOKEN_TTL_DAYS * 86_400_000),
        user_agent: userAgent,
      })
      .execute();
    return { userId, accessToken, accessTokenExpiresAt, refreshToken };
  }

  /**
   * Rotazione del refresh token. Il riuso di un token già ruotato indica un possibile furto:
   * viene revocata l'intera famiglia di sessioni.
   */
  async rotate(refreshToken: string, userAgent: string | null): Promise<Session> {
    const row = await this.ctx.db
      .selectFrom('refresh_tokens')
      .selectAll()
      .where('token_hash', '=', sha256(refreshToken))
      .executeTakeFirst();
    if (!row || row.expires_at < new Date()) throw appError('INVALID_TOKEN');
    if (row.revoked_at) {
      // Transazione separata: l'errore seguente annulla quella della richiesta.
      await this.ctx.runDetached({}, () => this.revokeFamily(row.family_id));
      throw appError('INVALID_TOKEN');
    }
    const session = await this.createSession(row.user_id, userAgent, row.family_id);
    const next = await this.ctx.db
      .selectFrom('refresh_tokens')
      .select('id')
      .where('token_hash', '=', sha256(session.refreshToken))
      .executeTakeFirstOrThrow();
    await this.ctx.db
      .updateTable('refresh_tokens')
      .set({ revoked_at: new Date(), replaced_by: next.id })
      .where('id', '=', row.id)
      .execute();
    return session;
  }

  async revoke(refreshToken: string): Promise<void> {
    await this.ctx.db
      .updateTable('refresh_tokens')
      .set({ revoked_at: new Date() })
      .where('token_hash', '=', sha256(refreshToken))
      .where('revoked_at', 'is', null)
      .execute();
  }

  async revokeAllForUser(userId: string): Promise<void> {
    await this.ctx.db
      .updateTable('refresh_tokens')
      .set({ revoked_at: new Date() })
      .where('user_id', '=', userId)
      .where('revoked_at', 'is', null)
      .execute();
  }

  private async revokeFamily(familyId: string): Promise<void> {
    await this.ctx.db
      .updateTable('refresh_tokens')
      .set({ revoked_at: new Date() })
      .where('family_id', '=', familyId)
      .where('revoked_at', 'is', null)
      .execute();
  }

  /** Token monouso (magic link, reset password, sfida 2FA). */
  async issueOneTimeToken(userId: string, purpose: AuthTokenPurpose): Promise<string> {
    const token = randomToken();
    await this.ctx.db
      .insertInto('auth_tokens')
      .values({
        user_id: userId,
        purpose,
        token_hash: sha256(token),
        expires_at: new Date(Date.now() + TOKEN_TTL_MINUTES[purpose] * 60_000),
      })
      .execute();
    return token;
  }

  /** Verifica senza consumare (sfida 2FA: un codice errato non deve invalidare la sfida). */
  async peekOneTimeToken(token: string, purpose: AuthTokenPurpose): Promise<string> {
    const row = await this.ctx.db
      .selectFrom('auth_tokens')
      .select('user_id')
      .where('token_hash', '=', sha256(token))
      .where('purpose', '=', purpose)
      .where('consumed_at', 'is', null)
      .where('expires_at', '>', new Date())
      .executeTakeFirst();
    if (!row) throw appError('INVALID_TOKEN');
    return row.user_id;
  }

  async consumeOneTimeToken(token: string, purpose: AuthTokenPurpose): Promise<string> {
    const row = await this.ctx.db
      .updateTable('auth_tokens')
      .set({ consumed_at: new Date() })
      .where('token_hash', '=', sha256(token))
      .where('purpose', '=', purpose)
      .where('consumed_at', 'is', null)
      .where('expires_at', '>', new Date())
      .returning('user_id')
      .executeTakeFirst();
    if (!row) throw appError('INVALID_TOKEN');
    return row.user_id;
  }
}
