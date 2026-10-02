import { Module } from '@nestjs/common';
import { SeasonsResolver } from './seasons.resolver.js';
import { SeasonsService } from './seasons.service.js';

@Module({ providers: [SeasonsService, SeasonsResolver] })
export class SeasonsModule {}
