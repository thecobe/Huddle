<script setup lang="ts">
const model = defineModel<string>();
defineProps<{ options: { value: string; label: string }[] }>();
</script>

<template>
  <select v-model="model" class="select">
    <option v-for="o in options" :key="o.value" :value="o.value">{{ o.label }}</option>
  </select>
</template>

<style scoped>
.select {
  width: 100%;
  min-height: 42px;
  padding: 0 var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
  color: var(--text);
  font: inherit;
}
.select:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: var(--focus-ring);
}
</style>
