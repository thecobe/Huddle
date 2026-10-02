<script setup lang="ts">
import { useClientHandle } from '@urql/vue';
import { ref, useId, watch } from 'vue';
import { PeopleDoc } from '@/api/people';
import type { PeopleQuery } from '@/gql/graphql';

type Found = PeopleQuery['people']['items'][number];

const props = defineProps<{ exclude?: string[]; label?: string }>();
const emit = defineEmits<{ pick: [person: Found] }>();

const handle = useClientHandle();
const id = useId();
const term = ref('');
const results = ref<Found[]>([]);
const open = ref(false);
let timer: ReturnType<typeof setTimeout> | undefined;

watch(term, (value) => {
  clearTimeout(timer);
  if (value.trim().length < 2) {
    results.value = [];
    return;
  }
  timer = setTimeout(async () => {
    const res = await handle.client
      .query(PeopleDoc, { filter: { search: value.trim() }, limit: 8, offset: 0 }, { requestPolicy: 'network-only' })
      .toPromise();
    results.value = (res.data?.people.items ?? []).filter((p) => !props.exclude?.includes(p.id));
    open.value = true;
  }, 250);
});

function pick(p: Found) {
  emit('pick', p);
  term.value = '';
  results.value = [];
  open.value = false;
}
</script>

<template>
  <div class="picker">
    <label :for="id" class="sr-only">{{ label ?? $t('people.pickPerson') }}</label>
    <input
      :id="id"
      v-model="term"
      class="picker__input"
      type="search"
      autocomplete="off"
      role="combobox"
      :aria-expanded="open && term.length >= 2"
      :aria-controls="`${id}-list`"
      :placeholder="label ?? $t('people.pickPerson')"
      @focus="open = true"
      @keydown.esc="open = false"
    />
    <ul v-if="open && term.trim().length >= 2" :id="`${id}-list`" class="picker__list" role="listbox">
      <li v-for="p in results" :key="p.id" role="option" :aria-selected="false">
        <button type="button" @click="pick(p)">
          <strong>{{ p.lastName }} {{ p.firstName }}</strong>
          <span class="muted">{{ p.age !== null ? $t('people.years', { n: p.age }) : '' }} {{ p.email ?? '' }}</span>
        </button>
      </li>
      <li v-if="!results.length" class="picker__empty muted">{{ $t('people.noResults') }}</li>
    </ul>
  </div>
</template>

<style scoped>
.picker {
  position: relative;
  min-width: 240px;
  flex: 1;
}
.picker__input {
  width: 100%;
  min-height: 42px;
  padding: 0 var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
  color: var(--text);
  font: inherit;
}
.picker__input:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: var(--focus-ring);
}
.picker__list {
  position: absolute;
  z-index: 10;
  inset: calc(100% + 4px) 0 auto;
  margin: 0;
  padding: var(--space-1);
  list-style: none;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  max-height: 280px;
  overflow-y: auto;
}
.picker__list button {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 2px;
  padding: var(--space-2) var(--space-3);
  border: none;
  background: none;
  color: var(--text);
  font: inherit;
  text-align: left;
  border-radius: var(--radius-sm);
  cursor: pointer;
}
.picker__list button:hover,
.picker__list button:focus-visible {
  background: var(--surface-muted);
}
.picker__list .muted {
  font-size: var(--text-xs);
}
.picker__empty {
  padding: var(--space-2) var(--space-3);
  font-size: var(--text-sm);
}
</style>
