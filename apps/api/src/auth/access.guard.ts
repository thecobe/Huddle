import { type CanActivate, type ExecutionContext, Inject, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import type { GqlContextType } from '@nestjs/graphql';
import { ENV, type Env } from '../config/env.js';
import { gqlContext, IS_PUBLIC, REQUIRED_PERMISSION } from '../common/decorators.js';
import { appError } from '../common/errors.js';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import { hasPermission, type Permission, TWO_FACTOR_ROLES } from '../permissions/permissions.js';
import { TokenService } from './token.service.js';

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export const TENANT_HEADER = 'x-tenant-id';

/**
 * Guard globale per le operazioni GraphQL:
 * 1. autentica il bearer token;
 * 2. se presente l'header X-Tenant-Id, verifica l'appartenenza alla società e il 2FA per i ruoli sensibili;
 * 3. applica il permesso richiesto con @RequirePermission.
 * Lo scope della transazione (DbScopeInterceptor) usa solo valori validati qui.
 */
@Injectable()
export class AccessGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly tokens: TokenService,
    private readonly db: DbContext,
    @Inject(ENV) private readonly env: Env,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    if (context.getType<GqlContextType>() !== 'graphql') return true;
    const gql = gqlContext(context);
    const targets = [context.getHandler(), context.getClass()];
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC, targets) ?? false;
    const permission = this.reflector.getAllAndOverride<Permission | undefined>(REQUIRED_PERMISSION, targets);

    const bearer = gql.req.header('authorization')?.match(/^Bearer (.+)$/i)?.[1];
    if (bearer) {
      try {
        gql.userId = await this.tokens.verifyAccessToken(bearer);
      } catch (err) {
        if (!isPublic) throw err;
      }
    }
    if (!isPublic && !gql.userId) throw appError('UNAUTHENTICATED');

    const tenantId = gql.req.header(TENANT_HEADER);
    if (tenantId && gql.userId) {
      if (!UUID.test(tenantId)) throw appError('BAD_USER_INPUT', 'X-Tenant-Id non valido');
      gql.tenant = await this.loadAccess(gql.userId, tenantId, permission !== undefined);
    }

    if (permission) {
      if (!gql.tenant) throw appError('TENANT_REQUIRED');
      if (!hasPermission(gql.tenant, permission)) throw appError('FORBIDDEN');
    }
    return true;
  }

  private async loadAccess(userId: string, tenantId: string, enforceTwoFactor: boolean): Promise<TenantAccess> {
    const { rows, twoFactorEnabled } = await this.db.run({ userId, tenantId }, async () => {
      const rows = await this.db.db
        .selectFrom('memberships')
        .select(['role', 'team_id'])
        .where('tenant_id', '=', tenantId)
        .where('user_id', '=', userId)
        .execute();
      const user = await this.db.db
        .selectFrom('users')
        .select('totp_enabled_at')
        .where('id', '=', userId)
        .executeTakeFirst();
      return { rows, twoFactorEnabled: !!user?.totp_enabled_at };
    });
    if (rows.length === 0) throw appError('FORBIDDEN');
    const roles = [...new Set(rows.map((r) => r.role))];
    if (
      enforceTwoFactor &&
      this.env.REQUIRE_2FA_FOR_ADMIN_ROLES &&
      !twoFactorEnabled &&
      roles.some((r) => TWO_FACTOR_ROLES.includes(r))
    ) {
      throw appError('TWO_FACTOR_SETUP_REQUIRED');
    }
    return { tenantId, roles, memberships: rows.map((r) => ({ role: r.role, teamId: r.team_id })) };
  }
}
