<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { errorCode } from '@/api/client';
import { UpdateMeDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import { type Locale, setLocale } from '@/i18n';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const form = ref({ fullName: session.user?.fullName ?? '', locale: session.user?.locale ?? 'it' });
const error = ref<string | null>(null);
const saved = ref(false);
const update = useMutation(UpdateMeDoc);

async function submit() {
  saved.value = false;
  const res = await update.executeMutation({ input: form.value });
  error.value = errorCode(res.error);
  if (!res.data) return;
  session.setUser(res.data.updateMe);
  setLocale(form.value.locale as Locale);
  saved.value = true;
}
</script>

<template>
  <div>
    <PageHeader :title="$t('profile.title')" />
    <HCard>
      <form class="stack" @submit.prevent="submit">
        <div class="grid-2">
          <HField v-slot="{ id }" :label="$t('common.fullName')">
            <HInput :id="id" v-model="form.fullName" required minlength="2" />
          </HField>
          <HField v-slot="{ id }" :label="$t('common.email')">
            <HInput :id="id" :model-value="session.user?.email" disabled />
          </HField>
          <HField v-slot="{ id }" :label="$t('common.language')">
            <HSelect :id="id" v-model="form.locale" :options="[{ value: 'it', label: 'Italiano' }, { value: 'en', label: 'English' }]" />
          </HField>
        </div>
        <ErrorAlert :code="error" />
        <HAlert v-if="saved" tone="success">{{ $t('common.saved') }}</HAlert>
        <div class="row"><HButton type="submit" :loading="update.fetching.value">{{ $t('common.save') }}</HButton></div>
      </form>
    </HCard>
  </div>
</template>
