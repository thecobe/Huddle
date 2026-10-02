import type { MembershipRole } from '@/gql/graphql';

// Copia lato interfaccia di apps/api/src/permissions/permissions.ts: serve solo a mostrare o
// nascondere elementi. L'autorizzazione vera resta sul server.
export type Permission =
  | 'club.manage'
  | 'season.manage'
  | 'member.view'
  | 'member.invite'
  | 'member.manage'
  | 'audit.view';

const ROLE_PERMISSIONS: Record<Permission, MembershipRole[]> = {
  'club.manage': ['ADMIN'],
  'season.manage': ['ADMIN', 'SECRETARY'],
  'member.view': ['ADMIN', 'SECRETARY', 'SPORTS_DIRECTOR'],
  'member.invite': ['ADMIN', 'SECRETARY'],
  'member.manage': ['ADMIN'],
  'audit.view': ['ADMIN'],
};

export const TWO_FACTOR_ROLES: MembershipRole[] = ['ADMIN', 'SECRETARY'];
export const ADMIN_ASSIGNED_ROLES: MembershipRole[] = ['ADMIN', 'SECRETARY', 'SPORTS_DIRECTOR'];
export const ALL_ROLES: MembershipRole[] = [
  'ADMIN',
  'SECRETARY',
  'SPORTS_DIRECTOR',
  'COACH',
  'TEAM_MANAGER',
  'ATHLETE',
  'PARENT',
];

export function can(roles: MembershipRole[], permission: Permission): boolean {
  return roles.some((r) => ROLE_PERMISSIONS[permission].includes(r));
}
