<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { CreateEventDoc, DeleteEventDoc, SetEventCancelledDoc, UpdateEventDoc } from '@/api/calendar';
import { ErrorAlert, HAlert, HBadge, HButton, HField, HInput, HSelect } from '@/components/ui';
import type { EventFieldsFragment, EventKind } from '@/gql/graphql';
import { utcToZoned, zonedToUtc } from '@/lib/zoned';
import { eventLabel, mapsUrl } from './event-label';

const props = defineProps<{
  /** Evento esistente, oppure null per crearne uno nuovo. */
  event: EventFieldsFragment | null;
  timezone: string;
  teams: { id: string; name: string }[];
  /** Squadre gestibili; può creare eventi di società chi le gestisce tutte. */
  manageableTeamIds: string[];
  canManageClub: boolean;
  defaultDate: string;
}>();
const emit = defineEmits<{ close: []; changed: [] }>();
const { t, d } = useI18n();

const editing = ref(props.event === null);
const error = ref<string | null>(null);
const reason = ref('');

const blank = () => ({
  teamId: props.manageableTeamIds[0] ?? '',
  kind: 'TRAINING' as EventKind,
  title: '',
  date: props.defaultDate,
  start: '18:00',
  end: '19:30',
  location: '',
  notes: '',
  opponent: '',
  isHome: true,
  competition: '',
});
const form = ref(blank());

watch(
  () => props.event,
  (e) => {
    editing.value = e === null;
    error.value = null;
    if (!e) {
      form.value = blank();
      return;
    }
    const s = utcToZoned(e.startsAt, props.timezone);
    const end = utcToZoned(e.endsAt, props.timezone);
    form.value = {
      teamId: e.teamId ?? '',
      kind: e.kind,
      title: e.title ?? '',
      date: s.date,
      start: s.time,
      end: end.time,
      location: e.location ?? '',
      notes: e.notes ?? '',
      opponent: e.opponent ?? '',
      isHome: e.isHome ?? true,
      competition: e.competition ?? '',
    };
  },
  { immediate: true },
);

const teamOptions = computed(() => [
  ...(props.canManageClub ? [{ value: '', label: t('calendar.clubWide') }] : []),
  ...props.teams.filter((tm) => props.manageableTeamIds.includes(tm.id)).map((tm) => ({ value: tm.id, label: tm.name })),
]);

const create = useMutation(CreateEventDoc);
const update = useMutation(UpdateEventDoc);
const cancel = useMutation(SetEventCancelledDoc);
const remove = useMutation(DeleteEventDoc);

async function save() {
  error.value = null;
  const f = form.value;
  const startsAt = zonedToUtc(f.date, f.start, props.timezone);
  // Fine prima dell'inizio: l'evento termina il giorno dopo (es. trasferta serale).
  let endsAt = zonedToUtc(f.date, f.end, props.timezone);
  if (endsAt <= startsAt) endsAt = new Date(endsAt.getTime() + 86_400_000);
  const input = {
    teamId: f.teamId || null,
    kind: f.kind,
    title: f.title.trim() || null,
    startsAt: startsAt.toISOString(),
    endsAt: endsAt.toISOString(),
    location: f.location.trim() || null,
    notes: f.notes.trim() || null,
    opponent: f.kind === 'MATCH' ? f.opponent.trim() || null : null,
    isHome: f.kind === 'MATCH' ? f.isHome : null,
    competition: f.kind === 'MATCH' ? f.competition.trim() || null : null,
  };
  const res = props.event
    ? await update.executeMutation({ id: props.event.id, input })
    : await create.executeMutation({ input });
  error.value = errorCode(res.error);
  if (!res.error) {
    emit('changed');
    if (!props.event) emit('close');
    editing.value = false;
  }
}

async function toggleCancelled() {
  if (!props.event) return;
  const res = await cancel.executeMutation({
    id: props.event.id,
    cancelled: props.event.status !== 'CANCELLED',
    reason: reason.value.trim() || null,
  });
  error.value = errorCode(res.error);
  if (!res.error) emit('changed');
}

async function del() {
  if (!props.event) return;
  const res = await remove.executeMutation({ id: props.event.id });
  error.value = errorCode(res.error);
  if (!res.error) {
    emit('changed');
    emit('close');
  }
}

const when = computed(() => {
  const e = props.event;
  if (!e) return '';
  const opts = { timeZone: props.timezone } as const;
  return `${d(new Date(e.startsAt), { weekday: 'long', day: 'numeric', month: 'long', ...opts })} · ${d(new Date(e.startsAt), { hour: '2-digit', minute: '2-digit', ...opts })}–${d(new Date(e.endsAt), { hour: '2-digit', minute: '2-digit', ...opts })}`;
});
</script>

<template>
  <aside class="panel" role="dialog" :aria-label="event ? eventLabel(event, t) : $t('calendar.newEvent')">
    <header class="panel__head">
      <h2>{{ event ? eventLabel(event, t) : $t('calendar.newEvent') }}</h2>
      <button type="button" class="close" :aria-label="$t('calendar.close')" @click="emit('close')">×</button>
    </header>

    <ErrorAlert :code="error" />

    <div v-if="event && !editing" class="stack">
      <div class="row">
        <HBadge tone="brand">{{ $t(`calendar.kinds.${event.kind}`) }}</HBadge>
        <HBadge v-if="event.status === 'CANCELLED'" tone="warning">{{ $t('calendar.cancelled') }}</HBadge>
        <span class="muted">{{ event.teamName ?? $t('calendar.clubWide') }}</span>
      </div>
      <p class="when">{{ when }}</p>
      <p v-if="event.cancelReason" class="muted">{{ event.cancelReason }}</p>
      <p v-if="event.kind === 'MATCH'">
        {{ event.isHome ? $t('calendar.home') : $t('calendar.away') }}
        <template v-if="event.competition"> · {{ event.competition }}</template>
      </p>
      <p v-if="event.location">
        {{ event.location }} ·
        <a :href="mapsUrl(event.location)" target="_blank" rel="noopener">{{ $t('calendar.openMap') }}</a>
      </p>
      <p v-if="event.notes" class="notes">{{ event.notes }}</p>

      <template v-if="event.canEdit">
        <HAlert v-if="event.seriesId" tone="info">{{ $t('calendar.fromSeries') }}</HAlert>
        <div class="row">
          <HButton variant="secondary" @click="editing = true">{{ $t('calendar.edit') }}</HButton>
          <HButton v-if="!event.seriesId" variant="danger" :loading="remove.fetching.value" @click="del">{{ $t('calendar.delete') }}</HButton>
        </div>
        <div class="stack cancel-box">
          <HField v-if="event.status !== 'CANCELLED'" v-slot="{ id }" :label="$t('calendar.cancelReason')" optional>
            <HInput :id="id" v-model="reason" />
          </HField>
          <div class="row">
            <HButton :variant="event.status === 'CANCELLED' ? 'secondary' : 'danger'" :loading="cancel.fetching.value" @click="toggleCancelled">
              {{ event.status === 'CANCELLED' ? $t('calendar.restore') : $t('calendar.cancel') }}
            </HButton>
          </div>
        </div>
      </template>
    </div>

    <form v-else class="stack" @submit.prevent="save">
      <HField v-slot="{ id }" :label="$t('calendar.team')">
        <HSelect :id="id" v-model="form.teamId" :options="teamOptions" />
      </HField>
      <HField v-slot="{ id }" :label="$t('calendar.kind')">
        <HSelect :id="id" v-model="form.kind" :options="(['TRAINING', 'MATCH', 'OTHER'] as const).map((k) => ({ value: k, label: $t(`calendar.kinds.${k}`) }))" />
      </HField>
      <template v-if="form.kind === 'MATCH'">
        <HField v-slot="{ id }" :label="$t('calendar.opponent')">
          <HInput :id="id" v-model="form.opponent" required />
        </HField>
        <label class="check"><input v-model="form.isHome" type="checkbox" /> {{ $t('calendar.home') }}</label>
        <HField v-slot="{ id }" :label="$t('calendar.competition')" optional>
          <HInput :id="id" v-model="form.competition" />
        </HField>
      </template>
      <HField v-else v-slot="{ id }" :label="$t('calendar.titleField')" optional>
        <HInput :id="id" v-model="form.title" />
      </HField>
      <HField v-slot="{ id }" :label="$t('calendar.date')">
        <HInput :id="id" v-model="form.date" type="date" required />
      </HField>
      <div class="grid-2">
        <HField v-slot="{ id }" :label="$t('calendar.start')">
          <HInput :id="id" v-model="form.start" type="time" required />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.end')">
          <HInput :id="id" v-model="form.end" type="time" required />
        </HField>
      </div>
      <HField v-slot="{ id }" :label="$t('calendar.location')" optional>
        <HInput :id="id" v-model="form.location" />
      </HField>
      <HField v-slot="{ id }" :label="$t('calendar.notes')" optional>
        <textarea :id="id" v-model="form.notes" class="textarea" rows="3" />
      </HField>
      <div class="row">
        <HButton type="submit" :loading="create.fetching.value || update.fetching.value">{{ $t('calendar.save') }}</HButton>
        <HButton v-if="event" variant="ghost" @click="editing = false">{{ $t('common.cancel') }}</HButton>
      </div>
    </form>
  </aside>
</template>

<style scoped>
.panel {
  position: fixed;
  inset: 0 0 0 auto;
  width: min(420px, 100vw);
  background: var(--surface);
  border-left: 1px solid var(--border);
  box-shadow: var(--shadow);
  padding: var(--space-5);
  overflow-y: auto;
  z-index: 50;
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}
.panel__head {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--space-3);
}
.close {
  border: none;
  background: none;
  font-size: 1.6rem;
  line-height: 1;
  color: var(--text-muted);
  cursor: pointer;
}
.when {
  font-weight: 600;
  text-transform: capitalize;
}
.notes {
  white-space: pre-wrap;
}
.cancel-box {
  border-top: 1px solid var(--border);
  padding-top: var(--space-4);
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
.textarea {
  width: 100%;
  padding: var(--space-2) var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
  color: var(--text);
  font: inherit;
}
</style>
