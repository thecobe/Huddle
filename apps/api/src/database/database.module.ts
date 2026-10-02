import { Global, Inject, Module, type OnModuleDestroy, type OnModuleInit } from '@nestjs/common';
import { Kysely, PostgresDialect, sql } from 'kysely';
import pg from 'pg';
import { ENV, type Env } from '../config/env.js';
import { DbContext, KYSELY } from './db-context.js';
import type { Database } from './types.js';

// `date` come stringa YYYY-MM-DD: evita slittamenti di fuso orario.
pg.types.setTypeParser(pg.types.builtins.DATE, (v) => v);

@Global()
@Module({
  providers: [
    {
      provide: KYSELY,
      inject: [ENV],
      useFactory: (env: Env) =>
        new Kysely<Database>({
          dialect: new PostgresDialect({
            pool: new pg.Pool({ connectionString: env.DATABASE_URL, max: 10 }),
          }),
        }),
    },
    DbContext,
  ],
  exports: [DbContext, KYSELY],
})
export class DatabaseModule implements OnModuleInit, OnModuleDestroy {
  constructor(@Inject(KYSELY) private readonly kysely: Kysely<Database>) {}

  /**
   * `pg` non converte gli array di enum personalizzati (es. person_category[]) e li restituisce come
   * stringa '{A,B}'. Registra un parser per tutti gli array di enum: le etichette non contengono
   * virgole né virgolette, quindi basta dividere sulla virgola.
   */
  async onModuleInit(): Promise<void> {
    const { rows } = await sql<{ typarray: number }>`select typarray from pg_type where typtype = 'e'`.execute(this.kysely);
    for (const { typarray } of rows) {
      pg.types.setTypeParser(typarray, (value: string) => (value === '{}' ? [] : value.slice(1, -1).split(',')));
    }
  }

  async onModuleDestroy(): Promise<void> {
    await this.kysely.destroy();
  }
}
