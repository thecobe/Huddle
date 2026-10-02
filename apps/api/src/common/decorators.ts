import { createParamDecorator, type ExecutionContext, SetMetadata } from '@nestjs/common';
import { GqlExecutionContext } from '@nestjs/graphql';
import type { Permission } from '../permissions/permissions.js';
import { appError } from './errors.js';
import type { GqlContext, TenantAccess } from './request-context.js';

export const IS_PUBLIC = 'huddle:public';
export const REQUIRED_PERMISSION = 'huddle:permission';

/** Accessibile senza login. */
export const Public = () => SetMetadata(IS_PUBLIC, true);

/** Richiede la società corrente (header `X-Tenant-Id`) e il permesso indicato. */
export const RequirePermission = (permission: Permission) => SetMetadata(REQUIRED_PERMISSION, permission);

export function gqlContext(ctx: ExecutionContext): GqlContext {
  return GqlExecutionContext.create(ctx).getContext<GqlContext>();
}

export const CurrentUserId = createParamDecorator((_: unknown, ctx: ExecutionContext): string => {
  const userId = gqlContext(ctx).userId;
  if (!userId) throw appError('UNAUTHENTICATED');
  return userId;
});

export const CurrentTenant = createParamDecorator((_: unknown, ctx: ExecutionContext): TenantAccess => {
  const tenant = gqlContext(ctx).tenant;
  if (!tenant) throw appError('TENANT_REQUIRED');
  return tenant;
});

export const GqlRequest = createParamDecorator((_: unknown, ctx: ExecutionContext) => gqlContext(ctx));
