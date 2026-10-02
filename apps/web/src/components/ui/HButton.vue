<script setup lang="ts">
withDefaults(
  defineProps<{
    variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
    size?: 'sm' | 'md';
    type?: 'button' | 'submit';
    loading?: boolean;
    disabled?: boolean;
    block?: boolean;
  }>(),
  { variant: 'primary', size: 'md', type: 'button' },
);
</script>

<template>
  <button
    :type="type"
    class="btn"
    :class="[`btn--${variant}`, `btn--${size}`, { 'btn--block': block }]"
    :disabled="disabled || loading"
    :aria-busy="loading || undefined"
  >
    <span v-if="loading" class="spinner" aria-hidden="true" />
    <slot />
  </button>
</template>

<style scoped>
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  border: 1px solid transparent;
  border-radius: var(--radius);
  font: inherit;
  font-weight: 600;
  cursor: pointer;
  transition:
    background 0.15s,
    border-color 0.15s,
    color 0.15s;
  white-space: nowrap;
}
.btn--md {
  min-height: 42px;
  padding: 0 var(--space-4);
  font-size: var(--text-sm);
}
.btn--sm {
  min-height: 32px;
  padding: 0 var(--space-3);
  font-size: var(--text-xs);
}
.btn--block {
  width: 100%;
}
.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.btn--primary {
  background: var(--primary);
  color: var(--primary-text);
}
.btn--primary:hover:not(:disabled) {
  background: var(--primary-hover);
}
.btn--secondary {
  background: var(--surface);
  border-color: var(--border-strong);
  color: var(--text);
}
.btn--secondary:hover:not(:disabled) {
  background: var(--surface-muted);
}
.btn--ghost {
  background: transparent;
  color: var(--text-muted);
}
.btn--ghost:hover:not(:disabled) {
  background: var(--surface-muted);
  color: var(--text);
}
.btn--danger {
  background: var(--surface);
  border-color: color-mix(in srgb, var(--danger) 40%, transparent);
  color: var(--danger);
}
.btn--danger:hover:not(:disabled) {
  background: var(--danger-soft);
}
.spinner {
  width: 14px;
  height: 14px;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
</style>
