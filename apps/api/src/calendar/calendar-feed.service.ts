import { Inject, Injectable } from '@nestjs/common';
import { ENV, type Env } from '../config/env.js';
import { AuditService } from '../audit/audit.service.js';
import { randomToken, sha256 } from '../common/crypto.js';
import { appError } from '../common/errors.js';
import type { TenantAccess } from '../common/request-context.js';
import { DbContext } from '../database/db-context.js';
import { assertInTenant } from '../database/tenant-guard.js';
import { CalendarService } from './calendar.service.js';
import { buildCalendar } from './ics.js';

const EVENT_LABELS: Record<string, string> = { TRAINING: 'Allenamento', MATCH: 'Gara', OTHER: 'Evento' };

@Injectable()
export class CalendarFeedService {
  constructor(
    @Inject(ENV) private readonly env: Env,
    private readonly ctx: DbContext,
    private readonly calendar: CalendarService,
    private readonly audit: AuditService,
  ) {}

  /** Nuovo link iCal; quelli precedenti dello stesso tipo vengono revocati. Il token si vede solo ora. */
  async create(access: TenantAccess, userId: string, teamId: string | null): Promise<string> {
    if (teamId) {
      await assertInTenant(this.ctx, 'teams', [teamId]);
      if (!(await this.calendar.visibleTeamIds(access, userId)).includes(teamId)) throw appError('NOT_FOUND');
    }
    await this.revoke(userId, teamId);
    const token = randomToken();
    await this.ctx.db
      .insertInto('calendar_feeds')
      .values({ tenant_id: access.tenantId, user_id: userId, team_id: teamId, token_hash: sha256(token) })
      .execute();
    await this.audit.record({ action: 'calendar.feed_created', metadata: { teamId } });
    return `${this.env.WEB_URL}/calendar/${token}.ics`;
  }

  async revoke(userId: string, teamId: string | null): Promise<void> {
    let q = this.ctx.db
      .updateTable('calendar_feeds')
      .set({ revoked_at: new Date() })
      .where('user_id', '=', userId)
      .where('revoked_at', 'is', null);
    q = teamId ? q.where('team_id', '=', teamId) : q.where('team_id', 'is', null);
    await q.execute();
  }

  /**
   * Contenuto iCal per un token, o null se il token non è valido o l'utente non appartiene più alla società.
   * Gira con lo scope dell'utente proprietario del link: vede solo ciò che vedrebbe nell'app.
   */
  async render(token: string): Promise<string | null> {
    const feed = await this.ctx.run({}, () =>
      this.ctx.db
        .selectFrom((eb) => eb.fn<FeedRow>('find_calendar_feed', [eb.val(sha256(token))]).as('f'))
        .selectAll()
        .executeTakeFirst(),
    );
    if (!feed) return null;
    return this.ctx.run({ userId: feed.user_id, tenantId: feed.tenant_id }, async () => {
      const rows = await this.ctx.db
        .selectFrom('memberships')
        .select(['role', 'team_id'])
        .where('tenant_id', '=', feed.tenant_id)
        .where('user_id', '=', feed.user_id)
        .execute();
      if (!rows.length) return null;
      const access: TenantAccess = {
        tenantId: feed.tenant_id,
        roles: [...new Set(rows.map((r) => r.role))],
        memberships: rows.map((r) => ({ role: r.role, teamId: r.team_id })),
      };
      const events = await this.calendar.feedEvents(access, feed.user_id, feed.team_id);
      const club = await this.ctx.db.selectFrom('clubs').select('name').where('id', '=', feed.tenant_id).executeTakeFirstOrThrow();
      const team = feed.team_id
        ? await this.ctx.db.selectFrom('teams').select('name').where('id', '=', feed.team_id).executeTakeFirst()
        : null;
      return buildCalendar(
        team ? `${club.name} – ${team.name}` : club.name,
        events.map((e) => ({
          id: e.id,
          title: eventTitle(e),
          startsAt: e.startsAt,
          endsAt: e.endsAt,
          location: e.location,
          description: [e.cancelReason, e.notes].filter(Boolean).join('\n') || null,
          cancelled: e.status === 'CANCELLED',
          updatedAt: e.updatedAt,
        })),
      );
    });
  }
}

interface FeedRow {
  id: string;
  tenant_id: string;
  user_id: string;
  team_id: string | null;
}

function eventTitle(e: { kind: string; title: string | null; teamName: string | null; opponent: string | null }): string {
  const base = e.title ?? (e.kind === 'MATCH' && e.opponent ? `Gara vs ${e.opponent}` : EVENT_LABELS[e.kind] ?? 'Evento');
  return e.teamName ? `${base} · ${e.teamName}` : base;
}
