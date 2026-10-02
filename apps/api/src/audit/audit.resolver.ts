import { Args, Int, Query, Resolver } from '@nestjs/graphql';
import { RequirePermission } from '../common/decorators.js';
import { DbContext } from '../database/db-context.js';
import { Permission } from '../permissions/permissions.js';
import { AuditEvent } from './audit.model.js';

@Resolver(() => AuditEvent)
export class AuditResolver {
  constructor(private readonly ctx: DbContext) {}

  @Query(() => [AuditEvent])
  @RequirePermission(Permission.AuditView)
  async auditEvents(
    @Args('limit', { type: () => Int, defaultValue: 50 }) limit: number,
    @Args('beforeId', { type: () => String, nullable: true }) beforeId: string | null,
  ): Promise<AuditEvent[]> {
    let q = this.ctx.db
      .selectFrom('audit_events as a')
      .leftJoin('users as u', 'u.id', 'a.actor_user_id')
      .select([
        'a.id',
        'a.action',
        'a.actor_user_id',
        'u.full_name',
        'a.entity_type',
        'a.entity_id',
        'a.metadata',
        'a.created_at',
      ])
      .orderBy('a.id', 'desc')
      .limit(Math.min(Math.max(limit, 1), 200));
    if (beforeId) q = q.where('a.id', '<', beforeId);
    const rows = await q.execute();
    return rows.map((r) => ({
      id: String(r.id),
      action: r.action,
      actorUserId: r.actor_user_id,
      actorName: r.full_name,
      entityType: r.entity_type,
      entityId: r.entity_id,
      metadata: r.metadata,
      createdAt: r.created_at,
    }));
  }
}
