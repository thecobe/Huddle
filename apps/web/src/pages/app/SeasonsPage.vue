<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { CreateSeasonDoc, SeasonsDoc, SetSeasonStatusDoc } from '@/api/operations';
import { ErrorAlert, HBadge, HButton, HCard, HField, HInput, PageHeader } from '@/components/ui';
import type { SeasonStatus } from '@/gql/graphql';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const { d } = useI18n();
const canManage = computed(() => session.allowed('season.manage'));

const seasons = useQuery({ query: SeasonsDoc });
const create = useMutation(CreateSeasonDoc);
const setStatus = useMutation(SetSeasonStatusDoc);

const showForm = ref(false);
const form = ref({ name: '', startsOn: '', endsOn: '' });
const error = ref<string | null>(null);

const tone = (s: SeasonStatus) => (s === 'OPEN' ? 'success' : s === 'PLANNED' ? 'warning' : 'neutral');
const fmt = (iso: string) => d(new Date(`${iso}T00:00:00`), { day: 'numeric', month: 'short', year: 'numeric' });

async function submit() {
  error.value = null;
  const res = await create.executeMutation({ input: form.value });
  error.value = errorCode(res.error);
  if (res.error) return;
  form.value = { name: '', startsOn: '', endsOn: '' };
  showForm.value = false;
  seasons.executeQuery({ requestPolicy: 'network-only' });
}

async function change(id: string, status: SeasonStatus) {
  error.value = null;
  const res = await setStatus.executeMutation({ id, status });
  error.value = errorCode(res.error);
}
</script>

<template>
  <div>
    <PageHeader :title="$t('seasons.title')" :subtitle="$t('seasons.subtitle')">
      <HButton v-if="canManage && !showForm" @click="showForm = true">{{ $t('seasons.new') }}</HButton>
    </PageHeader>

    <div class="stack">
      <HCard v-if="showForm" :title="$t('seasons.new')">
        <form class="stack" @submit.prevent="submit">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('seasons.name')">
              <HInput :id="id" v-model="form.name" :placeholder="$t('seasons.namePlaceholder')" required />
            </HField>
            <HField v-slot="{ id }" :label="$t('seasons.startsOn')">
              <HInput :id="id" v-model="form.startsOn" type="date" required />
            </HField>
            <HField v-slot="{ id }" :label="$t('seasons.endsOn')">
              <HInput :id="id" v-model="form.endsOn" type="date" required />
            </HField>
          </div>
          <div class="row">
            <HButton type="submit" :loading="create.fetching.value">{{ $t('common.save') }}</HButton>
            <HButton variant="ghost" @click="showForm = false">{{ $t('common.cancel') }}</HButton>
          </div>
        </form>
      </HCard>

      <ErrorAlert :code="error ?? errorCode(seasons.error.value)" />

      <HCard :padded="false">
        <p v-if="seasons.data.value?.seasons.length === 0" class="muted empty">{{ $t('seasons.empty') }}</p>
        <div v-else class="table-wrap">
          <table class="data">
            <thead>
              <tr>
                <th>{{ $t('seasons.name') }}</th>
                <th>{{ $t('seasons.startsOn') }}</th>
                <th>{{ $t('seasons.endsOn') }}</th>
                <th>{{ $t('seasons.status') }}</th>
                <th v-if="canManage"><span class="sr-only">Azioni</span></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="s in seasons.data.value?.seasons" :key="s.id">
                <td><strong>{{ s.name }}</strong></td>
                <td>{{ fmt(s.startsOn) }}</td>
                <td>{{ fmt(s.endsOn) }}</td>
                <td><HBadge :tone="tone(s.status)">{{ $t(`seasons.statuses.${s.status}`) }}</HBadge></td>
                <td v-if="canManage" class="actions">
                  <HButton v-if="s.status !== 'OPEN'" size="sm" variant="secondary" @click="change(s.id, 'OPEN')">{{ $t('seasons.open') }}</HButton>
                  <HButton v-else size="sm" variant="secondary" @click="change(s.id, 'CLOSED')">{{ $t('seasons.close') }}</HButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
.empty {
  padding: var(--space-5);
}
.actions {
  text-align: right;
}
</style>
