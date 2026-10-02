import { Module } from '@nestjs/common';
import { MembersModule } from '../members/members.module.js';
import { PeopleModule } from '../people/people.module.js';
import { TeamsResolver } from './teams.resolver.js';
import { TeamsService } from './teams.service.js';

@Module({
  imports: [MembersModule, PeopleModule],
  providers: [TeamsService, TeamsResolver],
})
export class TeamsModule {}
