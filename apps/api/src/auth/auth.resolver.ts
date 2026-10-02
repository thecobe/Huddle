import { UseGuards } from '@nestjs/common';
import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { Throttle } from '@nestjs/throttler';
import { CurrentUserId, GqlRequest, Public } from '../common/decorators.js';
import { appError } from '../common/errors.js';
import type { GqlContext } from '../common/request-context.js';
import { UsersService } from '../users/users.service.js';
import { AuthPayload, LoginInput, RegisterInput, TwoFactorSetup } from './auth.models.js';
import { AuthService, type ClientInfo } from './auth.service.js';
import { GqlThrottlerGuard } from './gql-throttler.guard.js';
import { SessionResponder } from './session-responder.js';
import { readRefreshCookie } from './session-transport.js';

@Resolver()
@UseGuards(GqlThrottlerGuard)
@Throttle({ default: { limit: 10, ttl: 60_000 } })
export class AuthResolver {
  constructor(
    private readonly auth: AuthService,
    private readonly users: UsersService,
    private readonly responder: SessionResponder,
  ) {}

  @Public()
  @Mutation(() => AuthPayload)
  async register(@Args('input') input: RegisterInput, @GqlRequest() gql: GqlContext): Promise<AuthPayload> {
    return this.responder.deliver(await this.auth.register(input, client(gql)), gql);
  }

  @Public()
  @Mutation(() => AuthPayload)
  async login(@Args('input') input: LoginInput, @GqlRequest() gql: GqlContext): Promise<AuthPayload> {
    return this.responder.deliver(await this.auth.login(input.email, input.password, client(gql)), gql);
  }

  @Public()
  @Mutation(() => AuthPayload)
  async verifyTwoFactor(
    @Args('challengeToken') challengeToken: string,
    @Args('code') code: string,
    @GqlRequest() gql: GqlContext,
  ): Promise<AuthPayload> {
    return this.responder.deliver(await this.auth.verifyTwoFactor(challengeToken, code, client(gql)), gql);
  }

  @Public()
  @Mutation(() => Boolean, { description: "Invia un link di accesso via e-mail. Restituisce sempre true." })
  requestMagicLink(@Args('email', { type: () => String }) email: string): Promise<boolean> {
    assertEmail(email);
    return this.auth.requestMagicLink(email);
  }

  @Public()
  @Mutation(() => AuthPayload)
  async consumeMagicLink(@Args('token') token: string, @GqlRequest() gql: GqlContext): Promise<AuthPayload> {
    return this.responder.deliver(await this.auth.consumeMagicLink(token, client(gql)), gql);
  }

  @Public()
  @Mutation(() => Boolean, { description: 'Restituisce sempre true.' })
  requestPasswordReset(@Args('email', { type: () => String }) email: string): Promise<boolean> {
    assertEmail(email);
    return this.auth.requestPasswordReset(email);
  }

  @Public()
  @Mutation(() => Boolean)
  resetPassword(
    @Args('token') token: string,
    @Args('newPassword') newPassword: string,
    @GqlRequest() gql: GqlContext,
  ): Promise<boolean> {
    return this.auth.resetPassword(token, newPassword, client(gql));
  }

  @Mutation(() => Boolean)
  changePassword(
    @CurrentUserId() userId: string,
    @Args('currentPassword', { defaultValue: '' }) currentPassword: string,
    @Args('newPassword') newPassword: string,
  ): Promise<boolean> {
    return this.auth.changePassword(userId, currentPassword, newPassword);
  }

  @Public()
  @Throttle({ default: { limit: 60, ttl: 60_000 } })
  @Mutation(() => AuthPayload, {
    description: 'Rinnova la sessione. Il client web omette refreshToken e usa il cookie.',
  })
  async refreshSession(
    @Args('refreshToken', { type: () => String, nullable: true }) refreshToken: string | null,
    @GqlRequest() gql: GqlContext,
  ): Promise<AuthPayload> {
    const token = refreshToken ?? readRefreshCookie(gql.req);
    if (!token) throw appError('INVALID_TOKEN');
    const session = await this.auth.refresh(token, client(gql));
    const user = await this.users.getMe(session.userId);
    return this.responder.deliverSession(session, user, gql);
  }

  @Public()
  @Mutation(() => Boolean)
  async logout(
    @Args('refreshToken', { type: () => String, nullable: true }) refreshToken: string | null,
    @GqlRequest() gql: GqlContext,
  ): Promise<boolean> {
    const token = refreshToken ?? readRefreshCookie(gql.req);
    if (token) await this.auth.logout(token);
    this.responder.clear(gql);
    return true;
  }

  @Mutation(() => TwoFactorSetup)
  setupTwoFactor(@CurrentUserId() userId: string): Promise<TwoFactorSetup> {
    return this.auth.setupTwoFactor(userId);
  }

  @Mutation(() => [String], { description: 'Attiva il 2FA e restituisce i codici di recupero.' })
  enableTwoFactor(@CurrentUserId() userId: string, @Args('code') code: string): Promise<string[]> {
    return this.auth.enableTwoFactor(userId, code);
  }

  @Mutation(() => Boolean)
  disableTwoFactor(@CurrentUserId() userId: string, @Args('code') code: string): Promise<boolean> {
    return this.auth.disableTwoFactor(userId, code);
  }
}

export function client(gql: GqlContext): ClientInfo {
  return { ip: gql.req.ip ?? null, userAgent: gql.req.header('user-agent') ?? null };
}

function assertEmail(email: string): void {
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) throw appError('BAD_USER_INPUT', 'E-mail non valida');
}
