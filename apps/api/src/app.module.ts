import { ApolloDriver, type ApolloDriverConfig } from '@nestjs/apollo';
import { Module, ValidationPipe } from '@nestjs/common';
import { APP_FILTER, APP_GUARD, APP_INTERCEPTOR, APP_PIPE } from '@nestjs/core';
import { GraphQLModule } from '@nestjs/graphql';
import { ThrottlerModule } from '@nestjs/throttler';
import { SentryModule } from '@sentry/nestjs/setup';
import type { Request, Response } from 'express';
import { AuditModule } from './audit/audit.module.js';
import { AccessGuard } from './auth/access.guard.js';
import { AuthModule } from './auth/auth.module.js';
import { ClubsModule } from './clubs/clubs.module.js';
import { appError } from './common/errors.js';
import { GqlErrorFilter } from './common/gql-exception.filter.js';
import { ConfigModule } from './config/config.module.js';
import { loadEnv } from './config/env.js';
import { ConsentsModule } from './consents/consents.module.js';
import { DatabaseModule } from './database/database.module.js';
import { DbScopeInterceptor } from './database/db-scope.interceptor.js';
import { DevicesModule } from './devices/devices.module.js';
import { HealthController } from './health/health.controller.js';
import { MailModule } from './mail/mail.module.js';
import { MembersModule } from './members/members.module.js';
import { SeasonsModule } from './seasons/seasons.module.js';
import { UsersModule } from './users/users.module.js';

const env = loadEnv();

@Module({
  imports: [
    SentryModule.forRoot(),
    ConfigModule,
    DatabaseModule,
    ThrottlerModule.forRoot({
      throttlers: [{ name: 'default', ttl: 60_000, limit: env.NODE_ENV === 'test' ? 10_000 : 100 }],
      skipIf: () => env.NODE_ENV === 'test',
    }),
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      // Schema in memoria: il file per i client lo scrive solo `pnpm codegen` (src/emit-schema.ts).
      autoSchemaFile: true,
      sortSchema: true,
      introspection: env.NODE_ENV !== 'production',
      graphiql: env.NODE_ENV === 'development',
      context: ({ req, res }: { req: Request; res: Response }) => ({ req, res }),
    }),
    MailModule,
    AuditModule,
    UsersModule,
    ConsentsModule,
    AuthModule,
    ClubsModule,
    SeasonsModule,
    MembersModule,
    DevicesModule,
  ],
  controllers: [HealthController],
  providers: [
    { provide: APP_GUARD, useClass: AccessGuard },
    { provide: APP_INTERCEPTOR, useClass: DbScopeInterceptor },
    { provide: APP_FILTER, useClass: GqlErrorFilter },
    {
      provide: APP_PIPE,
      useValue: new ValidationPipe({
        whitelist: true,
        transform: true,
        exceptionFactory: (errors) =>
          appError(
            'BAD_USER_INPUT',
            errors.flatMap((e) => Object.values(e.constraints ?? {})).join('; ') || 'Dati non validi',
          ),
      }),
    },
  ],
})
export class AppModule {}
