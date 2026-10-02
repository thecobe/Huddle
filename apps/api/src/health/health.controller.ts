import { Controller, Get, Inject } from '@nestjs/common';
import { type Kysely, sql } from 'kysely';
import { KYSELY } from '../database/db-context.js';
import type { Database } from '../database/types.js';

@Controller('health')
export class HealthController {
  constructor(@Inject(KYSELY) private readonly db: Kysely<Database>) {}

  @Get()
  async check(): Promise<{ status: 'ok'; db: 'ok' }> {
    await sql`select 1`.execute(this.db);
    return { status: 'ok', db: 'ok' };
  }
}
