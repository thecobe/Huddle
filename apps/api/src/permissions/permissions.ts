import type { MembershipRole } from '../database/types.js';
import type { TenantAccess } from '../common/request-context.js';

export enum Permission {
  ClubView = 'club.view',
  ClubManage = 'club.manage',
  SeasonView = 'season.view',
  SeasonManage = 'season.manage',
  MemberView = 'member.view',
  MemberInvite = 'member.invite',
  MemberManage = 'member.manage',
  AuditView = 'audit.view',
}

const ALL_ROLES: MembershipRole[] = [
  'ADMIN',
  'SECRETARY',
  'SPORTS_DIRECTOR',
  'COACH',
  'TEAM_MANAGER',
  'ATHLETE',
  'PARENT',
];

export const ROLE_PERMISSIONS: Record<Permission, MembershipRole[]> = {
  [Permission.ClubView]: ALL_ROLES,
  [Permission.ClubManage]: ['ADMIN'],
  [Permission.SeasonView]: ALL_ROLES,
  [Permission.SeasonManage]: ['ADMIN', 'SECRETARY'],
  [Permission.MemberView]: ['ADMIN', 'SECRETARY', 'SPORTS_DIRECTOR'],
  [Permission.MemberInvite]: ['ADMIN', 'SECRETARY'],
  [Permission.MemberManage]: ['ADMIN'],
  [Permission.AuditView]: ['ADMIN'],
};

/** Ruoli con accesso a dati amministrativi o sanitari: 2FA obbligatorio. */
export const TWO_FACTOR_ROLES: MembershipRole[] = ['ADMIN', 'SECRETARY'];

/** Ruoli che solo un amministratore può assegnare. */
export const ADMIN_ASSIGNED_ROLES: MembershipRole[] = ['ADMIN', 'SECRETARY', 'SPORTS_DIRECTOR'];

/** Ruoli che hanno senso solo se legati a una squadra. */
export const TEAM_SCOPED_ROLES: MembershipRole[] = ['COACH', 'TEAM_MANAGER', 'ATHLETE', 'PARENT'];

export function hasPermission(access: Pick<TenantAccess, 'roles'>, permission: Permission): boolean {
  return access.roles.some((r) => ROLE_PERMISSIONS[permission].includes(r));
}

/**
 * Squadre su cui l'utente esercita il permesso: `'ALL'` se almeno un ruolo che lo concede vale per
 * tutta la società, altrimenti l'elenco delle squadre dei ruoli limitati.
 */
export function teamScope(access: TenantAccess, permission: Permission): 'ALL' | string[] {
  const granting = access.memberships.filter((m) => ROLE_PERMISSIONS[permission].includes(m.role));
  if (granting.some((m) => m.teamId === null)) return 'ALL';
  return [...new Set(granting.map((m) => m.teamId).filter((t): t is string => t !== null))];
}
