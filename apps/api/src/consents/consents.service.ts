import { Inject, Injectable } from '@nestjs/common';
import { ENV, type Env } from '../config/env.js';
import { appError } from '../common/errors.js';
import { DbContext } from '../database/db-context.js';
import type { ConsentKind } from '../database/types.js';

/** Consensi validi per tutta la piattaforma; gli altri sono raccolti per singola società. */
const PLATFORM_KINDS: ConsentKind[] = ['PRIVACY_POLICY', 'TERMS_OF_SERVICE'];

export interface ConsentState {
  kind: ConsentKind;
  clubId: string | null;
  version: string;
  granted: boolean;
  recordedAt: Date;
}

@Injectable()
export class ConsentsService {
  constructor(
    @Inject(ENV) private readonly env: Env,
    private readonly ctx: DbContext,
  ) {}

  currentVersion(kind: ConsentKind): string {
    if (kind === 'PRIVACY_POLICY') return this.env.PRIVACY_POLICY_VERSION;
    if (kind === 'TERMS_OF_SERVICE') return this.env.TERMS_VERSION;
    return this.env.PRIVACY_POLICY_VERSION;
  }

  /** Accettazione di informativa privacy e termini al momento della registrazione. */
  async acceptPlatformTerms(userId: string, ip: string | null): Promise<void> {
    await this.ctx.withScope({ userId }, async () => {
      for (const kind of PLATFORM_KINDS) {
        await this.insert(userId, null, kind, true, ip);
      }
    });
  }

  async record(
    userId: string,
    tenantId: string | null,
    kind: ConsentKind,
    granted: boolean,
    ip: string | null,
  ): Promise<ConsentState> {
    const platform = PLATFORM_KINDS.includes(kind);
    if (!platform && !tenantId) throw appError('TENANT_REQUIRED');
    return this.insert(userId, platform ? null : tenantId, kind, granted, ip);
  }

  /** Stato attuale (ultima registrazione) per ciascun consenso dell'utente. */
  async current(userId: string): Promise<ConsentState[]> {
    const rows = await this.ctx.db
      .selectFrom('consents')
      .select(['kind', 'tenant_id', 'version', 'granted', 'created_at'])
      .distinctOn(['kind', 'tenant_id'])
      .where('user_id', '=', userId)
      .orderBy('kind')
      .orderBy('tenant_id')
      .orderBy('created_at', 'desc')
      .execute();
    return rows.map((r) => ({
      kind: r.kind,
      clubId: r.tenant_id,
      version: r.version,
      granted: r.granted,
      recordedAt: r.created_at,
    }));
  }

  private async insert(
    userId: string,
    tenantId: string | null,
    kind: ConsentKind,
    granted: boolean,
    ip: string | null,
  ): Promise<ConsentState> {
    const row = await this.ctx.db
      .insertInto('consents')
      .values({
        user_id: userId,
        tenant_id: tenantId,
        kind,
        version: this.currentVersion(kind),
        granted,
        recorded_by: userId,
        ip,
      })
      .returning(['kind', 'tenant_id', 'version', 'granted', 'created_at'])
      .executeTakeFirstOrThrow();
    return {
      kind: row.kind,
      clubId: row.tenant_id,
      version: row.version,
      granted: row.granted,
      recordedAt: row.created_at,
    };
  }
}
