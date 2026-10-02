<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { RegisterDoc } from '@/api/operations';
import { ErrorAlert, HButton, HField, HInput } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';

const router = useRouter();
const flow = useAuthFlow();
const { locale } = useI18n();

const form = ref({ fullName: '', email: '', password: '', acceptTerms: false });
const error = ref<string | null>(null);
const register = useMutation(RegisterDoc);

async function submit() {
  error.value = null;
  const res = await register.executeMutation({ input: { ...form.value, locale: locale.value } });
  error.value = errorCode(res.error);
  if (res.data) await flow.finish(res.data.register, router);
}
</script>

<template>
  <div class="stack">
    <div>
      <h1>{{ $t('auth.register.title') }}</h1>
      <p class="muted">{{ $t('auth.register.subtitle') }}</p>
    </div>
    <ErrorAlert :code="error" />
    <form class="stack" @submit.prevent="submit">
      <HField v-slot="{ id }" :label="$t('common.fullName')">
        <HInput :id="id" v-model="form.fullName" autocomplete="name" required minlength="2" />
      </HField>
      <HField v-slot="{ id }" :label="$t('common.email')">
        <HInput :id="id" v-model="form.email" type="email" autocomplete="email" required />
      </HField>
      <HField v-slot="{ id, describedBy }" :label="$t('common.password')" :hint="$t('auth.register.passwordHint')">
        <HInput :id="id" v-model="form.password" type="password" autocomplete="new-password" minlength="10" required :aria-describedby="describedBy" />
      </HField>
      <label class="check">
        <input v-model="form.acceptTerms" type="checkbox" required />
        <span>{{ $t('auth.register.terms') }}</span>
      </label>
      <HButton type="submit" block :loading="register.fetching.value">{{ $t('auth.register.submit') }}</HButton>
    </form>
    <p class="muted">
      {{ $t('auth.register.haveAccount') }}
      <RouterLink :to="{ name: 'login' }">{{ $t('auth.login.submit') }}</RouterLink>
    </p>
  </div>
</template>

<style scoped>
.check {
  display: flex;
  gap: var(--space-2);
  align-items: flex-start;
  font-size: var(--text-sm);
}
.check input {
  margin-top: 3px;
  accent-color: var(--primary);
}
</style>
