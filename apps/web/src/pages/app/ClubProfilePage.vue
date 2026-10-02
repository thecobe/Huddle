<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { errorCode } from '@/api/client';
import { ClubDoc, UpdateClubDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import type { ClubFieldsFragment } from '@/gql/graphql';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const canEdit = computed(() => session.allowed('club.manage'));
const query = useQuery({ query: ClubDoc });
const update = useMutation(UpdateClubDoc);

const form = ref({
  name: '',
  legalName: '',
  taxCode: '',
  vatNumber: '',
  sport: 'FOOTBALL',
  email: '',
  phone: '',
  addressLine: '',
  city: '',
  province: '',
  postalCode: '',
  federations: '',
});
const error = ref<string | null>(null);
const saved = ref(false);
const sports = ['FOOTBALL', 'FUTSAL', 'VOLLEYBALL', 'BASKETBALL', 'RUGBY', 'OTHER'];

watch(
  () => query.data.value?.club,
  (club?: ClubFieldsFragment) => {
    if (!club) return;
    form.value = {
      name: club.name,
      legalName: club.legalName ?? '',
      taxCode: club.taxCode ?? '',
      vatNumber: club.vatNumber ?? '',
      sport: club.sport,
      email: club.email ?? '',
      phone: club.phone ?? '',
      addressLine: club.addressLine ?? '',
      city: club.city ?? '',
      province: club.province ?? '',
      postalCode: club.postalCode ?? '',
      federations: club.federations.join(', '),
    };
  },
  { immediate: true },
);

const orNull = (v: string) => v.trim() || null;

async function submit() {
  error.value = null;
  saved.value = false;
  const f = form.value;
  const res = await update.executeMutation({
    input: {
      name: f.name,
      sport: f.sport,
      legalName: orNull(f.legalName),
      taxCode: orNull(f.taxCode),
      vatNumber: orNull(f.vatNumber),
      email: orNull(f.email),
      phone: orNull(f.phone),
      addressLine: orNull(f.addressLine),
      city: orNull(f.city),
      province: orNull(f.province),
      postalCode: orNull(f.postalCode),
      federations: f.federations.split(',').map((s) => s.trim()).filter(Boolean),
    },
  });
  error.value = errorCode(res.error);
  saved.value = !res.error;
  if (res.data) await session.reloadUser();
}
</script>

<template>
  <div>
    <PageHeader :title="$t('club.title')" />
    <ErrorAlert :code="errorCode(query.error.value)" />
    <form class="stack" @submit.prevent="submit">
      <HAlert v-if="!canEdit" tone="info">{{ $t('club.readOnly') }}</HAlert>
      <fieldset :disabled="!canEdit" class="stack">
        <HCard :title="$t('club.legal')">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('club.name')">
              <HInput :id="id" v-model="form.name" required minlength="2" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.sport')">
              <HSelect :id="id" v-model="form.sport" :options="sports.map((s) => ({ value: s, label: $t(`sports.${s}`) }))" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.legalName')" optional>
              <HInput :id="id" v-model="form.legalName" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.taxCode')" optional>
              <HInput :id="id" v-model="form.taxCode" maxlength="16" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.vatNumber')" optional>
              <HInput :id="id" v-model="form.vatNumber" inputmode="numeric" maxlength="11" />
            </HField>
            <HField v-slot="{ id, describedBy }" :label="$t('club.federations')" :hint="$t('club.federationsHint')" optional>
              <HInput :id="id" v-model="form.federations" :aria-describedby="describedBy" />
            </HField>
          </div>
        </HCard>
        <HCard :title="$t('club.contacts')">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('common.email')" optional>
              <HInput :id="id" v-model="form.email" type="email" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.phone')" optional>
              <HInput :id="id" v-model="form.phone" type="tel" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.address')" optional>
              <HInput :id="id" v-model="form.addressLine" autocomplete="street-address" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.city')" optional>
              <HInput :id="id" v-model="form.city" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.province')" optional>
              <HInput :id="id" v-model="form.province" maxlength="2" />
            </HField>
            <HField v-slot="{ id }" :label="$t('club.postalCode')" optional>
              <HInput :id="id" v-model="form.postalCode" inputmode="numeric" maxlength="5" />
            </HField>
          </div>
        </HCard>
      </fieldset>
      <ErrorAlert :code="error" />
      <HAlert v-if="saved" tone="success">{{ $t('common.saved') }}</HAlert>
      <div v-if="canEdit" class="row">
        <HButton type="submit" :loading="update.fetching.value">{{ $t('common.save') }}</HButton>
      </div>
    </form>
  </div>
</template>

<style scoped>
fieldset {
  border: none;
  padding: 0;
  margin: 0;
  min-width: 0;
}
</style>
