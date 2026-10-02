import { AsyncLocalStorage } from 'node:async_hooks';
import { Inject, Injectable } from '@nestjs/common';
import { type Kysely, sql, type Transaction } from 'kysely';
import type { Database } from './types.js';

export const KYSELY = Symbol('KYSELY');

export interface DbScope {
  userId?: string | null;
  tenantId?: string | null;
}

interface Store {
  trx: Transaction<Database>;
  scope: DbScope;
}

/**
 * Ogni accesso ai dati avviene in una transazione che imposta `app.user_id` e `app.tenant_id`
 * (valori locali alla transazione). Le policy RLS di PostgreSQL li usano per isolare le società.
 */
@Injectable()
export class DbContext {
  private readonly als = new AsyncLocalStorage<Store>();

  constructor(@Inject(KYSELY) private readonly kysely: Kysely<Database>) {}

  /** Transazione corrente. Fallisce se chiamato fuori da `run`. */
  get db(): Transaction<Database> {
    const store = this.als.getStore();
    if (!store) throw new Error('DbContext.db usato fuori da una transazione con scope');
    return store.trx;
  }

  get scope(): DbScope {
    return this.als.getStore()?.scope ?? {};
  }

  /** Apre una transazione con lo scope indicato. Se già dentro una transazione, la riusa. */
  async run<T>(scope: DbScope, fn: () => Promise<T>): Promise<T> {
    const current = this.als.getStore();
    if (current) return this.withScope(scope, fn);
    return this.kysely.transaction().execute(async (trx) => {
      await applyScope(trx, scope);
      return this.als.run({ trx, scope }, fn);
    });
  }

  /** Transazione indipendente da quella corrente: il suo commit sopravvive a un rollback esterno. */
  runDetached<T>(scope: DbScope, fn: () => Promise<T>): Promise<T> {
    return this.als.exit(() => this.run(scope, fn));
  }

  /** Cambia lo scope dentro la transazione corrente (es. dopo aver creato una nuova società). */
  async withScope<T>(scope: DbScope, fn: () => Promise<T>): Promise<T> {
    const current = this.als.getStore();
    if (!current) return this.run(scope, fn);
    const merged = { ...current.scope, ...scope };
    await applyScope(current.trx, merged);
    // In caso di errore la transazione verrà annullata: non serve ripristinare lo scope.
    const result = await this.als.run({ trx: current.trx, scope: merged }, fn);
    await applyScope(current.trx, current.scope);
    return result;
  }
}

async function applyScope(trx: Transaction<Database>, scope: DbScope): Promise<void> {
  await sql`select set_config('app.user_id', ${scope.userId ?? ''}, true),
                   set_config('app.tenant_id', ${scope.tenantId ?? ''}, true)`.execute(trx);
}
