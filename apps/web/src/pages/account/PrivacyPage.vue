<script setup lang="ts">
import { useClientHandle, useMutation, useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { MyConsentsDoc, MyDataExportDoc, RecordConsentDoc } from '@/api/operations';
import { ErrorAlert, HBadge, HButton, HCard, PageHeader } from '@/components/ui';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const { d } = useI18n();
const handle = useClientHandle();
const consents = useQuery({ query: MyConsentsDoc, requestPolicy: 'network-only' });
const record = useMutation(RecordConsentDoc);
const error = ref<string | null>(null);
const exporting = ref(false);

const platform = computed(() => (consents.data.value?.myConsents ?? []).filter((c) => !c.clubId));
const imageRelease = computed(() =>
  consents.data.value?.myConsents.find((c) => c.kind === 'IMAGE_RELEASE' && c.clubId === session.clubId),
);

async function setImageRelease(granted: boolean) {
  const res = await record.executeMutation({ kind: 'IMAGE_RELEASE', granted });
  error.value = errorCode(res.error);
  consents.executeQuery({ requestPolicy: 'network-only' });
}

async function downloadExport() {
  exporting.value = true;
  try {
    const res = await handle.client.query(MyDataExportDoc, {}, { requestPolicy: 'network-only' }).toPromise();
    error.value = errorCode(res.error);
    if (!res.data) return;
    const blob = new Blob([JSON.stringify(res.data.myDataExport, null, 2)], { type: 'application/json' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `huddle-dati-${new Date().toISOString().slice(0, 10)}.json`;
    a.click();
    URL.revokeObjectURL(a.href);
  } finally {
    exporting.value = false;
  }
}

const fmt = (iso: string) => d(new Date(iso), { day: 'numeric', month: 'short', year: 'numeric' });
</script>

<template>
  <div>
    <PageHeader :title="$t('privacy.title')" />
    <div class="stack">
      <ErrorAlert :code="error" />

      <HCard :title="$t('privacy.consents')">
        <ul class="list">
          <li v-for="c in platform" :key="c.kind">
            <div>
              <strong>{{ $t(`privacy.kinds.${c.kind}`) }}</strong>
              <div class="muted small">{{ $t('privacy.version', { v: c.version }) }} · {{ fmt(c.recordedAt) }}</div>
            </div>
            <HBadge :tone="c.granted ? 'success' : 'neutral'">{{ c.granted ? $t('privacy.granted') : $t('privacy.denied') }}</HBadge>
          </li>
          <li v-if="session.currentClub">
            <div>
              <strong>{{ $t('privacy.imageRelease') }}</strong>
              <div class="muted small">{{ session.currentClub.name }} — {{ $t('privacy.imageReleaseHint') }}</div>
            </div>
            <div class="row">
              <HBadge :tone="imageRelease?.granted ? 'success' : 'neutral'">
                {{ imageRelease?.granted ? $t('privacy.granted') : $t('privacy.denied') }}
              </HBadge>
              <HButton size="sm" variant="secondary" :loading="record.fetching.value" @click="setImageRelease(!imageRelease?.granted)">
                {{ imageRelease?.granted ? $t('privacy.deny') : $t('privacy.grant') }}
              </HButton>
            </div>
          </li>
        </ul>
      </HCard>

      <HCard :title="$t('privacy.export')" :description="$t('privacy.exportHint')">
        <div class="row">
          <HButton variant="secondary" :loading="exporting" @click="downloadExport">{{ $t('privacy.export') }}</HButton>
        </div>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
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
  flex-wrap: wrap;
  padding: var(--space-3) 0;
  border-bottom: 1px solid var(--border);
}
.list li:last-child {
  border-bottom: none;
}
.small {
  font-size: var(--text-xs);
}
</style>
