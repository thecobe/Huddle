<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { ConsumeMagicLinkDoc } from '@/api/operations';
import { HAlert } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';

const route = useRoute();
const router = useRouter();
const flow = useAuthFlow();
const failed = ref(false);
const consume = useMutation(ConsumeMagicLinkDoc);

onMounted(async () => {
  const res = await consume.executeMutation({ token: String(route.query.token ?? '') });
  if (res.data) await flow.finish(res.data.consumeMagicLink, router);
  else failed.value = true;
});
</script>

<template>
  <div class="stack">
    <p v-if="!failed" class="muted">{{ $t('auth.magic.verifying') }}</p>
    <template v-else>
      <HAlert tone="error">{{ $t('auth.magic.failed') }}</HAlert>
      <RouterLink :to="{ name: 'login' }">{{ $t('auth.login.title') }}</RouterLink>
    </template>
  </div>
</template>
