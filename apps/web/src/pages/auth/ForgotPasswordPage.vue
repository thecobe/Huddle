<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { errorCode } from '@/api/client';
import { RequestPasswordResetDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HField, HInput } from '@/components/ui';

const email = ref('');
const sent = ref(false);
const error = ref<string | null>(null);
const request = useMutation(RequestPasswordResetDoc);

async function submit() {
  const res = await request.executeMutation({ email: email.value });
  error.value = errorCode(res.error);
  sent.value = !res.error;
}
</script>

<template>
  <div class="stack">
    <div>
      <h1>{{ $t('auth.forgot.title') }}</h1>
      <p class="muted">{{ $t('auth.forgot.subtitle') }}</p>
    </div>
    <HAlert v-if="sent" tone="success">{{ $t('auth.forgot.sent') }}</HAlert>
    <ErrorAlert :code="error" />
    <form class="stack" @submit.prevent="submit">
      <HField v-slot="{ id }" :label="$t('common.email')">
        <HInput :id="id" v-model="email" type="email" autocomplete="email" required />
      </HField>
      <HButton type="submit" block :loading="request.fetching.value">{{ $t('auth.forgot.submit') }}</HButton>
    </form>
    <RouterLink :to="{ name: 'login' }">{{ $t('common.back') }}</RouterLink>
  </div>
</template>
