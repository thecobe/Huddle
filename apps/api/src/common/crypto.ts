import { createCipheriv, createDecipheriv, createHash, randomBytes } from 'node:crypto';

/** Token opaco da inviare all'utente (link e-mail, refresh token). In DB si salva solo l'hash. */
export function randomToken(bytes = 32): string {
  return randomBytes(bytes).toString('base64url');
}

export function sha256(value: string): string {
  return createHash('sha256').update(value).digest('hex');
}

/** AES-256-GCM. Formato: iv.tag.ciphertext (base64url). */
export function encrypt(plain: string, keyBase64: string): string {
  const iv = randomBytes(12);
  const cipher = createCipheriv('aes-256-gcm', Buffer.from(keyBase64, 'base64'), iv);
  const data = Buffer.concat([cipher.update(plain, 'utf8'), cipher.final()]);
  return [iv, cipher.getAuthTag(), data].map((b) => b.toString('base64url')).join('.');
}

export function decrypt(payload: string, keyBase64: string): string {
  const [iv, tag, data] = payload.split('.').map((p) => Buffer.from(p, 'base64url'));
  if (!iv || !tag || !data) throw new Error('Payload cifrato non valido');
  const decipher = createDecipheriv('aes-256-gcm', Buffer.from(keyBase64, 'base64'), iv);
  decipher.setAuthTag(tag);
  return Buffer.concat([decipher.update(data), decipher.final()]).toString('utf8');
}
