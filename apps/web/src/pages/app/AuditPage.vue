<script setup lang="ts">
import { useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { AuditEventsDoc } from '@/api/operations';
import { ErrorAlert, HButton, HCard, PageHeader } from '@/components/ui';
import type { AuditEventsQuery } from '@/gql/graphql';

const { d, t, te } = useI18n();
const beforeId = ref<string | null>(null);
const pages = ref<AuditEventsQuery['auditEvents'][]>([]);
const query = useQuery({ query: AuditEventsDoc, variables: computed(() => ({ beforeId: beforeId.value })) });

const events = computed(() => {
  const current = query.data.value?.auditEvents ?? [];
  const seen = new Set<string>();
  return [...pages.value.flat(), ...current].filter((e) => !seen.has(e.id) && seen.add(e.id));
});

function loadMore() {
  const last = events.value.at(-1);
  if (!last) return;
  pages.value.push(query.data.value?.auditEvents ?? []);
  beforeId.value = last.id;
}

const label = (action: string) => (te(`audit.actions.${action}`) ? t(`audit.actions.${action}`) : action);
const when = (iso: string) => d(new Date(iso), { dateStyle: 'medium', timeStyle: 'short' } as never);
</script>

<template>
  <div>
    <PageHeader :title="$t('audit.title')" :subtitle="$t('audit.subtitle')" />
    <ErrorAlert :code="errorCode(query.error.value)" />
    <HCard :padded="false">
      <div class="table-wrap">
        <table class="data">
          <thead>
            <tr>
              <th>{{ $t('audit.when') }}</th>
              <th>{{ $t('audit.who') }}</th>
              <th>{{ $t('audit.what') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="e in events" :key="e.id">
              <td class="nowrap">{{ when(e.createdAt) }}</td>
              <td>{{ e.actorName ?? $t('audit.system') }}</td>
              <td>{{ label(e.action) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </HCard>
    <div v-if="(query.data.value?.auditEvents.length ?? 0) === 50" class="row more">
      <HButton variant="secondary" :loading="query.fetching.value" @click="loadMore">{{ $t('audit.more') }}</HButton>
    </div>
  </div>
</template>

<style scoped>
.nowrap {
  white-space: nowrap;
}
.more {
  justify-content: center;
  margin-top: var(--space-4);
}
</style>
