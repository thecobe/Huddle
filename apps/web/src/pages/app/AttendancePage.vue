<script setup lang="ts">
import { useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { AttendanceRegisterDoc } from '@/api/attendance';
import { CalendarContextDoc } from '@/api/calendar';
import { errorCode } from '@/api/client';
import { eventLabel } from '@/components/calendar/event-label';
import { ErrorAlert, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import type { AttendanceStatus, EventKind } from '@/gql/graphql';
import { addDays, utcToZoned, zonedToUtc } from '@/lib/zoned';

const { t, d } = useI18n();
const context = useQuery({ query: CalendarContextDoc });
const timezone = computed(() => context.data.value?.club.timezone ?? 'Europe/Rome');
// Squadre di cui si vede il registro: le stesse di cui si gestisce il calendario.
const teams = computed(() => (context.data.value?.teams ?? []).filter((tm) => context.data.value?.manageableTeamIds.includes(tm.id)));

const today = utcToZoned(new Date(), 'Europe/Rome').date;
const teamId = ref('');
const from = ref(addDays(today, -30));
const to = ref(today);
const kind = ref<'' | EventKind>('');
watch(teams, (list) => {
  if (!teamId.value && list.length) teamId.value = list[0]!.id;
}, { immediate: true });

const variables = computed(() => ({
  teamId: teamId.value,
  from: zonedToUtc(from.value, '00:00', timezone.value).toISOString(),
  to: zonedToUtc(addDays(to.value, 1), '00:00', timezone.value).toISOString(),
  kind: kind.value || null,
}));
const query = useQuery({ query: AttendanceRegisterDoc, variables, pause: computed(() => !teamId.value || from.value > to.value) });
const register = computed(() => query.data.value?.attendanceRegister);
const cell = computed(() => {
  const map = new Map<string, { status: AttendanceStatus; note: string | null }>();
  for (const c of register.value?.cells ?? []) map.set(`${c.eventId}|${c.personId}`, c);
  return map;
});

const day = (iso: string) => d(new Date(iso), { day: '2-digit', month: '2-digit', timeZone: timezone.value });
const tone = (s: AttendanceStatus) => (s === 'PRESENT' || s === 'LATE' ? 'ok' : s === 'ABSENT' ? 'ko' : 'neutral');

function exportCsv() {
  const r = register.value;
  if (!r) return;
  const esc = (v: string | number | null) => `"${String(v ?? '').replace(/"/g, '""')}"`;
  const head = [t('attendance.athlete'), ...r.events.map((e) => `${utcToZoned(e.startsAt, timezone.value).date} ${eventLabel(e, t)}`), t('attendance.rate')];
  const rows = r.players.map((p) => [
    `${p.lastName} ${p.firstName}`,
    ...r.events.map((e) => {
      const c = cell.value.get(`${e.id}|${p.personId}`);
      return c ? t(`attendance.statuses.${c.status}`) : '';
    }),
    p.percentage === null ? '' : `${p.percentage}%`,
  ]);
  // Punto e virgola e BOM: Excel in italiano apre il file correttamente.
  const csv = '﻿' + [head, ...rows].map((row) => row.map(esc).join(';')).join('\r\n');
  const a = document.createElement('a');
  a.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv;charset=utf-8' }));
  const team = teams.value.find((tm) => tm.id === teamId.value)?.name ?? 'squadra';
  a.download = `presenze-${team.replace(/\s+/g, '-').toLowerCase()}-${from.value}-${to.value}.csv`;
  a.click();
  URL.revokeObjectURL(a.href);
}
</script>

<template>
  <div>
    <PageHeader :title="$t('attendance.title')" :subtitle="$t('attendance.subtitle')">
      <HButton variant="secondary" :disabled="!register?.events.length" @click="exportCsv">{{ $t('attendance.export') }}</HButton>
    </PageHeader>

    <div class="stack">
      <p v-if="context.data.value && !teams.length" class="muted">{{ $t('attendance.noTeams') }}</p>
      <div v-else class="filters">
        <HField v-slot="{ id }" :label="$t('attendance.team')">
          <HSelect :id="id" v-model="teamId" :options="teams.map((tm) => ({ value: tm.id, label: tm.name }))" />
        </HField>
        <HField v-slot="{ id }" :label="$t('attendance.from')">
          <HInput :id="id" v-model="from" type="date" />
        </HField>
        <HField v-slot="{ id }" :label="$t('attendance.to')">
          <HInput :id="id" v-model="to" type="date" />
        </HField>
        <HField v-slot="{ id }" :label="$t('attendance.kind')">
          <HSelect :id="id" v-model="kind" :options="[{ value: '', label: $t('attendance.allKinds') }, ...(['TRAINING', 'MATCH', 'OTHER'] as const).map((k) => ({ value: k, label: $t(`calendar.kinds.${k}`) }))]" />
        </HField>
      </div>

      <ErrorAlert :code="errorCode(context.error.value) ?? errorCode(query.error.value)" />

      <HCard v-if="register" :padded="false">
        <p v-if="!register.events.length" class="muted empty">{{ $t('attendance.noEvents') }}</p>
        <div v-else class="table-wrap">
          <table class="data register">
            <thead>
              <tr>
                <th class="sticky">{{ $t('attendance.athlete') }}</th>
                <th
                  v-for="e in register.events"
                  :key="e.id"
                  class="ev"
                  :class="{ missing: !e.rollCallDone }"
                  :title="`${eventLabel(e, t)}${e.rollCallDone ? '' : ' · ' + $t('attendance.missingRollCall')}`"
                >
                  {{ day(e.startsAt) }}
                  <span class="kind">{{ e.kind === 'MATCH' ? '★' : '' }}</span>
                </th>
                <th class="num">{{ $t('attendance.rate') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="p in register.players" :key="p.personId">
                <td class="sticky">
                  <span class="jersey">{{ p.jerseyNumber ?? '' }}</span>
                  {{ p.lastName }} {{ p.firstName }}
                </td>
                <td v-for="e in register.events" :key="e.id" class="cell">
                  <template v-if="cell.get(`${e.id}|${p.personId}`)">
                    <span
                      class="mark"
                      :class="tone(cell.get(`${e.id}|${p.personId}`)!.status)"
                      :title="[$t(`attendance.statuses.${cell.get(`${e.id}|${p.personId}`)!.status}`), cell.get(`${e.id}|${p.personId}`)!.note].filter(Boolean).join(' · ')"
                    >
                      {{ $t(`attendance.short.${cell.get(`${e.id}|${p.personId}`)!.status}`) }}
                    </span>
                  </template>
                </td>
                <td class="num">
                  <strong v-if="p.percentage !== null">{{ p.percentage }}%</strong>
                  <span class="muted small"> {{ p.attended }}/{{ p.recorded }}</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <p class="muted small legend">{{ $t('attendance.legend') }} · ★ {{ $t('calendar.kinds.MATCH') }}</p>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
.filters {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: var(--space-3);
}
.empty {
  padding: var(--space-5);
}
.register th.ev {
  text-align: center;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
  padding: var(--space-2) 4px;
}
.register th.ev.missing {
  color: var(--warning);
  background: var(--warning-soft);
}
.kind {
  color: var(--primary);
}
.sticky {
  position: sticky;
  left: 0;
  background: var(--surface);
  z-index: 1;
  white-space: nowrap;
}
.jersey {
  display: inline-block;
  min-width: 22px;
  color: var(--text-subtle);
  font-variant-numeric: tabular-nums;
}
.cell {
  text-align: center;
  padding: 4px;
}
.mark {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 6px;
  font-size: var(--text-xs);
  font-weight: 700;
}
.mark.ok {
  background: var(--success-soft);
  color: var(--success);
}
.mark.ko {
  background: var(--danger-soft);
  color: var(--danger);
}
.mark.neutral {
  background: var(--surface-muted);
  color: var(--text-muted);
}
.num {
  text-align: right;
  white-space: nowrap;
}
.small {
  font-size: var(--text-xs);
}
.legend {
  padding: var(--space-3) var(--space-5);
}
@media (max-width: 860px) {
  .filters {
    grid-template-columns: 1fr 1fr;
  }
}
</style>
