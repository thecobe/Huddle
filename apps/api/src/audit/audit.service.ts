import { Injectable } from '@nestjs/common';
import { DbContext } from '../database/db-context.js';

export interface AuditEntry {
  action: string;
  tenantId?: string | null;
  actorUserId?: string | null;
  entityType?: string;
  entityId?: string;
  metadata?: Record<string, unknown>;
  ip?: string | null;
  userAgent?: string | null;
}

/** Registro append-only delle operazioni sensibili (accessi, permessi, dati società). */
@Injectable()
export class AuditService {
  constructor(private readonly ctx: DbContext) {}

  /** Per eventi di errore (es. accesso fallito): la transazione della richiesta verrà annullata. */
  async recordDetached(entry: AuditEntry): Promise<void> {
    const scope = this.ctx.scope;
    await this.ctx.runDetached(scope, () => this.record(entry));
  }

  async record(entry: AuditEntry): Promise<void> {
    const scope = this.ctx.scope;
    await this.ctx.db
      .insertInto('audit_events')
      .values({
        action: entry.action,
        tenant_id: entry.tenantId === undefined ? (scope.tenantId ?? null) : entry.tenantId,
        actor_user_id: entry.actorUserId === undefined ? (scope.userId ?? null) : entry.actorUserId,
        entity_type: entry.entityType ?? null,
        entity_id: entry.entityId ?? null,
        metadata: entry.metadata ?? {},
        ip: entry.ip ?? null,
        user_agent: entry.userAgent ?? null,
      })
      .execute();
  }
}
