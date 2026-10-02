import { describe, expect, it } from 'vitest';
import { parseDate } from './import.service.js';

describe('date nei file di import', () => {
  it('accetta formato ISO e italiano', () => {
    expect(parseDate('2012-03-05')).toBe('2012-03-05');
    expect(parseDate('5/3/2012')).toBe('2012-03-05');
    expect(parseDate('05.03.2012')).toBe('2012-03-05');
  });

  it('rifiuta date inesistenti o formati ambigui', () => {
    expect(parseDate('31/02/2012')).toBeNull();
    expect(parseDate('2012/03/05')).toBeNull();
    expect(parseDate('marzo 2012')).toBeNull();
  });
});
