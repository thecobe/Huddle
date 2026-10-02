import { Module } from '@nestjs/common';
import { MembersResolver } from './members.resolver.js';
import { MembersService } from './members.service.js';

@Module({ providers: [MembersService, MembersResolver] })
export class MembersModule {}
