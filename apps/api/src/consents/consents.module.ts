import { Global, Module } from '@nestjs/common';
import { ConsentsResolver } from './consents.resolver.js';
import { ConsentsService } from './consents.service.js';

@Global()
@Module({ providers: [ConsentsService, ConsentsResolver], exports: [ConsentsService] })
export class ConsentsModule {}
