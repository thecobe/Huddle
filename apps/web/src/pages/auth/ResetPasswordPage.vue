<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import { errorCode } from '@/api/client';
import { ResetPasswordDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HField, HInput } from '@/components/ui';

const route = useRoute();
const password = ref('');
const done = ref(false);
const error = ref<string | null>(null);
const reset = useMutation(ResetPasswordDoc);

async function submit() {
  const res = await reset.executeMutation({ token: String(route.query.token ?? ''), newPassword: password.value });
  error.value = errorCode(res.error);
  done.value = !!res.data?.resetPassword;
}
</script>

<template>
  <div class="stack">
    <h1>{{ $t('auth.reset.title') }}</h1>
    <template v-if="done">
      <HAlert tone="success">{{ $t('auth.reset.done') }}</HAlert>
      <RouterLink :to="{ name: 'login' }">{{ $t('auth.login.title') }}</RouterLink>
    </template>
    <form v-else class="stack" @submit.prevent="submit">
      <ErrorAlert :code="error" />
      <HField v-slot="{ id }" :label="$t('security.newPassword')" :hint="$t('auth.register.passwordHint')">
        <HInput :id="id" v-model="password" type="password" autocomplete="new-password" minlength="10" required />
      </HField>
      <HButton type="submit" block :loading="reset.fetching.value">{{ $t('auth.reset.submit') }}</HButton>
    </form>
  </div>
</template>
