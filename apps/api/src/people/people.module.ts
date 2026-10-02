import { Module } from '@nestjs/common';
import { MembersModule } from '../members/members.module.js';
import { PeopleImportResolver } from './import/import.resolver.js';
import { PeopleImportService } from './import/import.service.js';
import { PeopleResolver } from './people.resolver.js';
import { PeopleService } from './people.service.js';
import { VisibilityService } from './visibility.service.js';

@Module({
  imports: [MembersModule],
  providers: [PeopleService, PeopleResolver, VisibilityService, PeopleImportService, PeopleImportResolver],
  exports: [PeopleService, VisibilityService],
})
export class PeopleModule {}
