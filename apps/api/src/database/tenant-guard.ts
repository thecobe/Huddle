import { appError } from '../common/errors.js';
import type { DbContext } from './db-context.js';

type TenantTable = 'people' | 'teams' | 'seasons';

/**
 * Le chiavi esterne di PostgreSQL non applicano la RLS: un id di un'altra società passerebbe il vincolo.
 * Prima di collegare righe, verifica che ogni id sia visibile (quindi della società corrente).
 */
export async function assertInTenant(ctx: DbContext, table: TenantTable, ids: string[]): Promise<void> {
  const unique = [...new Set(ids)];
  if (!unique.length) return;
  const rows = await ctx.db.selectFrom(table).select('id').where('id', 'in', unique).execute();
  if (rows.length !== unique.length) throw appError('NOT_FOUND');
}
