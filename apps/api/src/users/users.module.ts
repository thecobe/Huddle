import { Global, Module } from '@nestjs/common';
import { UsersResolver } from './users.resolver.js';
import { UsersService } from './users.service.js';

@Global()
@Module({ providers: [UsersService, UsersResolver], exports: [UsersService] })
export class UsersModule {}
