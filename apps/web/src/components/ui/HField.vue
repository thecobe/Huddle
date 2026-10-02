<script setup lang="ts">
import { computed, useId } from 'vue';

const props = defineProps<{
  label: string;
  hint?: string;
  error?: string | null;
  optional?: boolean;
}>();

const id = useId();
const describedBy = computed(() => [props.hint && `${id}-hint`, props.error && `${id}-error`].filter(Boolean).join(' ') || undefined);
</script>

<template>
  <div class="field" :class="{ 'field--error': !!error }">
    <label :for="id" class="field__label">
      {{ label }}
      <span v-if="optional" class="field__optional">({{ $t('common.optional') }})</span>
    </label>
    <slot :id="id" :described-by="describedBy" :invalid="!!error" />
    <p v-if="hint && !error" :id="`${id}-hint`" class="field__hint">{{ hint }}</p>
    <p v-if="error" :id="`${id}-error`" class="field__error" role="alert">{{ error }}</p>
  </div>
</template>

<style scoped>
.field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.field__label {
  font-size: var(--text-sm);
  font-weight: 600;
}
.field__optional {
  font-weight: 400;
  color: var(--text-subtle);
}
.field__hint {
  font-size: var(--text-xs);
  color: var(--text-muted);
}
.field__error {
  font-size: var(--text-xs);
  color: var(--danger);
}
</style>
