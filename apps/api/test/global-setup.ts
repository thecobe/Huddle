import './load-env.js';
import pg from 'pg';
import { migrateToLatest } from '../src/database/migrate.js';

/** Ricrea da zero lo schema del database di test ed esegue le migrazioni. */
export default async function setup(): Promise<void> {
  const url = process.env.DATABASE_OWNER_URL!;
  const client = new pg.Client({ connectionString: url });
  await client.connect();
  await client.query(`
    DROP SCHEMA IF EXISTS public CASCADE;
    CREATE SCHEMA public;
    GRANT USAGE ON SCHEMA public TO huddle_app;
    DROP TYPE IF EXISTS kysely_migration CASCADE;
  `);
  await client.end();
  await migrateToLatest(url);
}
