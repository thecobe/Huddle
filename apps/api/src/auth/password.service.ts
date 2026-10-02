import { Injectable } from '@nestjs/common';
import { hash, verify } from '@node-rs/argon2';
import { appError } from '../common/errors.js';

export const MIN_PASSWORD_LENGTH = 10;

@Injectable()
export class PasswordService {
  // Hash di riferimento per mantenere tempi di risposta simili quando l'utente non esiste.
  private dummyHash: Promise<string> | undefined;

  hash(password: string): Promise<string> {
    if (password.length < MIN_PASSWORD_LENGTH) {
      throw appError('BAD_USER_INPUT', `La password deve avere almeno ${MIN_PASSWORD_LENGTH} caratteri`);
    }
    return hash(password);
  }

  async verify(passwordHash: string | null, password: string): Promise<boolean> {
    if (!passwordHash) {
      this.dummyHash ??= hash('huddle-dummy-password');
      await verify(await this.dummyHash, password);
      return false;
    }
    return verify(passwordHash, password);
  }
}
