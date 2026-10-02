import { cacheExchange, Client, type CombinedError, fetchExchange } from '@urql/vue';
import type { TypedDocumentNode } from '@graphql-typed-document-node/core';
import { print } from 'graphql';

export const GRAPHQL_URL = '/graphql';

export interface AuthHeaders {
  accessToken: string | null;
  clubId: string | null;
}

export function buildHeaders({ accessToken, clubId }: AuthHeaders): Record<string, string> {
  const headers: Record<string, string> = { 'x-huddle-client': 'web' };
  if (accessToken) headers.authorization = `Bearer ${accessToken}`;
  if (clubId) headers['x-tenant-id'] = clubId;
  return headers;
}

interface GraphqlResponse<T> {
  data?: T;
  errors?: { message: string; extensions?: { code?: string } }[];
}

/** Richiesta GraphQL senza cache, per operazioni di sessione fuori dai componenti. */
export async function request<TData, TVars extends Record<string, unknown>>(
  doc: TypedDocumentNode<TData, TVars>,
  variables: TVars,
  auth: AuthHeaders,
): Promise<GraphqlResponse<TData>> {
  const res = await fetch(GRAPHQL_URL, {
    method: 'POST',
    credentials: 'include',
    headers: { 'content-type': 'application/json', ...buildHeaders(auth) },
    body: JSON.stringify({ query: print(doc), variables }),
  });
  return (await res.json()) as GraphqlResponse<TData>;
}

/**
 * Client urql legato a una società: la cache non deve mai mescolare dati di società diverse,
 * quindi al cambio di società si crea un nuovo client.
 * In caso di token scaduto rinnova la sessione una volta e ripete la richiesta.
 */
export function createClient(getAuth: () => AuthHeaders, refresh: () => Promise<boolean>): Client {
  const authedFetch: typeof fetch = async (input, init) => {
    const send = () => {
      const headers = new Headers(init?.headers);
      for (const [k, v] of Object.entries(buildHeaders(getAuth()))) headers.set(k, v);
      return fetch(input, { ...init, credentials: 'include', headers });
    };
    const res = await send();
    if (res.ok && (await isUnauthenticated(res.clone())) && (await refresh())) return send();
    return res;
  };
  return new Client({
    url: GRAPHQL_URL,
    exchanges: [cacheExchange, fetchExchange],
    fetch: authedFetch,
    // Sempre POST con JSON: le GET verrebbero bloccate dalla protezione CSRF di Apollo.
    preferGetMethod: false,
    requestPolicy: 'cache-and-network',
  });
}

async function isUnauthenticated(res: Response): Promise<boolean> {
  try {
    const body = (await res.json()) as GraphqlResponse<unknown>;
    return body.errors?.some((e) => e.extensions?.code === 'UNAUTHENTICATED') ?? false;
  } catch {
    return false;
  }
}

/** Codice errore stabile restituito dall'API (vedi apps/api/src/common/errors.ts). */
export function errorCode(error: CombinedError | GraphqlResponse<unknown>['errors'] | undefined | null): string | null {
  if (!error) return null;
  if (Array.isArray(error)) return error[0]?.extensions?.code ?? 'UNKNOWN';
  if (error.networkError) return 'NETWORK';
  return (error.graphQLErrors[0]?.extensions?.code as string | undefined) ?? 'UNKNOWN';
}
