// Generazione iCalendar (RFC 5545) per l'abbonamento al calendario da Google, Apple e Outlook.

export interface IcsEvent {
  id: string;
  title: string;
  startsAt: Date;
  endsAt: Date;
  location: string | null;
  description: string | null;
  cancelled: boolean;
  updatedAt: Date;
}

/** Testo: escape di backslash, punto e virgola, virgola e a capo. */
export function escapeText(value: string): string {
  return value.replace(/\\/g, '\\\\').replace(/;/g, '\\;').replace(/,/g, '\\,').replace(/\r?\n/g, '\\n');
}

/** Righe al massimo di 75 byte UTF-8; le continuazioni iniziano con uno spazio. */
export function foldLine(line: string): string {
  const encoder = new TextEncoder();
  const parts: string[] = [];
  let current = '';
  let bytes = 0;
  for (const char of line) {
    const size = encoder.encode(char).length;
    const limit = parts.length === 0 ? 75 : 74;
    if (bytes + size > limit) {
      parts.push(current);
      current = '';
      bytes = 0;
    }
    current += char;
    bytes += size;
  }
  parts.push(current);
  return parts.join('\r\n ');
}

function utc(date: Date): string {
  return date.toISOString().replace(/[-:]/g, '').replace(/\.\d{3}/, '');
}

export function buildCalendar(name: string, events: IcsEvent[], now = new Date()): string {
  const lines = [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Huddle//Calendario//IT',
    'CALSCALE:GREGORIAN',
    'METHOD:PUBLISH',
    `X-WR-CALNAME:${escapeText(name)}`,
    // Suggerisce ai client di aggiornare ogni ora.
    'REFRESH-INTERVAL;VALUE=DURATION:PT1H',
    'X-PUBLISHED-TTL:PT1H',
  ];
  for (const e of events) {
    lines.push(
      'BEGIN:VEVENT',
      `UID:${e.id}@huddle`,
      `DTSTAMP:${utc(now)}`,
      `LAST-MODIFIED:${utc(e.updatedAt)}`,
      `DTSTART:${utc(e.startsAt)}`,
      `DTEND:${utc(e.endsAt)}`,
      `SUMMARY:${escapeText(e.cancelled ? `ANNULLATO – ${e.title}` : e.title)}`,
      `STATUS:${e.cancelled ? 'CANCELLED' : 'CONFIRMED'}`,
    );
    if (e.location) lines.push(`LOCATION:${escapeText(e.location)}`);
    if (e.description) lines.push(`DESCRIPTION:${escapeText(e.description)}`);
    lines.push('END:VEVENT');
  }
  lines.push('END:VCALENDAR');
  return lines.map(foldLine).join('\r\n') + '\r\n';
}
