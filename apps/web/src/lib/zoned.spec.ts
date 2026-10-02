import { describe, expect, it } from 'vitest';
import { addDays, utcToZoned, zonedToUtc } from './zoned';

describe('fuso orario della società', () => {
  it('converte ora locale di Roma in UTC, prima e dopo il cambio dell’ora legale', () => {
    expect(zonedToUtc('2027-10-30', '18:00', 'Europe/Rome').toISOString()).toBe('2027-10-30T16:00:00.000Z');
    expect(zonedToUtc('2027-10-31', '18:00', 'Europe/Rome').toISOString()).toBe('2027-10-31T17:00:00.000Z');
    expect(zonedToUtc('2028-03-26', '10:00', 'Europe/Rome').toISOString()).toBe('2028-03-26T08:00:00.000Z');
  });

  it('andata e ritorno', () => {
    expect(utcToZoned('2027-10-31T17:00:00.000Z', 'Europe/Rome')).toEqual({ date: '2027-10-31', time: '18:00' });
    expect(utcToZoned('2027-12-31T23:30:00.000Z', 'Europe/Rome')).toEqual({ date: '2028-01-01', time: '00:30' });
  });

  it('somma giorni tra mesi e anni', () => {
    expect(addDays('2027-12-30', 3)).toBe('2028-01-02');
    expect(addDays('2028-03-01', -1)).toBe('2028-02-29');
  });
});
