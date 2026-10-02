import { Global, Module } from '@nestjs/common';
import { AuditResolver } from './audit.resolver.js';
import { AuditService } from './audit.service.js';

@Global()
@Module({ providers: [AuditService, AuditResolver], exports: [AuditService] })
export class AuditModule {}
