import { type CallHandler, type ExecutionContext, Injectable, type NestInterceptor } from '@nestjs/common';
import type { GqlContextType } from '@nestjs/graphql';
import { from, lastValueFrom, type Observable } from 'rxjs';
import { gqlContext } from '../common/decorators.js';
import { DbContext } from './db-context.js';

/** Esegue ogni resolver GraphQL in una transazione con lo scope (utente, società) validato da AccessGuard. */
@Injectable()
export class DbScopeInterceptor implements NestInterceptor {
  constructor(private readonly db: DbContext) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    if (context.getType<GqlContextType>() !== 'graphql') return next.handle();
    const gql = gqlContext(context);
    return from(
      this.db.run({ userId: gql.userId ?? null, tenantId: gql.tenant?.tenantId ?? null }, () =>
        lastValueFrom(next.handle(), { defaultValue: null }),
      ),
    );
  }
}
