import { Injectable } from '@nestjs/common';
import { appError } from '../common/errors.js';
import type { MembershipRoleEnum } from '../common/enums.js';
import { DbContext } from '../database/db-context.js';
import type { Me } from './user.model.js';

@Injectable()
export class UsersService {
  constructor(private readonly ctx: DbContext) {}

  /** Profilo con appartenenze in tutte le società (la RLS espone le righe dell'utente corrente). */
  async getMe(userId: string): Promise<Me> {
    return this.ctx.withScope({ userId }, async () => {
      const user = await this.ctx.db
        .selectFrom('users')
        .select(['id', 'email', 'full_name', 'locale', 'totp_enabled_at'])
        .where('id', '=', userId)
        .executeTakeFirst();
      if (!user) throw appError('UNAUTHENTICATED');
      const memberships = await this.ctx.db
        .selectFrom('memberships as m')
        .innerJoin('clubs as c', 'c.id', 'm.tenant_id')
        .select(['m.id', 'm.role', 'm.team_id', 'c.id as club_id', 'c.name as club_name'])
        .where('m.user_id', '=', userId)
        .orderBy('c.name')
        .execute();
      return {
        id: user.id,
        email: user.email,
        fullName: user.full_name,
        locale: user.locale,
        twoFactorEnabled: user.totp_enabled_at !== null,
        memberships: memberships.map((m) => ({
          id: m.id,
          role: m.role as MembershipRoleEnum,
          teamId: m.team_id,
          clubId: m.club_id,
          clubName: m.club_name,
        })),
      };
    });
  }

  async update(userId: string, input: { fullName?: string; locale?: string }): Promise<Me> {
    if (input.fullName !== undefined || input.locale !== undefined) {
      await this.ctx.db
        .updateTable('users')
        .set({ full_name: input.fullName, locale: input.locale })
        .where('id', '=', userId)
        .execute();
    }
    return this.getMe(userId);
  }

  /** Diritto di accesso GDPR (art. 15): dati personali dell'utente in formato strutturato. */
  async exportData(userId: string): Promise<Record<string, unknown>> {
    const me = await this.getMe(userId);
    const consents = await this.ctx.withScope({ userId, tenantId: null }, () =>
      this.ctx.db
        .selectFrom('consents')
        .select(['tenant_id', 'kind', 'version', 'granted', 'created_at'])
        .where('user_id', '=', userId)
        .orderBy('created_at')
        .execute(),
    );
    const devices = await this.ctx.db
      .selectFrom('device_tokens')
      .select(['platform', 'app_version', 'last_seen_at'])
      .where('user_id', '=', userId)
      .execute();
    return { exportedAt: new Date().toISOString(), profile: me, consents, devices };
  }
}
