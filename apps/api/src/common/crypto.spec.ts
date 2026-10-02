import { describe, expect, it } from 'vitest';
import { decrypt, encrypt, sha256 } from './crypto.js';

const key = Buffer.alloc(32, 7).toString('base64');

describe('crypto', () => {
  it('cifra e decifra', () => {
    const payload = encrypt('JBSWY3DPEHPK3PXP', key);
    expect(payload).not.toContain('JBSWY3DPEHPK3PXP');
    expect(decrypt(payload, key)).toBe('JBSWY3DPEHPK3PXP');
  });

  it('rifiuta payload manomessi', () => {
    const [iv, tag, data] = encrypt('segreto', key).split('.');
    const tampered = [iv, tag, Buffer.from('altro').toString('base64url')].join('.');
    expect(() => decrypt(tampered, key)).toThrow();
    expect(data).toBeDefined();
  });

  it('hash deterministico', () => {
    expect(sha256('a')).toBe(sha256('a'));
    expect(sha256('a')).not.toBe(sha256('b'));
  });
});
