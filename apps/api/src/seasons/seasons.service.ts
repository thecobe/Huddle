import { Injectable } from '@nestjs/common';
import { AuditService } from '../audit/audit.service.js';
import { appError } from '../common/errors.js';
import type { SeasonStatusEnum } from '../common/enums.js';
import { DbContext } from '../database/db-context.js';
import type { SeasonRow, SeasonStatus } from '../database/types.js';
import type { Season, SeasonInput } from './season.model.js';

@Injectable()
export class SeasonsService {
  constructor(
    private readonly ctx: DbContext,
    private readonly audit: AuditService,
  ) {}

  async list(): Promise<Season[]> {
    const rows = await this.ctx.db.selectFrom('seasons').selectAll().orderBy('starts_on', 'desc').execute();
    return rows.map(toModel);
  }

  async create(input: SeasonInput): Promise<Season> {
    if (input.endsOn <= input.startsOn) throw appError('BAD_USER_INPUT', 'La fine deve seguire l’inizio');
    const row = await this.ctx.db
      .insertInto('seasons')
      .values({
        tenant_id: this.ctx.scope.tenantId!,
        name: input.name.trim(),
        starts_on: input.startsOn,
        ends_on: input.endsOn,
      })
      .returningAll()
      .executeTakeFirstOrThrow()
      .catch(rethrowUnique('BAD_USER_INPUT', 'Esiste già una stagione con questo nome'));
    await this.audit.record({ action: 'season.created', entityType: 'season', entityId: row.id });
    return toModel(row);
  }

  /** Apertura e chiusura. Una sola stagione aperta per società (indice univoco parziale). */
  async setStatus(id: string, status: SeasonStatus): Promise<Season> {
    const row = await this.ctx.db
      .updateTable('seasons')
      .set({ status })
      .where('id', '=', id)
      .returningAll()
      .executeTakeFirst()
      .catch(rethrowUnique('SEASON_ALREADY_OPEN'));
    if (!row) throw appError('NOT_FOUND');
    await this.audit.record({ action: 'season.status_changed', entityType: 'season', entityId: id, metadata: { status } });
    return toModel(row);
  }
}

function rethrowUnique(code: 'BAD_USER_INPUT' | 'SEASON_ALREADY_OPEN', message?: string) {
  return (err: unknown): never => {
    if ((err as { code?: string }).code === '23505') throw appError(code, message);
    throw err;
  };
}

function toModel(r: SeasonRow): Season {
  return {
    id: r.id,
    name: r.name,
    startsOn: r.starts_on,
    endsOn: r.ends_on,
    status: r.status as SeasonStatusEnum,
    createdAt: r.created_at,
  };
}
