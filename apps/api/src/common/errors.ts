import { GraphQLError } from 'graphql';

/** Codici errore stabili, usati dai client web e mobile per i messaggi tradotti. */
export type ErrorCode =
  | 'UNAUTHENTICATED'
  | 'FORBIDDEN'
  | 'TENANT_REQUIRED'
  | 'TWO_FACTOR_SETUP_REQUIRED'
  | 'INVALID_CREDENTIALS'
  | 'INVALID_TOKEN'
  | 'INVALID_TWO_FACTOR_CODE'
  | 'EMAIL_TAKEN'
  | 'NOT_FOUND'
  | 'BAD_USER_INPUT'
  | 'SEASON_ALREADY_OPEN'
  | 'LAST_ADMIN'
  | 'TAX_CODE_TAKEN'
  | 'JERSEY_TAKEN'
  | 'ALREADY_EXISTS'
  | 'ATHLETE_TOO_YOUNG'
  | 'PERSON_ALREADY_LINKED';

export function appError(code: ErrorCode, message?: string): GraphQLError {
  return new GraphQLError(message ?? code, { extensions: { code } });
}
