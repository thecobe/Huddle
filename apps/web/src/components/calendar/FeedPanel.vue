<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { errorCode } from '@/api/client';
import { CreateFeedDoc } from '@/api/calendar';
import { ErrorAlert, HButton, HCard, HField, HSelect } from '@/components/ui';

defineProps<{ teams: { id: string; name: string }[] }>();

const teamId = ref('');
const url = ref<string | null>(null);
const copied = ref(false);
const error = ref<string | null>(null);
const mutation = useMutation(CreateFeedDoc);

async function generate() {
  copied.value = false;
  const res = await mutation.executeMutation({ teamId: teamId.value || null });
  error.value = errorCode(res.error);
  url.value = res.data?.createCalendarFeed.url ?? null;
}

async function copy() {
  if (!url.value) return;
  await navigator.clipboard.writeText(url.value);
  copied.value = true;
}
</script>

<template>
  <HCard :title="$t('calendar.subscribeTitle')" :description="$t('calendar.subscribeHint')">
    <div class="row">
      <HField v-slot="{ id }" :label="$t('calendar.team')" class="grow">
        <HSelect :id="id" v-model="teamId" :options="[{ value: '', label: $t('calendar.personal') }, ...teams.map((tm) => ({ value: tm.id, label: tm.name }))]" />
      </HField>
      <HButton class="align-end" :loading="mutation.fetching.value" @click="generate">{{ $t('calendar.generate') }}</HButton>
    </div>
    <ErrorAlert :code="error" />
    <div v-if="url" class="row">
      <input class="url" :value="url" readonly :aria-label="$t('calendar.subscribeTitle')" @focus="($event.target as HTMLInputElement).select()" />
      <HButton variant="secondary" @click="copy">{{ copied ? $t('calendar.copied') : $t('calendar.copy') }}</HButton>
    </div>
  </HCard>
</template>

<style scoped>
.grow {
  flex: 1;
  min-width: 200px;
}
.align-end {
  align-self: flex-end;
}
.url {
  flex: 1;
  min-width: 0;
  min-height: 42px;
  padding: 0 var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface-muted);
  color: var(--text);
  font: inherit;
  font-size: var(--text-sm);
}
</style>
