<script setup lang="ts">
const model = defineModel<string | null>();
defineProps<{ invalid?: boolean }>();
</script>

<template>
  <input
    :value="model ?? ''"
    class="input"
    :class="{ 'input--invalid': invalid }"
    :aria-invalid="invalid || undefined"
    @input="model = ($event.target as HTMLInputElement).value"
  />
</template>

<style scoped>
.input {
  width: 100%;
  min-height: 42px;
  padding: 0 var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
  color: var(--text);
  font: inherit;
  font-size: var(--text-md);
}
.input:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: var(--focus-ring);
}
.input--invalid {
  border-color: var(--danger);
}
.input::placeholder {
  color: var(--text-subtle);
}
</style>
