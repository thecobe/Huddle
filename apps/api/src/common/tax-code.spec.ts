import { describe, expect, it } from 'vitest';
import { isValidTaxCode, normalizeTaxCode } from './tax-code.js';

describe('codice fiscale', () => {
  it('accetta codici validi, anche minuscoli o con spazi', () => {
    expect(isValidTaxCode('RSSMRA85T10A562S')).toBe(true);
    expect(isValidTaxCode('rssmra85t10a562s')).toBe(true);
    expect(isValidTaxCode('RSS MRA 85T10 A562S')).toBe(true);
  });

  it('accetta le varianti per omocodia', () => {
    expect(isValidTaxCode('RSSMRA85T10A56NH')).toBe(true);
  });

  it('rifiuta carattere di controllo errato o formato non valido', () => {
    expect(isValidTaxCode('RSSMRA85T10A562X')).toBe(false);
    expect(isValidTaxCode('RSSMRA85T10A562')).toBe(false);
    expect(isValidTaxCode('12345678901')).toBe(false);
  });

  it('normalizza', () => {
    expect(normalizeTaxCode(' rss mra85t10a562s ')).toBe('RSSMRA85T10A562S');
  });
});
