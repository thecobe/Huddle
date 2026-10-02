import type { Request, Response } from 'express';
import { REFRESH_TOKEN_TTL_DAYS } from './token.service.js';

export const REFRESH_COOKIE = 'huddle_rt';
const WEB_CLIENT_HEADER = 'x-huddle-client';

/** Il client web riceve il refresh token in un cookie httpOnly; le app mobile nel corpo della risposta. */
export function isWebClient(req: Request): boolean {
  return req.header(WEB_CLIENT_HEADER) === 'web';
}

export function setRefreshCookie(res: Response, token: string, secure: boolean): void {
  res.cookie(REFRESH_COOKIE, token, {
    httpOnly: true,
    secure,
    sameSite: 'strict',
    path: '/graphql',
    maxAge: REFRESH_TOKEN_TTL_DAYS * 86_400_000,
  });
}

export function clearRefreshCookie(res: Response, secure: boolean): void {
  res.clearCookie(REFRESH_COOKIE, { httpOnly: true, secure, sameSite: 'strict', path: '/graphql' });
}

export function readRefreshCookie(req: Request): string | undefined {
  const value = (req.cookies as Record<string, string> | undefined)?.[REFRESH_COOKIE];
  return value || undefined;
}
