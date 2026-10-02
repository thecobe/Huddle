<script setup lang="ts">
import { useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { errorCode } from '@/api/client';
import { PeopleDoc, TeamsDoc } from '@/api/people';
import { ErrorAlert, HBadge, HButton, HCard, HInput, HSelect, PageHeader } from '@/components/ui';
import type { PersonCategory } from '@/gql/graphql';
import { useSessionStore } from '@/stores/session';

const PAGE = 50;
const CATEGORIES: PersonCategory[] = ['ATHLETE', 'STAFF', 'MANAGER', 'VOLUNTEER', 'GUARDIAN'];

const session = useSessionStore();
const canManage = computed(() => session.allowed('people.manage'));

const search = ref('');
const debounced = ref('');
const category = ref('');
const teamId = ref('');
const includeArchived = ref(false);
const offset = ref(0);
let timer: ReturnType<typeof setTimeout> | undefined;
watch(search, (v) => {
  clearTimeout(timer);
  timer = setTimeout(() => (debounced.value = v.trim()), 250);
});
watch([debounced, category, teamId, includeArchived], () => (offset.value = 0));

const variables = computed(() => ({
  filter: {
    search: debounced.value || undefined,
    category: (category.value || undefined) as PersonCategory | undefined,
    teamId: teamId.value || undefined,
    includeArchived: includeArchived.value,
  },
  limit: PAGE,
  offset: offset.value,
}));
const query = useQuery({ query: PeopleDoc, variables });
const teams = useQuery({ query: TeamsDoc, variables: { seasonId: null, includeArchived: false } });

const page = computed(() => query.data.value?.people);
const teamOptions = computed(() => [
  { value: '', label: '—' },
  ...(teams.data.value?.teams ?? []).map((t) => ({ value: t.id, label: `${t.name} · ${t.seasonName}` })),
]);
</script>

<template>
  <div>
    <PageHeader :title="$t('people.title')" :subtitle="$t('people.subtitle')">
      <template v-if="canManage">
        <RouterLink :to="{ name: 'people-import' }" class="link-btn">{{ $t('people.import') }}</RouterLink>
        <RouterLink :to="{ name: 'person-new' }"><HButton>{{ $t('people.new') }}</HButton></RouterLink>
      </template>
    </PageHeader>

    <div class="filters">
      <HInput v-model="search" type="search" :placeholder="$t('people.search')" :aria-label="$t('people.search')" />
      <HSelect
        v-model="category"
        :aria-label="$t('people.categories')"
        :options="[{ value: '', label: $t('people.allCategories') }, ...CATEGORIES.map((c) => ({ value: c, label: $t(`people.categoryLabels.${c}`) }))]"
      />
      <HSelect v-model="teamId" :aria-label="$t('people.teams')" :options="[{ value: '', label: $t('people.allTeams') }, ...teamOptions.slice(1)]" />
      <label class="check"><input v-model="includeArchived" type="checkbox" /> {{ $t('people.showArchived') }}</label>
    </div>

    <ErrorAlert :code="errorCode(query.error.value)" />

    <HCard :padded="false">
      <p v-if="page && !page.items.length" class="muted empty">{{ $t('people.empty') }}</p>
      <div v-else class="table-wrap">
        <table class="data">
          <thead>
            <tr>
              <th>{{ $t('common.fullName') }}</th>
              <th>{{ $t('people.age') }}</th>
              <th>{{ $t('people.categories') }}</th>
              <th>{{ $t('people.teams') }}</th>
              <th>{{ $t('people.account') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="p in page?.items" :key="p.id" :class="{ archived: p.archivedAt }">
              <td>
                <RouterLink :to="{ name: 'person', params: { id: p.id } }">
                  <strong>{{ p.lastName }} {{ p.firstName }}</strong>
                </RouterLink>
                <div class="muted small">{{ p.email ?? p.phone ?? '' }}</div>
              </td>
              <td>
                {{ p.age ?? '—' }}
                <HBadge v-if="p.isMinor" tone="warning">{{ $t('people.minor') }}</HBadge>
              </td>
              <td>
                <div class="row tight">
                  <HBadge v-for="c in p.categories" :key="c" tone="brand">{{ $t(`people.categoryLabels.${c}`) }}</HBadge>
                  <HBadge v-if="p.archivedAt">{{ $t('people.archived') }}</HBadge>
                </div>
              </td>
              <td class="small">{{ p.teams.map((t) => t.teamName).join(', ') || '—' }}</td>
              <td>
                <HBadge :tone="p.hasAccount ? 'success' : 'neutral'">
                  {{ p.hasAccount ? $t('people.hasAccount') : $t('people.noAccount') }}
                </HBadge>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </HCard>

    <div v-if="page && page.total > PAGE" class="row pager">
      <span class="muted small">
        {{ $t('people.pageOf', { from: offset + 1, to: Math.min(offset + PAGE, page.total), total: page.total }) }}
      </span>
      <HButton size="sm" variant="secondary" :disabled="offset === 0" @click="offset = Math.max(0, offset - PAGE)">
        {{ $t('people.prev') }}
      </HButton>
      <HButton size="sm" variant="secondary" :disabled="offset + PAGE >= page.total" @click="offset += PAGE">
        {{ $t('people.next') }}
      </HButton>
    </div>
  </div>
</template>

<style scoped>
.filters {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr auto;
  gap: var(--space-3);
  align-items: center;
  margin-bottom: var(--space-4);
}
.check {
  display: flex;
  gap: var(--space-2);
  align-items: center;
  font-size: var(--text-sm);
  white-space: nowrap;
}
.check input {
  accent-color: var(--primary);
}
.small {
  font-size: var(--text-xs);
}
.tight {
  gap: var(--space-1);
}
.empty {
  padding: var(--space-5);
}
.archived td {
  opacity: 0.6;
}
.pager {
  justify-content: flex-end;
  margin-top: var(--space-4);
}
.link-btn {
  font-weight: 600;
  font-size: var(--text-sm);
}
@media (max-width: 860px) {
  .filters {
    grid-template-columns: 1fr 1fr;
  }
  .filters > :first-child {
    grid-column: 1 / -1;
  }
}
</style>
