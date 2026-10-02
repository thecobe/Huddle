import { type ArgumentsHost, Catch, HttpException, Logger } from '@nestjs/common';
import type { GqlContextType, GqlExceptionFilter } from '@nestjs/graphql';
import { GraphQLError } from 'graphql';
import { appError } from './errors.js';

/**
 * Errori di dominio (GraphQLError con codice) passano invariati senza log di errore.
 * Eccezioni HTTP di Nest vengono tradotte; quelle impreviste loggate e restituite senza dettagli interni.
 */
@Catch()
export class GqlErrorFilter implements GqlExceptionFilter {
  private readonly logger = new Logger('GraphQL');

  catch(exception: unknown, host: ArgumentsHost) {
    if (host.getType<GqlContextType>() !== 'graphql') throw exception;
    if (exception instanceof GraphQLError) return exception;
    if (exception instanceof HttpException) {
      const status = exception.getStatus();
      if (status === 401) return appError('UNAUTHENTICATED');
      if (status === 403) return appError('FORBIDDEN');
      if (status === 404) return appError('NOT_FOUND');
      if (status === 429) return new GraphQLError('Troppe richieste', { extensions: { code: 'TOO_MANY_REQUESTS' } });
      if (status < 500) return appError('BAD_USER_INPUT', exception.message);
    }
    this.logger.error(exception instanceof Error ? exception.stack : String(exception));
    return new GraphQLError('Errore interno', { extensions: { code: 'INTERNAL_SERVER_ERROR' } });
  }
}
