<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { VerifyTwoFactorDoc } from '@/api/operations';
import { ErrorAlert, HButton, HField, HInput } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';

const router = useRouter();
const flow = useAuthFlow();
const code = ref('');
const error = ref<string | null>(null);
const verify = useMutation(VerifyTwoFactorDoc);

onMounted(() => {
  if (!flow.pendingChallenge.value) router.replace({ name: 'login' });
});

async function submit() {
  error.value = null;
  const res = await verify.executeMutation({ challengeToken: flow.pendingChallenge.value ?? '', code: code.value });
  error.value = errorCode(res.error);
  if (res.data) await flow.finish(res.data.verifyTwoFactor, router);
}
</script>

<template>
  <div class="stack">
    <div>
      <h1>{{ $t('auth.twoFactor.title') }}</h1>
      <p class="muted">{{ $t('auth.twoFactor.subtitle') }}</p>
    </div>
    <ErrorAlert :code="error" />
    <form class="stack" @submit.prevent="submit">
      <HField v-slot="{ id }" :label="$t('auth.twoFactor.code')">
        <HInput :id="id" v-model="code" inputmode="numeric" autocomplete="one-time-code" required autofocus />
      </HField>
      <HButton type="submit" block :loading="verify.fetching.value">{{ $t('auth.twoFactor.submit') }}</HButton>
    </form>
  </div>
</template>
