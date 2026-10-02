<script setup lang="ts">
defineProps<{ title?: string; description?: string; padded?: boolean }>();
</script>

<template>
  <section class="card" :class="{ 'card--flush': padded === false }">
    <header v-if="title || $slots.actions" class="card__header">
      <div>
        <h2 v-if="title">{{ title }}</h2>
        <p v-if="description" class="muted card__desc">{{ description }}</p>
      </div>
      <div v-if="$slots.actions" class="row"><slot name="actions" /></div>
    </header>
    <slot />
  </section>
</template>

<style scoped>
.card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  padding: var(--space-5);
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}
.card--flush {
  padding: 0;
}
.card--flush .card__header {
  padding: var(--space-5) var(--space-5) 0;
}
.card__header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--space-3);
  flex-wrap: wrap;
}
.card__desc {
  font-size: var(--text-sm);
  margin-top: 2px;
}
@media (max-width: 640px) {
  .card {
    padding: var(--space-4);
  }
}
</style>
