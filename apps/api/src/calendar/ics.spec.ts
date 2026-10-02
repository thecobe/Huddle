import { describe, expect, it } from 'vitest';
import { buildCalendar, escapeText, foldLine } from './ics.js';

describe('iCalendar', () => {
  it('escape dei caratteri speciali', () => {
    expect(escapeText('Campo 2, via Roma; ingresso\nlato nord')).toBe('Campo 2\\, via Roma\\; ingresso\\nlato nord');
  });

  it('spezza le righe lunghe a 75 byte senza tagliare caratteri multibyte', () => {
    const line = `SUMMARY:${'è'.repeat(60)}`;
    const folded = foldLine(line).split('\r\n');
    expect(folded.length).toBeGreaterThan(1);
    for (const part of folded) expect(new TextEncoder().encode(part).length).toBeLessThanOrEqual(75);
    expect(folded.map((p, i) => (i ? p.slice(1) : p)).join('')).toBe(line);
  });

  it('eventi annullati e orari in UTC', () => {
    const ics = buildCalendar(
      'Under 15',
      [
        {
          id: 'e1',
          title: 'Allenamento',
          startsAt: new Date('2026-10-05T16:30:00Z'),
          endsAt: new Date('2026-10-05T18:00:00Z'),
          location: 'Campo comunale',
          description: null,
          cancelled: true,
          updatedAt: new Date('2026-10-01T10:00:00Z'),
        },
      ],
      new Date('2026-10-02T08:00:00Z'),
    );
    expect(ics).toContain('DTSTART:20261005T163000Z');
    expect(ics).toContain('STATUS:CANCELLED');
    expect(ics).toContain('SUMMARY:ANNULLATO – Allenamento');
    expect(ics.endsWith('END:VCALENDAR\r\n')).toBe(true);
  });
});
