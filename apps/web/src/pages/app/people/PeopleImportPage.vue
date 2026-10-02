<script setup lang="ts">
import { useMutation } from '@urql/vue';
import Papa from 'papaparse';
import { readSheet } from 'read-excel-file/browser';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { CommitPeopleImportDoc, PreviewPeopleImportDoc } from '@/api/people';
import { ErrorAlert, HAlert, HBadge, HButton, HCard, HSelect, PageHeader } from '@/components/ui';
import type { PersonImportRow, PreviewPeopleImportMutation } from '@/gql/graphql';
import { autoMap, buildRows, IMPORT_FIELDS, type ImportField } from './import-mapping';

const { t } = useI18n();

const fileName = ref('');
const headers = ref<string[]>([]);
const data = ref<unknown[][]>([]);
const mapping = ref<(ImportField | '')[]>([]);
const rows = ref<PersonImportRow[]>([]);
const results = ref<PreviewPeopleImportMutation['previewPeopleImport']>([]);
const readError = ref(false);
const error = ref<string | null>(null);
const done = ref<string | null>(null);

const preview = useMutation(PreviewPeopleImportDoc);
const commit = useMutation(CommitPeopleImportDoc);

async function onFile(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0];
  reset();
  if (!file) return;
  fileName.value = file.name;
  try {
    const sheet = file.name.toLowerCase().endsWith('.csv') ? await readCsv(file) : await readSheet(file);
    const [head, ...body] = sheet as unknown[][];
    headers.value = (head ?? []).map((h) => String(h ?? '').trim());
    data.value = body;
    mapping.value = autoMap(headers.value);
  } catch {
    readError.value = true;
  }
}

function readCsv(file: File): Promise<unknown[][]> {
  return new Promise((resolve, reject) =>
    Papa.parse<string[]>(file, {
      skipEmptyLines: true,
      // Molti CSV italiani usano il punto e virgola: lasciamo che papaparse lo riconosca.
      delimiter: '',
      complete: (r) => resolve(r.data),
      error: reject,
    }),
  );
}

function reset() {
  headers.value = [];
  data.value = [];
  mapping.value = [];
  rows.value = [];
  results.value = [];
  readError.value = false;
  error.value = null;
  done.value = null;
}

const fieldOptions = computed(() => [
  { value: '', label: t('import.ignore') },
  ...IMPORT_FIELDS.map((f) => ({ value: f, label: t(`import.fields.${f}`) })),
]);

async function check() {
  error.value = null;
  done.value = null;
  rows.value = buildRows(data.value, mapping.value);
  const res = await preview.executeMutation({ rows: rows.value });
  error.value = errorCode(res.error);
  results.value = res.data?.previewPeopleImport ?? [];
}

const counts = computed(() => ({
  create: results.value.filter((r) => r.status === 'CREATE').length,
  update: results.value.filter((r) => r.status === 'UPDATE').length,
  errors: results.value.filter((r) => r.status === 'ERROR').length,
}));

async function runImport() {
  const res = await commit.executeMutation({ rows: rows.value });
  error.value = errorCode(res.error);
  const s = res.data?.commitPeopleImport;
  if (!s) return;
  done.value = t('import.done', { created: s.created, updated: s.updated, guardians: s.guardiansLinked, teams: s.addedToTeams });
  results.value = [];
  headers.value = [];
}

function rowLabel(index: number) {
  const r = rows.value[index];
  return r ? [r.lastName, r.firstName].filter(Boolean).join(' ') || '—' : '—';
}
const tone = (s: string) => (s === 'ERROR' ? 'warning' : s === 'UPDATE' ? 'neutral' : 'success');
</script>

<template>
  <div>
    <RouterLink :to="{ name: 'people' }" class="back">← {{ $t('people.title') }}</RouterLink>
    <PageHeader :title="$t('import.title')" :subtitle="$t('import.subtitle')" />

    <div class="stack">
      <HAlert v-if="done" tone="success">{{ done }}</HAlert>
      <ErrorAlert :code="error" />

      <HCard :title="$t('import.step1')">
        <input type="file" accept=".xlsx,.csv,text/csv" :aria-label="$t('import.file')" @change="onFile" />
        <HAlert v-if="readError" tone="error">{{ $t('import.unreadable') }}</HAlert>
        <p v-if="headers.length" class="muted">{{ fileName }} · {{ $t('import.sheetRows', { n: data.length }) }}</p>
      </HCard>

      <HCard v-if="headers.length" :title="$t('import.step2')" :description="$t('import.mappingHint')">
        <div class="table-wrap">
          <table class="data">
            <thead>
              <tr>
                <th>{{ $t('import.column') }}</th>
                <th>{{ $t('import.field') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(h, i) in headers" :key="i">
                <td>
                  <strong>{{ h || '—' }}</strong>
                  <div class="muted small">{{ data.slice(0, 2).map((r) => r[i]).filter(Boolean).join(' · ') }}</div>
                </td>
                <td><HSelect v-model="mapping[i]" :aria-label="h" :options="fieldOptions" /></td>
              </tr>
            </tbody>
          </table>
        </div>
        <p class="muted small">{{ $t('import.openSeasonHint') }}</p>
        <div class="row">
          <HButton :loading="preview.fetching.value" @click="check">{{ $t('import.check') }}</HButton>
        </div>
      </HCard>

      <HCard v-if="results.length" :title="$t('import.step3')">
        <div class="row">
          <HBadge tone="success">{{ $t('import.toCreate') }}: {{ counts.create }}</HBadge>
          <HBadge>{{ $t('import.toUpdate') }}: {{ counts.update }}</HBadge>
          <HBadge :tone="counts.errors ? 'warning' : 'neutral'">{{ $t('import.withErrors') }}: {{ counts.errors }}</HBadge>
        </div>
        <HAlert v-if="counts.errors" tone="warning">{{ $t('import.fixFile') }}</HAlert>
        <div class="table-wrap results">
          <table class="data">
            <thead>
              <tr>
                <th>{{ $t('import.row') }}</th>
                <th>{{ $t('common.fullName') }}</th>
                <th>{{ $t('import.status') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="r in results" :key="r.index">
                <td>{{ r.index + 2 }}</td>
                <td>{{ rowLabel(r.index) }}</td>
                <td>
                  <HBadge :tone="tone(r.status)">{{ $t(`import.statuses.${r.status}`) }}</HBadge>
                  <span v-for="e in r.errors" :key="e" class="err">{{ $t(`import.errors.${e}`) }}</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="row">
          <HButton :disabled="counts.errors > 0" :loading="commit.fetching.value" @click="runImport">
            {{ $t('import.commit', { n: results.length }) }}
          </HButton>
        </div>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
.back {
  display: inline-block;
  margin-bottom: var(--space-3);
  font-size: var(--text-sm);
}
.small {
  font-size: var(--text-xs);
}
.results {
  max-height: 420px;
  overflow-y: auto;
}
.err {
  display: block;
  color: var(--danger);
  font-size: var(--text-xs);
  margin-top: 2px;
}
</style>
