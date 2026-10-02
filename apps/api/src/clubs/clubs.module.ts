import { Module } from '@nestjs/common';
import { ClubsResolver } from './clubs.resolver.js';
import { ClubsService } from './clubs.service.js';

@Module({ providers: [ClubsService, ClubsResolver] })
export class ClubsModule {}
