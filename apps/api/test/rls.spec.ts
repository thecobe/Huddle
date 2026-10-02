import { randomUUID } from 'node:crypto';
import pg from 'pg';
import { afterAll, beforeAll, describe, expect, it } from 'vitest';

/**
 * Verifica l'isolamento tra società direttamente sul database, con il ruolo applicativo:
 * anche una query senza filtri non deve mai restituire dati di un'altra società.
 */
describe('Row Level Security', () => {
  const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
  const tenantA = randomUUID();
  const tenantB = randomUUID();
  let userA: string;

  async function asScope<T>(scope: { tenant?: string; user?: string }, fn: (c: pg.PoolClient) => Promise<T>) {
    const c = await pool.connect();
    try {
      await c.query('BEGIN');
      await c.query(`select set_config('app.tenant_id', $1, true), set_config('app.user_id', $2, true)`, [
        scope.tenant ?? '',
        scope.user ?? '',
      ]);
      const result = await fn(c);
      await c.query('COMMIT');
      return result;
    } catch (err) {
      await c.query('ROLLBACK');
      throw err;
    } finally {
      c.release();
    }
  }

  beforeAll(async () => {
    const u = await pool.query(`insert into users (email, full_name) values ($1, 'RLS') returning id`, [
      `rls.${Date.now()}@example.test`,
    ]);
    userA = u.rows[0].id;
    for (const tenant of [tenantA, tenantB]) {
      await asScope({ tenant }, async (c) => {
        await c.query(`insert into clubs (id, name) values ($1, $2)`, [tenant, `Club ${tenant.slice(0, 4)}`]);
        await c.query(`insert into seasons (tenant_id, name, starts_on, ends_on) values ($1, '2026/27', '2026-09-01', '2027-06-30')`, [tenant]);
      });
    }
    await asScope({ tenant: tenantA }, (c) =>
      c.query(`insert into memberships (tenant_id, user_id, role) values ($1, $2, 'COACH')`, [tenantA, userA]),
    );
  });

  afterAll(() => pool.end());

  it('il ruolo applicativo non bypassa la RLS', async () => {
    const r = await pool.query(`select rolbypassrls, rolsuper from pg_roles where rolname = current_user`);
    expect(r.rows[0]).toEqual({ rolbypassrls: false, rolsuper: false });
  });

  it('senza scope non vede alcuna società', async () => {
    const rows = await asScope({}, async (c) => (await c.query('select id from clubs')).rows);
    expect(rows).toEqual([]);
  });

  it('con lo scope di una società vede solo i suoi dati', async () => {
    const seasons = await asScope({ tenant: tenantA }, async (c) => (await c.query('select tenant_id from seasons')).rows);
    expect(seasons.length).toBeGreaterThan(0);
    expect(seasons.every((s) => s.tenant_id === tenantA)).toBe(true);
  });

  it('non può scrivere dati per un’altra società', async () => {
    await expect(
      asScope({ tenant: tenantA }, (c) =>
        c.query(`insert into seasons (tenant_id, name, starts_on, ends_on) values ($1, 'X', '2026-01-01', '2026-12-31')`, [tenantB]),
      ),
    ).rejects.toThrow(/row-level security/);
  });

  it('non può modificare dati di un’altra società', async () => {
    const updated = await asScope({ tenant: tenantA }, async (c) =>
      (await c.query(`update clubs set name = 'hacked' where id = $1`, [tenantB])).rowCount,
    );
    expect(updated).toBe(0);
  });

  it("un utente vede le proprie società anche senza società corrente", async () => {
    const clubs = await asScope({ user: userA }, async (c) => (await c.query('select id from clubs')).rows);
    expect(clubs.map((c) => c.id)).toEqual([tenantA]);
  });

  it('il registro di audit è append-only', async () => {
    await expect(
      asScope({ tenant: tenantA }, (c) => c.query(`delete from audit_events`)),
    ).rejects.toThrow(/permission denied/);
  });
});
