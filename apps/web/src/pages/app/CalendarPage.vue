<script setup lang="ts">
import { useQuery } from '@urql/vue';
import { computed, onMounted, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { CalendarContextDoc, CalendarDoc } from '@/api/calendar';
import { errorCode } from '@/api/client';
import ClosurePanel from '@/components/calendar/ClosurePanel.vue';
import { eventLabel } from '@/components/calendar/event-label';
import EventPanel from '@/components/calendar/EventPanel.vue';
import FeedPanel from '@/components/calendar/FeedPanel.vue';
import SeriesPanel from '@/components/calendar/SeriesPanel.vue';
import { ErrorAlert, HButton, HSelect, PageHeader } from '@/components/ui';
import type { EventFieldsFragment } from '@/gql/graphql';
import { addDays, utcToZoned, zonedToUtc } from '@/lib/zoned';
import { useSessionStore } from '@/stores/session';

const MAX_PER_DAY = 3;

const { t, d } = useI18n();
const session = useSessionStore();
const context = useQuery({ query: CalendarContextDoc });
const timezone = computed(() => context.data.value?.club.timezone ?? 'Europe/Rome');
const today = computed(() => utcToZoned(new Date(), timezone.value).date);
const teams = computed(() => context.data.value?.teams ?? []);
const manageable = computed(() => context.data.value?.manageableTeamIds ?? []);
const canManageClub = computed(() => session.allowed('team.manage'));

// Mese mostrato (primo giorno, YYYY-MM-01) e vista: griglia su schermi larghi, elenco su smartphone.
const month = ref(today.value.slice(0, 8) + '01');
watch(today, (v) => (month.value = v.slice(0, 8) + '01'), { once: true });
const view = ref<'month' | 'list'>('month');
onMounted(() => {
  if (window.matchMedia('(max-width: 860px)').matches) view.value = 'list';
});
const teamId = ref('');
const panel = ref<'series' | 'closure' | 'feed' | null>(null);

// Griglia da lunedì a domenica che copre l'intero mese.
const grid = computed(() => {
  const first = new Date(`${month.value}T00:00:00Z`);
  const weekday = (first.getUTCDay() + 6) % 7;
  const start = addDays(month.value, -weekday);
  const lastOfMonth = addDays(addDays(month.value, 32).slice(0, 8) + '01', -1);
  const days: string[] = [];
  for (let day = start; day <= lastOfMonth || days.length % 7 !== 0; day = addDays(day, 1)) days.push(day);
  return days;
});

const variables = computed(() => ({
  from: zonedToUtc(grid.value[0]!, '00:00', timezone.value).toISOString(),
  to: zonedToUtc(addDays(grid.value.at(-1)!, 1), '00:00', timezone.value).toISOString(),
  teamId: teamId.value || null,
}));
const query = useQuery({ query: CalendarDoc, variables, pause: computed(() => !context.data.value) });
const events = computed(() => query.data.value?.events ?? []);
const byDay = computed(() => {
  const map = new Map<string, EventFieldsFragment[]>();
  for (const e of events.value) {
    const day = utcToZoned(e.startsAt, timezone.value).date;
    map.set(day, [...(map.get(day) ?? []), e]);
  }
  return map;
});
const listDays = computed(() => grid.value.filter((day) => day.startsWith(month.value.slice(0, 8)) && byDay.value.has(day)));

const selected = ref<EventFieldsFragment | null>(null);
const creating = ref<string | null>(null);
function open(e: EventFieldsFragment) {
  creating.value = null;
  selected.value = e;
}
function create(day: string) {
  selected.value = null;
  creating.value = day;
}
function closePanel() {
  selected.value = null;
  creating.value = null;
}
function refresh() {
  query.executeQuery({ requestPolicy: 'network-only' });
}
// Dopo una modifica il pannello mostra la versione aggiornata dell'evento.
watch(events, (list) => {
  if (selected.value) selected.value = list.find((e) => e.id === selected.value!.id) ?? null;
});

const monthTitle = computed(() => d(new Date(`${month.value}T12:00:00Z`), { month: 'long', year: 'numeric', timeZone: 'UTC' }));
const time = (iso: string) => utcToZoned(iso, timezone.value).time;
const dayTitle = (day: string) => d(new Date(`${day}T12:00:00Z`), { weekday: 'long', day: 'numeric', month: 'long', timeZone: 'UTC' });
function shiftMonth(delta: number) {
  const [y, m] = month.value.split('-').map(Number) as [number, number];
  const next = new Date(Date.UTC(y, m - 1 + delta, 1));
  month.value = next.toISOString().slice(0, 10);
}
const canCreate = computed(() => manageable.value.length > 0 || canManageClub.value);
</script>

<template>
  <div>
    <PageHeader :title="$t('calendar.title')" :subtitle="$t('calendar.subtitle')">
      <HSelect
        v-model="teamId"
        class="team-filter"
        :aria-label="$t('calendar.team')"
        :options="[{ value: '', label: $t('calendar.allTeams') }, ...teams.map((tm) => ({ value: tm.id, label: tm.name }))]"
      />
      <HButton v-if="manageable.length" variant="secondary" @click="panel = panel === 'series' ? null : 'series'">{{ $t('calendar.series') }}</HButton>
      <HButton v-if="manageable.length" variant="secondary" @click="panel = panel === 'closure' ? null : 'closure'">{{ $t('calendar.closure') }}</HButton>
      <HButton variant="secondary" @click="panel = panel === 'feed' ? null : 'feed'">{{ $t('calendar.subscribe') }}</HButton>
      <HButton v-if="canCreate" @click="create(today)">{{ $t('calendar.newEvent') }}</HButton>
    </PageHeader>

    <div class="stack">
      <ErrorAlert :code="errorCode(context.error.value) ?? errorCode(query.error.value)" />
      <SeriesPanel v-if="panel === 'series'" :teams="teams" :manageable-team-ids="manageable" :today="today" @changed="refresh" />
      <ClosurePanel
        v-if="panel === 'closure'"
        :teams="teams"
        :manageable-team-ids="manageable"
        :can-manage-club="canManageClub"
        :today="today"
        @changed="refresh"
      />
      <FeedPanel v-if="panel === 'feed'" :teams="teams" />

      <div class="toolbar">
        <div class="row">
          <HButton size="sm" variant="secondary" :aria-label="$t('calendar.prev')" @click="shiftMonth(-1)">‹</HButton>
          <h2 class="month">{{ monthTitle }}</h2>
          <HButton size="sm" variant="secondary" :aria-label="$t('calendar.next')" @click="shiftMonth(1)">›</HButton>
          <HButton size="sm" variant="ghost" @click="month = today.slice(0, 8) + '01'">{{ $t('calendar.today') }}</HButton>
        </div>
        <div class="segmented" role="group">
          <button type="button" :aria-pressed="view === 'month'" @click="view = 'month'">{{ $t('calendar.month') }}</button>
          <button type="button" :aria-pressed="view === 'list'" @click="view = 'list'">{{ $t('calendar.list') }}</button>
        </div>
      </div>

      <div v-if="view === 'month'" class="grid" role="grid">
        <div v-for="n in 7" :key="`h${n}`" class="grid__head" role="columnheader">{{ $t(`calendar.days.${n}`) }}</div>
        <div
          v-for="day in grid"
          :key="day"
          class="cell"
          role="gridcell"
          :class="{ other: !day.startsWith(month.slice(0, 8)), today: day === today }"
        >
          <button v-if="canCreate" type="button" class="cell__day" :aria-label="`${$t('calendar.newEvent')} ${day}`" @click="create(day)">
            {{ Number(day.slice(8)) }}
          </button>
          <span v-else class="cell__day">{{ Number(day.slice(8)) }}</span>
          <button
            v-for="e in (byDay.get(day) ?? []).slice(0, MAX_PER_DAY)"
            :key="e.id"
            type="button"
            class="chip"
            :class="{ cancelled: e.status === 'CANCELLED', match: e.kind === 'MATCH' }"
            :style="{ '--team': e.teamColor ?? 'var(--primary)' }"
            @click="open(e)"
          >
            <span class="chip__time">{{ time(e.startsAt) }}</span> {{ eventLabel(e, t) }}
            <span v-if="!teamId && e.teamName" class="chip__team">{{ e.teamName }}</span>
          </button>
          <span v-if="(byDay.get(day)?.length ?? 0) > MAX_PER_DAY" class="more">
            {{ $t('calendar.more', { n: byDay.get(day)!.length - MAX_PER_DAY }) }}
          </span>
        </div>
      </div>

      <div v-else class="agenda">
        <p v-if="!listDays.length && query.data.value" class="muted">{{ $t('calendar.empty') }}</p>
        <section v-for="day in listDays" :key="day" class="agenda__day">
          <h3 :class="{ today: day === today }">{{ dayTitle(day) }}</h3>
          <button
            v-for="e in byDay.get(day)"
            :key="e.id"
            type="button"
            class="item"
            :class="{ cancelled: e.status === 'CANCELLED' }"
            :style="{ '--team': e.teamColor ?? 'var(--primary)' }"
            @click="open(e)"
          >
            <span class="item__time">{{ time(e.startsAt) }}–{{ time(e.endsAt) }}</span>
            <span class="item__body">
              <strong>{{ eventLabel(e, t) }}</strong>
              <span class="muted">{{ e.teamName ?? $t('calendar.clubWide') }}<template v-if="e.location"> · {{ e.location }}</template></span>
            </span>
            <span v-if="e.status === 'CANCELLED'" class="item__tag">{{ $t('calendar.cancelled') }}</span>
          </button>
        </section>
      </div>
    </div>

    <EventPanel
      v-if="selected || creating"
      :event="selected"
      :timezone="timezone"
      :teams="teams"
      :manageable-team-ids="manageable"
      :can-manage-club="canManageClub"
      :default-date="creating ?? today"
      @close="closePanel"
      @changed="refresh"
    />
  </div>
</template>

<style scoped>
.team-filter {
  min-width: 180px;
}
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: var(--space-3);
  flex-wrap: wrap;
}
.month {
  min-width: 170px;
  text-align: center;
  text-transform: capitalize;
}
.segmented {
  display: inline-flex;
  background: var(--surface-muted);
  border-radius: var(--radius);
  padding: 3px;
}
.segmented button {
  border: none;
  background: none;
  font: inherit;
  font-size: var(--text-sm);
  font-weight: 600;
  padding: 6px 12px;
  border-radius: var(--radius-sm);
  color: var(--text-muted);
  cursor: pointer;
}
.segmented button[aria-pressed='true'] {
  background: var(--surface);
  color: var(--text);
  box-shadow: var(--shadow-sm);
}
.grid {
  display: grid;
  grid-template-columns: repeat(7, minmax(0, 1fr));
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  overflow: hidden;
  background: var(--border);
  gap: 1px;
}
.grid__head {
  background: var(--surface-muted);
  padding: var(--space-2);
  font-size: var(--text-xs);
  font-weight: 600;
  text-transform: uppercase;
  color: var(--text-muted);
  text-align: center;
}
.cell {
  background: var(--surface);
  min-height: 104px;
  padding: var(--space-1);
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}
.cell.other {
  background: var(--surface-muted);
}
.cell.other .cell__day {
  color: var(--text-subtle);
}
.cell__day {
  align-self: flex-end;
  border: none;
  background: none;
  font: inherit;
  font-size: var(--text-xs);
  font-weight: 600;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  color: var(--text-muted);
  cursor: pointer;
}
button.cell__day:hover {
  background: var(--surface-muted);
}
.cell.today .cell__day {
  background: var(--primary);
  color: var(--primary-text);
}
.chip {
  display: block;
  width: 100%;
  text-align: left;
  border: none;
  border-left: 3px solid var(--team);
  background: color-mix(in srgb, var(--team) 12%, var(--surface));
  color: var(--text);
  font: inherit;
  font-size: 0.72rem;
  line-height: 1.3;
  padding: 2px 4px;
  border-radius: 4px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  cursor: pointer;
}
.chip.match {
  font-weight: 700;
}
.chip__time {
  font-variant-numeric: tabular-nums;
  color: var(--text-muted);
}
.chip__team {
  color: var(--text-muted);
}
.cancelled {
  text-decoration: line-through;
  opacity: 0.6;
}
.more {
  font-size: 0.7rem;
  color: var(--text-muted);
  padding-left: 4px;
}
.agenda {
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}
.agenda__day h3 {
  font-size: var(--text-sm);
  text-transform: capitalize;
  color: var(--text-muted);
  margin-bottom: var(--space-2);
}
.agenda__day h3.today {
  color: var(--primary);
}
.item {
  width: 100%;
  display: flex;
  align-items: center;
  gap: var(--space-3);
  text-align: left;
  padding: var(--space-3);
  margin-bottom: var(--space-2);
  background: var(--surface);
  border: 1px solid var(--border);
  border-left: 4px solid var(--team);
  border-radius: var(--radius);
  color: var(--text);
  font: inherit;
  cursor: pointer;
}
.item__time {
  font-variant-numeric: tabular-nums;
  font-size: var(--text-sm);
  font-weight: 600;
  min-width: 92px;
}
.item__body {
  display: flex;
  flex-direction: column;
  min-width: 0;
  flex: 1;
}
.item__body .muted {
  font-size: var(--text-xs);
}
.item__tag {
  font-size: var(--text-xs);
  color: var(--warning);
  font-weight: 600;
  text-decoration: none;
}
</style>
