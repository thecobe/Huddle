import { Inject, Injectable } from '@nestjs/common';
import { ENV, type Env } from '../config/env.js';
import type { GqlContext } from '../common/request-context.js';
import { AuthPayload, AuthStatus } from './auth.models.js';
import type { AuthResult } from './auth.service.js';
import { clearRefreshCookie, isWebClient, setRefreshCookie } from './session-transport.js';
import type { Session } from './token.service.js';

/** Consegna la sessione al client: cookie httpOnly per il web, corpo della risposta per le app. */
@Injectable()
export class SessionResponder {
  constructor(@Inject(ENV) private readonly env: Env) {}

  deliver(result: AuthResult, gql: GqlContext): AuthPayload {
    if (result.status !== AuthStatus.AUTHENTICATED) return result.payload;
    return this.deliverSession(result.session, result.payload.user, gql);
  }

  deliverSession(session: Session, user: AuthPayload['user'], gql: GqlContext): AuthPayload {
    const web = isWebClient(gql.req);
    if (web) setRefreshCookie(gql.res, session.refreshToken, this.secure);
    return {
      status: AuthStatus.AUTHENTICATED,
      accessToken: session.accessToken,
      accessTokenExpiresAt: session.accessTokenExpiresAt,
      refreshToken: web ? null : session.refreshToken,
      challengeToken: null,
      user,
    };
  }

  clear(gql: GqlContext): void {
    clearRefreshCookie(gql.res, this.secure);
  }

  private get secure(): boolean {
    return this.env.NODE_ENV === 'production';
  }
}
