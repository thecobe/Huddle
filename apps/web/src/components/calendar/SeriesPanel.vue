<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { CreateSeriesDoc, EndSeriesDoc, SeriesDoc, UpdateSeriesDoc } from '@/api/calendar';
import { ErrorAlert, HAlert, HButton, HCard, HField, HInput, HSelect } from '@/components/ui';
import type { SeriesQuery } from '@/gql/graphql';

type Series = SeriesQuery['eventSeries'][number];

const props = defineProps<{ teams: { id: string; name: string }[]; manageableTeamIds: string[]; today: string }>();
const emit = defineEmits<{ changed: [] }>();
const { t } = useI18n();

const query = useQuery({ query: SeriesDoc, variables: { teamId: null } });
const series = computed(() => (query.data.value?.eventSeries ?? []).filter((s) => props.manageableTeamIds.includes(s.teamId)));

const create = useMutation(CreateSeriesDoc);
const update = useMutation(UpdateSeriesDoc);
const end = useMutation(EndSeriesDoc);
const error = ref<string | null>(null);
const notice = ref<string | null>(null);

const editingId = ref<string | null>(null);
const showForm = ref(false);
const blank = () => ({
  teamId: props.manageableTeamIds[0] ?? '',
  weekdays: [] as number[],
  startTime: '18:00',
  durationMinutes: '90',
  location: '',
  startsOn: '',
  endsOn: '',
  applyFrom: props.today,
});
const form = ref(blank());
const endFrom = ref(props.today);

function edit(s: Series) {
  editingId.value = s.id;
  showForm.value = true;
  form.value = {
    teamId: s.teamId,
    weekdays: [...s.weekdays],
    startTime: s.startTime,
    durationMinutes: String(s.durationMinutes),
    location: s.location ?? '',
    startsOn: s.startsOn,
    endsOn: s.endsOn,
    applyFrom: props.today,
  };
}

function startNew() {
  editingId.value = null;
  showForm.value = true;
  form.value = blank();
}

const refresh = () => {
  query.executeQuery({ requestPolicy: 'network-only' });
  emit('changed');
};

async function save() {
  error.value = null;
  notice.value = null;
  const f = form.value;
  const input = {
    teamId: f.teamId,
    weekdays: f.weekdays,
    startTime: f.startTime,
    durationMinutes: Number(f.durationMinutes),
    location: f.location.trim() || null,
    startsOn: f.startsOn || null,
    endsOn: f.endsOn || null,
  };
  if (editingId.value) {
    const res = await update.executeMutation({ id: editingId.value, input, fromDate: f.applyFrom });
    error.value = errorCode(res.error);
  } else {
    const res = await create.executeMutation({ input });
    error.value = errorCode(res.error);
    if (res.data) notice.value = t('calendar.seriesCreated', { n: res.data.createEventSeries.upcomingCount });
  }
  if (!error.value) {
    showForm.value = false;
    refresh();
  }
}

async function endSeries() {
  if (!editingId.value) return;
  const res = await end.executeMutation({ id: editingId.value, fromDate: endFrom.value });
  error.value = errorCode(res.error);
  if (!res.error) {
    showForm.value = false;
    refresh();
  }
}

const dayLabel = (n: number) => t(`calendar.days.${n}`);
</script>

<template>
  <HCard :title="$t('calendar.series')">
    <template #actions>
      <HButton size="sm" @click="startNew">{{ $t('calendar.newSeries') }}</HButton>
    </template>
    <ErrorAlert :code="error" />
    <HAlert v-if="notice" tone="success">{{ notice }}</HAlert>

    <form v-if="showForm" class="stack form" @submit.prevent="save">
      <HField v-slot="{ id }" :label="$t('calendar.team')">
        <HSelect :id="id" v-model="form.teamId" :disabled="!!editingId" :options="teams.filter((tm) => manageableTeamIds.includes(tm.id)).map((tm) => ({ value: tm.id, label: tm.name }))" />
      </HField>
      <fieldset class="days">
        <legend>{{ $t('calendar.weekdays') }}</legend>
        <label v-for="n in 7" :key="n" class="day">
          <input v-model="form.weekdays" type="checkbox" :value="n" />
          {{ dayLabel(n) }}
        </label>
      </fieldset>
      <div class="grid-2">
        <HField v-slot="{ id }" :label="$t('calendar.start')">
          <HInput :id="id" v-model="form.startTime" type="time" required />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.duration')">
          <HInput :id="id" v-model="form.durationMinutes" type="number" min="15" max="600" step="15" required />
        </HField>
      </div>
      <HField v-slot="{ id }" :label="$t('calendar.location')" optional>
        <HInput :id="id" v-model="form.location" />
      </HField>
      <div class="grid-2">
        <HField v-slot="{ id }" :label="$t('calendar.startsOn')" optional>
          <HInput :id="id" v-model="form.startsOn" type="date" />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.endsOn')" optional>
          <HInput :id="id" v-model="form.endsOn" type="date" />
        </HField>
      </div>
      <p class="muted small">{{ $t('calendar.seasonBounds') }}</p>
      <HField v-if="editingId" v-slot="{ id }" :label="$t('calendar.applyFrom')" :hint="$t('calendar.applyFromHint')">
        <HInput :id="id" v-model="form.applyFrom" type="date" :min="today" required />
      </HField>
      <div class="row">
        <HButton type="submit" :disabled="!form.weekdays.length" :loading="create.fetching.value || update.fetching.value">
          {{ $t('calendar.save') }}
        </HButton>
        <HButton variant="ghost" @click="showForm = false">{{ $t('common.cancel') }}</HButton>
      </div>
      <div v-if="editingId" class="row end">
        <HInput v-model="endFrom" type="date" :min="today" :aria-label="$t('calendar.endSeries')" class="end-date" />
        <HButton variant="danger" :loading="end.fetching.value" @click="endSeries">{{ $t('calendar.endSeries') }}</HButton>
      </div>
    </form>

    <p v-if="!series.length && !showForm" class="muted">{{ $t('calendar.noSeries') }}</p>
    <ul class="list">
      <li v-for="s in series" :key="s.id">
        <div>
          <strong>{{ s.teamName }}</strong>
          <span class="muted"> · {{ s.weekdays.map(dayLabel).join(', ') }} {{ s.startTime }} ({{ s.durationMinutes }}′)</span>
          <div class="muted small">
            {{ s.location ?? '' }} · {{ $t('calendar.upcoming', { n: s.upcomingCount }) }}
          </div>
        </div>
        <HButton size="sm" variant="ghost" @click="edit(s)">{{ $t('calendar.edit') }}</HButton>
      </li>
    </ul>
  </HCard>
</template>

<style scoped>
.form {
  border-bottom: 1px solid var(--border);
  padding-bottom: var(--space-4);
}
.days {
  border: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-2);
}
.days legend {
  font-size: var(--text-sm);
  font-weight: 600;
  margin-bottom: var(--space-2);
}
.day {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 10px;
  border: 1px solid var(--border-strong);
  border-radius: 999px;
  font-size: var(--text-sm);
  cursor: pointer;
}
.day:has(input:checked) {
  background: var(--primary-soft);
  border-color: var(--primary);
  color: var(--primary);
  font-weight: 600;
}
.day input {
  accent-color: var(--primary);
}
.end {
  border-top: 1px dashed var(--border);
  padding-top: var(--space-3);
}
.end-date {
  max-width: 180px;
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
.small {
  font-size: var(--text-xs);
}
</style>
