<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { CopyTeamsDoc, CreateTeamDoc, TeamsDoc } from '@/api/people';
import { ErrorAlert, HAlert, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const router = useRouter();
const canManage = computed(() => session.allowed('team.manage'));

const seasonId = ref('');
const query = useQuery({
  query: TeamsDoc,
  variables: computed(() => ({ seasonId: seasonId.value || null, includeArchived: false })),
});
const seasons = computed(() => query.data.value?.seasons ?? []);
// Stagione predefinita: quella aperta, altrimenti la più recente.
watch(
  seasons,
  (list) => {
    if (!seasonId.value && list.length) seasonId.value = (list.find((s) => s.status === 'OPEN') ?? list[0])!.id;
  },
  { immediate: true },
);
const teams = computed(() => (seasonId.value ? (query.data.value?.teams ?? []).filter((t) => t.seasonId === seasonId.value) : []));

const create = useMutation(CreateTeamDoc);
const copy = useMutation(CopyTeamsDoc);
const showCreate = ref(false);
const showCopy = ref(false);
const form = ref({ name: '', category: '', birthYearFrom: '', birthYearTo: '' });
const copyFrom = ref('');
const copyPlayers = ref(false);
const error = ref<string | null>(null);

async function submit() {
  error.value = null;
  const f = form.value;
  const res = await create.executeMutation({
    input: {
      seasonId: seasonId.value,
      name: f.name,
      category: f.category.trim() || null,
      birthYearFrom: f.birthYearFrom ? Number(f.birthYearFrom) : null,
      birthYearTo: f.birthYearTo ? Number(f.birthYearTo) : null,
    },
  });
  error.value = errorCode(res.error);
  if (res.data) await router.push({ name: 'team', params: { id: res.data.createTeam.id } });
}

async function runCopy() {
  error.value = null;
  const res = await copy.executeMutation({
    input: { fromSeasonId: copyFrom.value, toSeasonId: seasonId.value, includePlayers: copyPlayers.value },
  });
  error.value = errorCode(res.error);
  if (!res.error) {
    showCopy.value = false;
    query.executeQuery({ requestPolicy: 'network-only' });
  }
}

const otherSeasons = computed(() => seasons.value.filter((s) => s.id !== seasonId.value));
</script>

<template>
  <div>
    <PageHeader :title="$t('teams.title')" :subtitle="$t('teams.subtitle')">
      <HSelect
        v-if="seasons.length"
        v-model="seasonId"
        class="season"
        :aria-label="$t('teams.season')"
        :options="seasons.map((s) => ({ value: s.id, label: s.name }))"
      />
      <template v-if="canManage && seasonId">
        <HButton v-if="otherSeasons.length" variant="secondary" @click="showCopy = !showCopy">{{ $t('teams.copy') }}</HButton>
        <HButton @click="showCreate = !showCreate">{{ $t('teams.new') }}</HButton>
      </template>
    </PageHeader>

    <div class="stack">
      <ErrorAlert :code="error ?? errorCode(query.error.value)" />
      <HAlert v-if="query.data.value && !seasons.length" tone="info">
        {{ $t('teams.needSeason') }} <RouterLink :to="{ name: 'seasons' }">{{ $t('nav.seasons') }}</RouterLink>
      </HAlert>

      <HCard v-if="showCopy" :title="$t('teams.copy')" :description="$t('teams.copyHint')">
        <form class="stack" @submit.prevent="runCopy">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('teams.copyFrom')">
              <HSelect :id="id" v-model="copyFrom" :options="[{ value: '', label: '—' }, ...otherSeasons.map((s) => ({ value: s.id, label: s.name }))]" />
            </HField>
          </div>
          <label class="check"><input v-model="copyPlayers" type="checkbox" /> {{ $t('teams.copyPlayers') }}</label>
          <div class="row">
            <HButton type="submit" :disabled="!copyFrom" :loading="copy.fetching.value">{{ $t('teams.copy') }}</HButton>
          </div>
        </form>
      </HCard>

      <HCard v-if="showCreate" :title="$t('teams.new')">
        <form class="stack" @submit.prevent="submit">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('teams.name')">
              <HInput :id="id" v-model="form.name" required placeholder="Under 15" />
            </HField>
            <HField v-slot="{ id }" :label="$t('teams.category')" optional>
              <HInput :id="id" v-model="form.category" placeholder="Giovanissimi" />
            </HField>
            <HField v-slot="{ id }" :label="`${$t('teams.birthYears')} – ${$t('teams.from')}`" optional>
              <HInput :id="id" v-model="form.birthYearFrom" type="number" min="1900" max="2100" />
            </HField>
            <HField v-slot="{ id }" :label="`${$t('teams.birthYears')} – ${$t('teams.to')}`" optional>
              <HInput :id="id" v-model="form.birthYearTo" type="number" min="1900" max="2100" />
            </HField>
          </div>
          <div class="row">
            <HButton type="submit" :loading="create.fetching.value">{{ $t('common.save') }}</HButton>
          </div>
        </form>
      </HCard>

      <p v-if="seasonId && query.data.value && !teams.length" class="muted">{{ $t('teams.empty') }}</p>
      <div class="cards">
        <RouterLink v-for="t in teams" :key="t.id" :to="{ name: 'team', params: { id: t.id } }" class="team">
          <span class="swatch" :style="{ background: t.color ?? 'var(--primary)' }" />
          <strong>{{ t.name }}</strong>
          <span class="muted small">
            {{ [t.category, t.birthYearFrom && t.birthYearTo ? `${t.birthYearFrom}–${t.birthYearTo}` : t.birthYearFrom].filter(Boolean).join(' · ') }}
          </span>
          <span class="small">{{ t.playerCount }} {{ $t('teams.players').toLowerCase() }} · {{ t.staffCount }} {{ $t('teams.staff').toLowerCase() }}</span>
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<style scoped>
.season {
  min-width: 140px;
}
.check {
  display: flex;
  gap: var(--space-2);
  align-items: center;
  font-size: var(--text-sm);
}
.check input {
  accent-color: var(--primary);
}
.cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: var(--space-3);
}
.team {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: var(--space-1);
  padding: var(--space-4) var(--space-4) var(--space-4) var(--space-5);
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  color: var(--text);
  overflow: hidden;
}
.team:hover {
  border-color: var(--primary);
  text-decoration: none;
}
.swatch {
  position: absolute;
  inset: 0 auto 0 0;
  width: 5px;
}
.small {
  font-size: var(--text-xs);
}
</style>
