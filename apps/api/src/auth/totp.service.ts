import { Inject, Injectable } from '@nestjs/common';
import { generateSecret, generateURI, verify } from 'otplib';
import { ENV, type Env } from '../config/env.js';
import { decrypt, encrypt, randomToken, sha256 } from '../common/crypto.js';

const RECOVERY_CODES = 8;

@Injectable()
export class TotpService {
  constructor(@Inject(ENV) private readonly env: Env) {}

  createSecret(email: string): { secret: string; secretEnc: string; otpauthUri: string } {
    const secret = generateSecret();
    return {
      secret,
      secretEnc: encrypt(secret, this.env.ENCRYPTION_KEY),
      otpauthUri: generateURI({ issuer: 'Huddle', label: email, secret }),
    };
  }

  async verifyCode(secretEnc: string, code: string): Promise<boolean> {
    const token = code.replace(/\s/g, '');
    if (!/^\d{6}$/.test(token)) return false;
    const secret = decrypt(secretEnc, this.env.ENCRYPTION_KEY);
    // Tolleranza di un intervallo (30 s) per orologi non sincronizzati.
    const result = await verify({ secret, token, epochTolerance: 30 });
    return result.valid;
  }

  createRecoveryCodes(): { codes: string[]; hashes: string[] } {
    const codes = Array.from({ length: RECOVERY_CODES }, () => randomToken(6).toUpperCase().slice(0, 8));
    return { codes, hashes: codes.map((c) => sha256(normalizeRecovery(c))) };
  }

  /** Restituisce gli hash residui se il codice di recupero è valido, altrimenti null. */
  consumeRecoveryCode(hashes: string[], code: string): string[] | null {
    const h = sha256(normalizeRecovery(code));
    return hashes.includes(h) ? hashes.filter((x) => x !== h) : null;
  }
}

function normalizeRecovery(code: string): string {
  return code.replace(/[\s-]/g, '').toUpperCase();
}
