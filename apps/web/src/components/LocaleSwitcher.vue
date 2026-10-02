<script setup lang="ts">
import { useI18n } from 'vue-i18n';
import { LOCALES, type Locale, setLocale } from '@/i18n';

const { locale } = useI18n();
</script>

<template>
  <div class="locale" role="group" :aria-label="$t('common.language')">
    <button
      v-for="l in LOCALES"
      :key="l"
      type="button"
      :aria-pressed="locale === l"
      :class="{ active: locale === l }"
      @click="setLocale(l as Locale)"
    >
      {{ l.toUpperCase() }}
    </button>
  </div>
</template>

<style scoped>
.locale {
  display: inline-flex;
  gap: 2px;
  font-size: var(--text-xs);
}
button {
  border: none;
  background: transparent;
  color: var(--text-subtle);
  font: inherit;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: var(--radius-sm);
  cursor: pointer;
}
button.active {
  color: var(--text);
  background: var(--surface-muted);
}
</style>
