import { randomUUID } from 'node:crypto';
import { Injectable } from '@nestjs/common';
import { AuditService } from '../audit/audit.service.js';
import { appError } from '../common/errors.js';
import { DbContext } from '../database/db-context.js';
import type { ClubRow } from '../database/types.js';
import type { Club, ClubInput } from './club.model.js';

@Injectable()
export class ClubsService {
  constructor(
    private readonly ctx: DbContext,
    private readonly audit: AuditService,
  ) {}

  /** Crea la società e rende amministratore chi la crea. */
  async create(userId: string, input: ClubInput): Promise<Club> {
    const tenantId = randomUUID();
    return this.ctx.withScope({ userId, tenantId }, async () => {
      const club = await this.ctx.db
        .insertInto('clubs')
        .values({ id: tenantId, ...toColumns(input), name: input.name.trim() })
        .returningAll()
        .executeTakeFirstOrThrow();
      await this.ctx.db.insertInto('memberships').values({ tenant_id: tenantId, user_id: userId, role: 'ADMIN' }).execute();
      await this.audit.record({ action: 'club.created', entityType: 'club', entityId: tenantId });
      return toModel(club);
    });
  }

  async get(): Promise<Club> {
    const club = await this.ctx.db
      .selectFrom('clubs')
      .selectAll()
      .where('id', '=', this.tenantId())
      .executeTakeFirst();
    if (!club) throw appError('NOT_FOUND');
    return toModel(club);
  }

  async update(input: ClubInput): Promise<Club> {
    const club = await this.ctx.db
      .updateTable('clubs')
      .set({ ...toColumns(input), name: input.name.trim() })
      .where('id', '=', this.tenantId())
      .returningAll()
      .executeTakeFirstOrThrow();
    await this.audit.record({ action: 'club.updated', entityType: 'club', entityId: club.id });
    return toModel(club);
  }

  private tenantId(): string {
    const id = this.ctx.scope.tenantId;
    if (!id) throw appError('TENANT_REQUIRED');
    return id;
  }
}

function toColumns(input: ClubInput) {
  return {
    legal_name: input.legalName ?? null,
    tax_code: input.taxCode?.toUpperCase() ?? null,
    vat_number: input.vatNumber ?? null,
    sport: input.sport ?? 'FOOTBALL',
    email: input.email ?? null,
    phone: input.phone ?? null,
    address_line: input.addressLine ?? null,
    city: input.city ?? null,
    province: input.province?.toUpperCase() ?? null,
    postal_code: input.postalCode ?? null,
    federations: input.federations ?? [],
  };
}

function toModel(r: ClubRow): Club {
  return {
    id: r.id,
    name: r.name,
    legalName: r.legal_name,
    taxCode: r.tax_code,
    vatNumber: r.vat_number,
    sport: r.sport,
    email: r.email,
    phone: r.phone,
    addressLine: r.address_line,
    city: r.city,
    province: r.province,
    postalCode: r.postal_code,
    country: r.country,
    federations: r.federations,
    timezone: r.timezone,
    createdAt: r.created_at,
  };
}
