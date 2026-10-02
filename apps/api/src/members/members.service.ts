import { Inject, Injectable } from '@nestjs/common';
import { ENV, type Env } from '../config/env.js';
import { AuditService } from '../audit/audit.service.js';
import { type AuthResult, AuthService, type ClientInfo } from '../auth/auth.service.js';
import { PasswordService } from '../auth/password.service.js';
import { randomToken, sha256 } from '../common/crypto.js';
import { appError } from '../common/errors.js';
import type { MembershipRoleEnum } from '../common/enums.js';
import type { TenantAccess } from '../common/request-context.js';
import { ConsentsService } from '../consents/consents.service.js';
import { DbContext } from '../database/db-context.js';
import type { InvitationRow } from '../database/types.js';
import { MailService } from '../mail/mail.service.js';
import { roleLabel } from '../mail/templates.js';
import { ADMIN_ASSIGNED_ROLES } from '../permissions/permissions.js';
import type { AcceptInvitationInput, Invitation, InvitationPreview, InviteMemberInput, Member } from './member.model.js';

const INVITATION_TTL_DAYS = 7;

@Injectable()
export class MembersService {
  constructor(
    @Inject(ENV) private readonly env: Env,
    private readonly ctx: DbContext,
    private readonly audit: AuditService,
    private readonly mail: MailService,
    private readonly auth: AuthService,
    private readonly passwords: PasswordService,
    private readonly consents: ConsentsService,
  ) {}

  async list(): Promise<Member[]> {
    const rows = await this.ctx.db
      .selectFrom('memberships as m')
      .innerJoin('users as u', 'u.id', 'm.user_id')
      .select(['m.id', 'm.user_id', 'u.full_name', 'u.email', 'm.role', 'm.team_id', 'm.created_at'])
      .where('m.tenant_id', '=', this.ctx.scope.tenantId!)
      .orderBy('u.full_name')
      .execute();
    return rows.map((r) => ({
      membershipId: r.id,
      userId: r.user_id,
      fullName: r.full_name,
      email: r.email,
      role: r.role as MembershipRoleEnum,
      teamId: r.team_id,
      createdAt: r.created_at,
    }));
  }

  async remove(access: TenantAccess, membershipId: string): Promise<boolean> {
    const target = await this.ctx.db
      .selectFrom('memberships')
      .select(['id', 'role', 'user_id'])
      .where('id', '=', membershipId)
      .executeTakeFirst();
    if (!target) throw appError('NOT_FOUND');
    if (target.role === 'ADMIN') {
      const admins = await this.ctx.db
        .selectFrom('memberships')
        .select((eb) => eb.fn.countAll<string>().as('n'))
        .where('tenant_id', '=', access.tenantId)
        .where('role', '=', 'ADMIN')
        .executeTakeFirstOrThrow();
      if (Number(admins.n) <= 1) throw appError('LAST_ADMIN');
    }
    await this.ctx.db.deleteFrom('memberships').where('id', '=', membershipId).execute();
    await this.audit.record({
      action: 'member.removed',
      entityType: 'membership',
      entityId: membershipId,
      metadata: { userId: target.user_id, role: target.role },
    });
    return true;
  }

  async listInvitations(): Promise<Invitation[]> {
    const rows = await this.ctx.db
      .selectFrom('invitations')
      .selectAll()
      .where('accepted_at', 'is', null)
      .where('revoked_at', 'is', null)
      .orderBy('created_at', 'desc')
      .execute();
    return rows.map(toInvitation);
  }

  async invite(access: TenantAccess, inviterId: string, input: InviteMemberInput): Promise<Invitation> {
    if (ADMIN_ASSIGNED_ROLES.includes(input.role) && !access.roles.includes('ADMIN')) {
      throw appError('FORBIDDEN', 'Solo un amministratore può assegnare questo ruolo');
    }
    const token = randomToken();
    const row = await this.ctx.db
      .insertInto('invitations')
      .values({
        tenant_id: access.tenantId,
        email: input.email.trim(),
        role: input.role,
        team_id: input.teamId ?? null,
        token_hash: sha256(token),
        invited_by: inviterId,
        expires_at: new Date(Date.now() + INVITATION_TTL_DAYS * 86_400_000),
      })
      .returningAll()
      .executeTakeFirstOrThrow();
    const club = await this.ctx.db.selectFrom('clubs').select('name').where('id', '=', access.tenantId).executeTakeFirstOrThrow();
    const invitee = await this.ctx.db.selectFrom('users').select('locale').where('email', '=', row.email).executeTakeFirst();
    const locale = invitee?.locale ?? 'it';
    await this.mail.send(row.email, locale, {
      kind: 'invitation',
      clubName: club.name,
      roleLabel: roleLabel(locale, row.role),
      webUrl: `${this.env.WEB_URL}/invitations/accept?token=${token}`,
      appUrl: `${this.env.MOBILE_DEEP_LINK_SCHEME}://invitations/accept?token=${token}`,
    });
    await this.audit.record({
      action: 'member.invited',
      entityType: 'invitation',
      entityId: row.id,
      metadata: { email: row.email, role: row.role, teamId: row.team_id },
    });
    return toInvitation(row);
  }

  async revokeInvitation(id: string): Promise<boolean> {
    const res = await this.ctx.db
      .updateTable('invitations')
      .set({ revoked_at: new Date() })
      .where('id', '=', id)
      .where('accepted_at', 'is', null)
      .executeTakeFirst();
    if (res.numUpdatedRows === 0n) throw appError('NOT_FOUND');
    await this.audit.record({ action: 'member.invitation_revoked', entityType: 'invitation', entityId: id });
    return true;
  }

  async preview(token: string): Promise<InvitationPreview> {
    const inv = await this.findValidInvitation(token);
    const user = await this.auth.findUserByEmail(inv.email);
    return {
      clubId: inv.tenant_id,
      clubName: inv.club_name,
      email: inv.email,
      role: inv.role as MembershipRoleEnum,
      expiresAt: inv.expires_at,
      accountExists: !!user,
    };
  }

  /**
   * Accetta l'invito. Il token arriva all'indirizzo invitato, quindi ne prova il possesso:
   * crea l'account se manca, aggiunge l'appartenenza e avvia la sessione (o la sfida 2FA).
   */
  async accept(input: AcceptInvitationInput, client: ClientInfo): Promise<AuthResult> {
    const inv = await this.findValidInvitation(input.token);
    const user = await this.auth.findUserByEmail(inv.email);
    let userId: string;
    if (user) {
      userId = user.id;
    } else {
      if (!input.fullName) throw appError('BAD_USER_INPUT', 'Nome obbligatorio per il nuovo account');
      const created = await this.ctx.db
        .insertInto('users')
        .values({
          email: inv.email,
          full_name: input.fullName.trim(),
          password_hash: input.password ? await this.passwords.hash(input.password) : null,
        })
        .returning(['id'])
        .executeTakeFirstOrThrow();
      userId = created.id;
      await this.consents.acceptPlatformTerms(userId, client.ip);
    }
    await this.ctx.withScope({ userId, tenantId: inv.tenant_id }, async () => {
      await this.ctx.db
        .insertInto('memberships')
        .values({ tenant_id: inv.tenant_id, user_id: userId, role: inv.role, team_id: inv.team_id })
        .onConflict((oc) => oc.doNothing())
        .execute();
      await this.ctx.db.updateTable('invitations').set({ accepted_at: new Date() }).where('id', '=', inv.id).execute();
      await this.audit.record({
        action: 'member.invitation_accepted',
        entityType: 'invitation',
        entityId: inv.id,
        actorUserId: userId,
        metadata: { role: inv.role, newAccount: !user },
      });
    });
    return this.auth.completeLogin(userId, client);
  }

  private async findValidInvitation(token: string) {
    const inv = await this.ctx.db
      .selectFrom((eb) => eb.fn<InvitationLookup>('find_invitation_by_token_hash', [eb.val(sha256(token))]).as('i'))
      .selectAll()
      .executeTakeFirst();
    if (!inv || inv.accepted_at || inv.revoked_at || new Date(inv.expires_at) < new Date()) {
      throw appError('INVALID_TOKEN');
    }
    return inv;
  }
}

interface InvitationLookup {
  id: string;
  tenant_id: string;
  club_name: string;
  email: string;
  role: InvitationRow['role'];
  team_id: string | null;
  expires_at: Date;
  accepted_at: Date | null;
  revoked_at: Date | null;
}

function toInvitation(r: InvitationRow): Invitation {
  return {
    id: r.id,
    email: r.email,
    role: r.role as MembershipRoleEnum,
    teamId: r.team_id,
    expiresAt: r.expires_at,
    acceptedAt: r.accepted_at,
    revokedAt: r.revoked_at,
    createdAt: r.created_at,
  };
}
