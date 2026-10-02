import { Global, Inject, Module, type OnModuleDestroy } from '@nestjs/common';
import { Kysely, PostgresDialect } from 'kysely';
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
export class DatabaseModule implements OnModuleDestroy {
  constructor(@Inject(KYSELY) private readonly kysely: Kysely<Database>) {}

  async onModuleDestroy(): Promise<void> {
    await this.kysely.destroy();
  }
}
