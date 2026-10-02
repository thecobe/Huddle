import { createI18n } from 'vue-i18n';
import en from './locales/en.json';
import it from './locales/it.json';

export type Locale = 'it' | 'en';
export const LOCALES: Locale[] = ['it', 'en'];
const KEY = 'huddle.locale';

function initialLocale(): Locale {
  try {
    const saved = localStorage.getItem(KEY);
    if (saved === 'it' || saved === 'en') return saved;
  } catch {
    // ignora
  }
  return navigator.language.toLowerCase().startsWith('it') ? 'it' : 'en';
}

export const i18n = createI18n({
  legacy: false,
  locale: initialLocale(),
  fallbackLocale: 'it',
  messages: { it, en },
});

export function setLocale(locale: Locale): void {
  i18n.global.locale.value = locale;
  document.documentElement.lang = locale;
  try {
    localStorage.setItem(KEY, locale);
  } catch {
    // ignora
  }
}
