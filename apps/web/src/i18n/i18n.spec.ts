import { describe, expect, it } from 'vitest';
import en from './locales/en.json';
import itMessages from './locales/it.json';

function keys(obj: object, prefix = ''): string[] {
  return Object.entries(obj).flatMap(([k, v]) =>
    v && typeof v === 'object' ? keys(v, `${prefix}${k}.`) : [`${prefix}${k}`],
  );
}

describe('traduzioni', () => {
  it('italiano e inglese hanno le stesse chiavi', () => {
    expect(keys(en).sort()).toEqual(keys(itMessages).sort());
  });
});
