import { describe, expect, it } from 'vitest';
import { ageOn, todayInZone } from './dates.js';

describe('date', () => {
  it('età compiuta solo dal giorno del compleanno', () => {
    expect(ageOn('2012-10-02', '2026-10-01')).toBe(13);
    expect(ageOn('2012-10-02', '2026-10-02')).toBe(14);
    expect(ageOn('2012-02-29', '2026-02-28')).toBe(13);
    expect(ageOn('2012-02-29', '2026-03-01')).toBe(14);
  });

  it('data odierna nel fuso della società', () => {
    // 23:30 UTC del 1° ottobre è già il 2 ottobre a Roma.
    expect(todayInZone('Europe/Rome', new Date('2026-10-01T23:30:00Z'))).toBe('2026-10-02');
    expect(todayInZone('UTC', new Date('2026-10-01T23:30:00Z'))).toBe('2026-10-01');
  });
});
