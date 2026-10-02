<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRoute } from 'vue-router';
import { errorCode } from '@/api/client';
import {
  AddPlayerDoc,
  AddStaffDoc,
  RemovePlayerDoc,
  RemoveStaffDoc,
  TeamDoc,
  UpdatePlayerDoc,
  UpdateTeamDoc,
} from '@/api/people';
import PersonPicker from '@/components/PersonPicker.vue';
import { ErrorAlert, HAlert, HBadge, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import type { StaffRole, TeamDetailFieldsFragment } from '@/gql/graphql';
import { useSessionStore } from '@/stores/session';

const STAFF_ROLES: StaffRole[] = ['HEAD_COACH', 'ASSISTANT_COACH', 'FITNESS_COACH', 'GOALKEEPER_COACH', 'TEAM_MANAGER'];

const route = useRoute();
const session = useSessionStore();
const { t } = useI18n();
const id = computed(() => String(route.params.id));
const canManage = computed(() => session.allowed('team.manage'));

const query = useQuery({ query: TeamDoc, variables: computed(() => ({ id: id.value })) });
const team = ref<TeamDetailFieldsFragment | null>(null);
watch(
  () => query.data.value?.team,
  (v) => {
    if (v) load(v);
  },
  { immediate: true },
);

const form = ref({ name: '', category: '', birthYearFrom: '', birthYearTo: '', color: '#17633e' });
function load(v: TeamDetailFieldsFragment) {
  team.value = v;
  form.value = {
    name: v.name,
    category: v.category ?? '',
    birthYearFrom: v.birthYearFrom?.toString() ?? '',
    birthYearTo: v.birthYearTo?.toString() ?? '',
    color: v.color ?? '#17633e',
  };
}

const updateTeam = useMutation(UpdateTeamDoc);
const addPlayer = useMutation(AddPlayerDoc);
const updatePlayer = useMutation(UpdatePlayerDoc);
const removePlayer = useMutation(RemovePlayerDoc);
const addStaff = useMutation(AddStaffDoc);
const removeStaff = useMutation(RemoveStaffDoc);
const error = ref<string | null>(null);
const saved = ref(false);
const staffRole = ref<StaffRole>('HEAD_COACH');

async function apply<T extends Record<string, unknown>>(
  promise: Promise<{ data?: T; error?: unknown }>,
  key: keyof T,
) {
  const res = await promise;
  error.value = errorCode(res.error as never);
  const v = res.data?.[key] as TeamDetailFieldsFragment | undefined;
  if (v) load(v);
  return !!v;
}

async function saveTeam() {
  saved.value = false;
  const f = form.value;
  saved.value = await apply(
    updateTeam.executeMutation({
      id: id.value,
      input: {
        seasonId: team.value!.seasonId,
        name: f.name,
        category: f.category.trim() || null,
        birthYearFrom: f.birthYearFrom ? Number(f.birthYearFrom) : null,
        birthYearTo: f.birthYearTo ? Number(f.birthYearTo) : null,
        color: f.color,
      },
    }),
    'updateTeam',
  );
}

function jerseyChanged(rosterId: string, value: string, position: string | null) {
  const n = value.trim() === '' ? null : Number(value);
  if (n !== null && (!Number.isInteger(n) || n < 0 || n > 99)) return;
  apply(updatePlayer.executeMutation({ rosterId, input: { jerseyNumber: n, position } }), 'updatePlayer');
}

const excluded = computed(() => [...(team.value?.players ?? []).map((p) => p.personId)]);
const availabilityTone = (a: string) => (a === 'AVAILABLE' ? 'success' : 'warning');
const title = computed(() => team.value?.name ?? t('common.loading'));
</script>

<template>
  <div>
    <RouterLink :to="{ name: 'teams' }" class="back">← {{ $t('teams.title') }}</RouterLink>
    <PageHeader :title="title" :subtitle="team ? team.seasonName : undefined" />

    <div v-if="team" class="stack">
      <ErrorAlert :code="error ?? errorCode(query.error.value)" />

      <HCard :title="`${$t('teams.players')} (${team.players.length})`" :padded="false">
        <div v-if="canManage" class="toolbar">
          <PersonPicker :label="$t('teams.addPlayer')" :exclude="excluded" @pick="(p) => apply(addPlayer.executeMutation({ teamId: id, personId: p.id }), 'addPlayer')" />
        </div>
        <p v-if="!team.players.length" class="muted empty">{{ $t('teams.noPlayers') }}</p>
        <div v-else class="table-wrap">
          <table class="data">
            <thead>
              <tr>
                <th class="num">{{ $t('teams.jersey') }}</th>
                <th>{{ $t('common.fullName') }}</th>
                <th>{{ $t('teams.guardians') }}</th>
                <th>{{ $t('teams.position') }}</th>
                <th v-if="canManage"><span class="sr-only">Azioni</span></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="p in team.players" :key="p.id">
                <td class="num">
                  <input
                    v-if="canManage"
                    class="jersey"
                    :value="p.jerseyNumber ?? ''"
                    inputmode="numeric"
                    maxlength="2"
                    :aria-label="`${$t('teams.jersey')} ${p.firstName} ${p.lastName}`"
                    @change="jerseyChanged(p.id, ($event.target as HTMLInputElement).value, p.position ?? null)"
                  />
                  <span v-else>{{ p.jerseyNumber ?? '—' }}</span>
                </td>
                <td>
                  <RouterLink :to="{ name: 'person', params: { id: p.personId } }">
                    <strong>{{ p.lastName }} {{ p.firstName }}</strong>
                  </RouterLink>
                  <div class="row tight">
                    <span class="muted small">{{ p.birthDate ?? '' }}</span>
                    <HBadge v-if="p.availability !== 'AVAILABLE'" :tone="availabilityTone(p.availability)">
                      {{ $t(`teams.availability.${p.availability}`) }}
                    </HBadge>
                  </div>
                </td>
                <td class="small">
                  <div v-for="g in p.guardians" :key="g.personId">
                    {{ g.name }} <span class="muted">{{ [g.phone, g.email].filter(Boolean).join(' · ') }}</span>
                  </div>
                  <span v-if="!p.guardians.length" class="muted">{{ [p.phone, p.email].filter(Boolean).join(' · ') || '—' }}</span>
                </td>
                <td class="small">{{ p.position ?? '—' }}</td>
                <td v-if="canManage" class="actions">
                  <HButton size="sm" variant="ghost" @click="apply(removePlayer.executeMutation({ rosterId: p.id }), 'removePlayer')">
                    {{ $t('common.remove') }}
                  </HButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </HCard>

      <HCard :title="`${$t('teams.staff')} (${team.staff.length})`">
        <p v-if="!team.staff.length" class="muted">{{ $t('teams.noStaff') }}</p>
        <ul class="list">
          <li v-for="s in team.staff" :key="s.id">
            <div>
              <RouterLink :to="{ name: 'person', params: { id: s.personId } }">
                <strong>{{ s.firstName }} {{ s.lastName }}</strong>
              </RouterLink>
              <span class="muted"> · {{ $t(`teams.staffRoles.${s.role}`) }}</span>
              <div class="muted small">
                {{ [s.phone, s.email].filter(Boolean).join(' · ') }}
                <span v-if="!s.hasAccount"> · {{ $t('teams.noAccountHint') }}</span>
              </div>
            </div>
            <HButton v-if="canManage" size="sm" variant="ghost" @click="apply(removeStaff.executeMutation({ staffId: s.id }), 'removeStaff')">
              {{ $t('common.remove') }}
            </HButton>
          </li>
        </ul>
        <div v-if="canManage" class="row">
          <HSelect v-model="staffRole" class="role" :aria-label="$t('teams.role')" :options="STAFF_ROLES.map((r) => ({ value: r, label: $t(`teams.staffRoles.${r}`) }))" />
          <PersonPicker :label="$t('teams.addStaff')" @pick="(p) => apply(addStaff.executeMutation({ teamId: id, personId: p.id, role: staffRole }), 'addStaff')" />
        </div>
      </HCard>

      <HCard v-if="canManage" :title="$t('teams.settings')">
        <form class="stack" @submit.prevent="saveTeam">
          <div class="grid-2">
            <HField v-slot="{ id: fid }" :label="$t('teams.name')">
              <HInput :id="fid" v-model="form.name" required />
            </HField>
            <HField v-slot="{ id: fid }" :label="$t('teams.category')" optional>
              <HInput :id="fid" v-model="form.category" />
            </HField>
            <HField v-slot="{ id: fid }" :label="`${$t('teams.birthYears')} – ${$t('teams.from')}`" optional>
              <HInput :id="fid" v-model="form.birthYearFrom" type="number" />
            </HField>
            <HField v-slot="{ id: fid }" :label="`${$t('teams.birthYears')} – ${$t('teams.to')}`" optional>
              <HInput :id="fid" v-model="form.birthYearTo" type="number" />
            </HField>
            <HField v-slot="{ id: fid }" :label="$t('teams.color')">
              <input :id="fid" v-model="form.color" type="color" class="color" />
            </HField>
          </div>
          <HAlert v-if="saved" tone="success">{{ $t('common.saved') }}</HAlert>
          <div class="row"><HButton type="submit" :loading="updateTeam.fetching.value">{{ $t('common.save') }}</HButton></div>
        </form>
      </HCard>
    </div>
    <ErrorAlert v-else :code="errorCode(query.error.value)" />
  </div>
</template>

<style scoped>
.back {
  display: inline-block;
  margin-bottom: var(--space-3);
  font-size: var(--text-sm);
}
.toolbar {
  display: flex;
  padding: 0 var(--space-5) var(--space-3);
}
.empty {
  padding: 0 var(--space-5) var(--space-5);
}
.num {
  width: 64px;
}
.jersey {
  width: 48px;
  min-height: 34px;
  text-align: center;
  border: 1px solid var(--border-strong);
  border-radius: var(--radius-sm);
  background: var(--surface);
  color: var(--text);
  font: inherit;
  font-weight: 700;
}
.small {
  font-size: var(--text-xs);
}
.tight {
  gap: var(--space-2);
}
.actions {
  text-align: right;
}
.list {
  list-style: none;
  margin: 0;
  padding: 0;
}
.list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-2) 0;
  border-bottom: 1px solid var(--border);
}
.list li:last-child {
  border-bottom: none;
}
.role {
  max-width: 220px;
}
.color {
  width: 64px;
  height: 42px;
  padding: 2px;
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
}
</style>
