import { describe, expect, it } from 'vitest';
import { hasPermission, Permission, teamScope } from './permissions.js';

describe('permissions', () => {
  it('concede la gestione società solo agli amministratori', () => {
    expect(hasPermission({ roles: ['ADMIN'] }, Permission.ClubManage)).toBe(true);
    expect(hasPermission({ roles: ['SECRETARY', 'COACH'] }, Permission.ClubManage)).toBe(false);
  });

  it('limita un allenatore alle proprie squadre', () => {
    const access = {
      tenantId: 't',
      roles: ['COACH' as const],
      memberships: [
        { role: 'COACH' as const, teamId: 'u15' },
        { role: 'COACH' as const, teamId: 'u17' },
      ],
    };
    expect(teamScope(access, Permission.SeasonView)).toEqual(['u15', 'u17']);
  });

  it('un ruolo a livello società vale per tutte le squadre', () => {
    const access = {
      tenantId: 't',
      roles: ['COACH' as const, 'SPORTS_DIRECTOR' as const],
      memberships: [
        { role: 'COACH' as const, teamId: 'u15' },
        { role: 'SPORTS_DIRECTOR' as const, teamId: null },
      ],
    };
    expect(teamScope(access, Permission.SeasonView)).toBe('ALL');
  });
});
