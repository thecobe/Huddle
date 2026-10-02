import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { CurrentTenant, RequirePermission } from '../../common/decorators.js';
import type { TenantAccess } from '../../common/request-context.js';
import { Permission } from '../../permissions/permissions.js';
import { PeopleImportSummary, PersonImportResult, PersonImportRow } from './import.model.js';
import { PeopleImportService } from './import.service.js';

@Resolver()
export class PeopleImportResolver {
  constructor(private readonly service: PeopleImportService) {}

  @Mutation(() => [PersonImportResult], { description: 'Valida le righe senza scrivere nulla.' })
  @RequirePermission(Permission.PeopleManage)
  previewPeopleImport(@Args('rows', { type: () => [PersonImportRow] }) rows: PersonImportRow[]): Promise<PersonImportResult[]> {
    return this.service.preview(rows);
  }

  @Mutation(() => PeopleImportSummary, { description: 'Importa tutte le righe; rifiuta il file se una riga ha errori.' })
  @RequirePermission(Permission.PeopleManage)
  commitPeopleImport(
    @CurrentTenant() access: TenantAccess,
    @Args('rows', { type: () => [PersonImportRow] }) rows: PersonImportRow[],
  ): Promise<PeopleImportSummary> {
    return this.service.commit(access, rows);
  }
}
