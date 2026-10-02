<script setup lang="ts">
withDefaults(defineProps<{ tone?: 'neutral' | 'success' | 'warning' | 'brand' }>(), { tone: 'neutral' });
</script>

<template>
  <span class="badge" :class="`badge--${tone}`"><slot /></span>
</template>

<style scoped>
.badge {
  display: inline-flex;
  align-items: center;
  padding: 2px 8px;
  border-radius: 999px;
  font-size: var(--text-xs);
  font-weight: 600;
  white-space: nowrap;
}
.badge--neutral {
  background: var(--surface-muted);
  color: var(--text-muted);
}
.badge--success {
  background: var(--success-soft);
  color: var(--success);
}
.badge--warning {
  background: var(--warning-soft);
  color: var(--warning);
}
.badge--brand {
  background: var(--primary-soft);
  color: var(--primary);
}
</style>
