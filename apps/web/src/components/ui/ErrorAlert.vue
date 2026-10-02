<script setup lang="ts">
import HAlert from './HAlert.vue';

// Mostra il messaggio tradotto per un codice errore dell'API.
defineProps<{ code: string | null }>();
</script>

<template>
  <HAlert v-if="code" tone="error">{{ $te(`errors.${code}`) ? $t(`errors.${code}`) : $t('errors.UNKNOWN') }}</HAlert>
</template>
