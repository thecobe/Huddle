<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { CancelRangeDoc } from '@/api/calendar';
import { ErrorAlert, HAlert, HButton, HCard, HField, HInput, HSelect } from '@/components/ui';

const props = defineProps<{ teams: { id: string; name: string }[]; manageableTeamIds: string[]; canManageClub: boolean; today: string }>();
const emit = defineEmits<{ changed: [] }>();
const { t } = useI18n();

const form = ref({ fromDate: props.today, toDate: props.today, teamId: props.canManageClub ? '' : (props.manageableTeamIds[0] ?? ''), reason: '' });
const mutation = useMutation(CancelRangeDoc);
const error = ref<string | null>(null);
const done = ref<string | null>(null);
const options = computed(() => [
  ...(props.canManageClub ? [{ value: '', label: t('calendar.allTeams') }] : []),
  ...props.teams.filter((tm) => props.manageableTeamIds.includes(tm.id)).map((tm) => ({ value: tm.id, label: tm.name })),
]);

async function submit() {
  done.value = null;
  const f = form.value;
  const res = await mutation.executeMutation({
    input: { fromDate: f.fromDate, toDate: f.toDate, teamId: f.teamId || null, reason: f.reason.trim() || null },
  });
  error.value = errorCode(res.error);
  if (res.data) {
    done.value = t('calendar.closureDone', { n: res.data.cancelEventsInRange });
    emit('changed');
  }
}
</script>

<template>
  <HCard :title="$t('calendar.closureTitle')" :description="$t('calendar.closureHint')">
    <form class="stack" @submit.prevent="submit">
      <div class="grid-2">
        <HField v-slot="{ id }" :label="$t('calendar.startsOn')">
          <HInput :id="id" v-model="form.fromDate" type="date" required />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.endsOn')">
          <HInput :id="id" v-model="form.toDate" type="date" :min="form.fromDate" required />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.team')">
          <HSelect :id="id" v-model="form.teamId" :options="options" />
        </HField>
        <HField v-slot="{ id }" :label="$t('calendar.cancelReason')" optional>
          <HInput :id="id" v-model="form.reason" />
        </HField>
      </div>
      <ErrorAlert :code="error" />
      <HAlert v-if="done" tone="success">{{ done }}</HAlert>
      <div class="row">
        <HButton type="submit" variant="danger" :loading="mutation.fetching.value">{{ $t('calendar.closure') }}</HButton>
      </div>
    </form>
  </HCard>
</template>
