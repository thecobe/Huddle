import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Kysely, PostgresDialect } from 'kysely';
import { FileMigrationProvider, Migrator } from 'kysely/migration';
import pg from 'pg';

const migrationFolder = path.join(path.dirname(fileURLToPath(import.meta.url)), 'migrations');

/** Esegue le migrazioni con il ruolo proprietario dello schema (non soggetto a RLS). */
export async function migrateToLatest(connectionString: string): Promise<void> {
  const db = new Kysely<unknown>({
    dialect: new PostgresDialect({ pool: new pg.Pool({ connectionString, max: 1 }) }),
  });
  const migrator = new Migrator({
    db,
    provider: new FileMigrationProvider({ fs, path, migrationFolder }),
  });
  const { error, results } = await migrator.migrateToLatest();
  for (const r of results ?? []) {
    console.log(`[migrate] ${r.status === 'Success' ? 'ok' : r.status} ${r.migrationName}`);
  }
  await db.destroy();
  if (error) throw error;
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const { loadEnv } = await import('../config/env.js');
  await migrateToLatest(loadEnv().DATABASE_OWNER_URL);
}
