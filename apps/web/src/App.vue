<script setup lang="ts">
import { provideClient } from '@urql/vue';
import { storeToRefs } from 'pinia';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
// Il client cambia con la società selezionata: la cache non mescola dati di società diverse.
provideClient(storeToRefs(session).client);
</script>

<template>
  <RouterView :key="session.clubId ?? 'no-club'" />
</template>
