<script setup lang="ts">
withDefaults(defineProps<{ tone?: 'info' | 'success' | 'warning' | 'error' }>(), { tone: 'info' });
</script>

<template>
  <div class="alert" :class="`alert--${tone}`" :role="tone === 'error' ? 'alert' : 'status'">
    <slot />
  </div>
</template>

<style scoped>
.alert {
  padding: var(--space-3) var(--space-4);
  border-radius: var(--radius);
  font-size: var(--text-sm);
  border: 1px solid transparent;
}
.alert--info {
  background: var(--info-soft);
  color: var(--info);
}
.alert--success {
  background: var(--success-soft);
  color: var(--success);
}
.alert--warning {
  background: var(--warning-soft);
  color: var(--warning);
}
.alert--error {
  background: var(--danger-soft);
  color: var(--danger);
}
</style>
