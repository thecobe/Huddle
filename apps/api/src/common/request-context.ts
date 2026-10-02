import type { Request, Response } from 'express';
import type { MembershipRole } from '../database/types.js';

export interface TenantAccess {
  tenantId: string;
  roles: MembershipRole[];
  /** Squadre a cui è limitato ciascun ruolo; `null` = tutta la società. */
  memberships: { role: MembershipRole; teamId: string | null }[];
}

export interface GqlContext {
  req: Request;
  res: Response;
  userId?: string;
  tenant?: TenantAccess;
}
