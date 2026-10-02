<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { LoginDoc, RequestMagicLinkDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HField, HInput } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';

const router = useRouter();
const route = useRoute();
const flow = useAuthFlow();

const mode = ref<'password' | 'magic'>('password');
const email = ref('');
const password = ref('');
const error = ref<string | null>(null);
const magicSent = ref(false);

const login = useMutation(LoginDoc);
const magic = useMutation(RequestMagicLinkDoc);

async function submit() {
  error.value = null;
  if (mode.value === 'magic') {
    const res = await magic.executeMutation({ email: email.value });
    error.value = errorCode(res.error);
    magicSent.value = !res.error;
    return;
  }
  const res = await login.executeMutation({ input: { email: email.value, password: password.value } });
  error.value = errorCode(res.error);
  if (res.data) await flow.finish(res.data.login, router, route.query.redirect as string | undefined);
}
</script>

<template>
  <div class="stack">
    <div>
      <h1>{{ $t('auth.login.title') }}</h1>
      <p class="muted">{{ $t('auth.login.subtitle') }}</p>
    </div>

    <div class="tabs" role="tablist">
      <button role="tab" type="button" :aria-selected="mode === 'password'" @click="mode = 'password'">
        {{ $t('auth.login.passwordTab') }}
      </button>
      <button role="tab" type="button" :aria-selected="mode === 'magic'" @click="mode = 'magic'">
        {{ $t('auth.login.magicTab') }}
      </button>
    </div>

    <HAlert v-if="magicSent && mode === 'magic'" tone="success">{{ $t('auth.login.magicSent') }}</HAlert>
    <ErrorAlert :code="error" />

    <form class="stack" @submit.prevent="submit">
      <HField v-slot="{ id }" :label="$t('common.email')">
        <HInput :id="id" v-model="email" type="email" autocomplete="email" required />
      </HField>
      <HField v-if="mode === 'password'" v-slot="{ id }" :label="$t('common.password')">
        <HInput :id="id" v-model="password" type="password" autocomplete="current-password" required />
      </HField>
      <p v-else class="muted">{{ $t('auth.login.magicHint') }}</p>
      <HButton type="submit" block :loading="login.fetching.value || magic.fetching.value">
        {{ mode === 'password' ? $t('auth.login.submit') : $t('auth.login.magicSubmit') }}
      </HButton>
    </form>

    <div class="links">
      <RouterLink :to="{ name: 'forgot-password' }">{{ $t('auth.login.forgot') }}</RouterLink>
      <span>
        {{ $t('auth.login.noAccount') }}
        <RouterLink :to="{ name: 'register' }">{{ $t('auth.login.register') }}</RouterLink>
      </span>
    </div>
  </div>
</template>

<style scoped>
.tabs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  background: var(--surface-muted);
  border-radius: var(--radius);
  padding: 4px;
}
.tabs button {
  border: none;
  background: transparent;
  font: inherit;
  font-size: var(--text-sm);
  font-weight: 600;
  padding: var(--space-2);
  border-radius: var(--radius-sm);
  color: var(--text-muted);
  cursor: pointer;
}
.tabs button[aria-selected='true'] {
  background: var(--surface);
  color: var(--text);
  box-shadow: var(--shadow-sm);
}
.links {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: var(--space-2);
  font-size: var(--text-sm);
}
</style>
