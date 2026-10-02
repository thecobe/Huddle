<script setup lang="ts">
import { HBadge, HCard, PageHeader } from '@/components/ui';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
</script>

<template>
  <div>
    <PageHeader :title="$t('home.title', { name: session.user?.fullName.split(' ')[0] })" :subtitle="$t('home.subtitle')" />
    <HCard :title="$t('home.yourRoles')">
      <div class="row">
        <HBadge v-for="r in session.currentRoles" :key="r" tone="brand">{{ $t(`roles.${r}`) }}</HBadge>
      </div>
    </HCard>
  </div>
</template>
