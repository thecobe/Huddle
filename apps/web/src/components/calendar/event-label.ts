import type { EventFieldsFragment } from '@/gql/graphql';

type T = (key: string) => string;

/** Titolo mostrato: titolo esplicito, oppure "vs Avversario" per le gare, oppure il tipo di evento. */
export function eventLabel(e: Pick<EventFieldsFragment, 'title' | 'kind' | 'opponent'>, t: T): string {
  if (e.title) return e.title;
  if (e.kind === 'MATCH' && e.opponent) return `${t('calendar.vs')} ${e.opponent}`;
  return t(`calendar.kinds.${e.kind}`);
}

export function mapsUrl(location: string): string {
  return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(location)}`;
}
