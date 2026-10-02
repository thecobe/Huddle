<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { AcceptInvitationDoc, InvitationPreviewDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HButton, HField, HInput } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';
import { useSessionStore } from '@/stores/session';

const route = useRoute();
const router = useRouter();
const flow = useAuthFlow();
const session = useSessionStore();
const token = String(route.query.token ?? '');

const preview = useQuery({ query: InvitationPreviewDoc, variables: { token }, requestPolicy: 'network-only' });
const invitation = computed(() => preview.data.value?.invitationPreview);

const form = ref({ fullName: '', password: '', acceptTerms: false });
const error = ref<string | null>(null);
const accept = useMutation(AcceptInvitationDoc);

async function submit() {
  error.value = null;
  const res = await accept.executeMutation({
    input: {
      token,
      acceptTerms: form.value.acceptTerms,
      fullName: invitation.value?.accountExists ? undefined : form.value.fullName,
      password: form.value.password || undefined,
    },
  });
  error.value = errorCode(res.error);
  if (!res.data) return;
  // Dopo l'accesso si apre direttamente la società che ha inviato l'invito.
  if (invitation.value) session.selectClub(invitation.value.clubId);
  await flow.finish(res.data.acceptInvitation, router);
}
</script>

<template>
  <div class="stack">
    <p v-if="preview.fetching.value" class="muted">{{ $t('common.loading') }}</p>
    <HAlert v-else-if="!invitation" tone="error">{{ $t('invitation.invalid') }}</HAlert>
    <template v-else>
      <div>
        <h1>{{ $t('invitation.title') }}</h1>
        <p class="muted">
          {{ $t('invitation.body', { club: invitation.clubName, role: $t(`roles.${invitation.role}`) }) }}
        </p>
      </div>
      <ErrorAlert :code="error" />
      <form class="stack" @submit.prevent="submit">
        <p v-if="invitation.accountExists">{{ $t('invitation.existing', { email: invitation.email }) }}</p>
        <template v-else>
          <p>{{ $t('invitation.newAccount') }}</p>
          <HField v-slot="{ id }" :label="$t('common.email')">
            <HInput :id="id" :model-value="invitation.email" disabled />
          </HField>
          <HField v-slot="{ id }" :label="$t('common.fullName')">
            <HInput :id="id" v-model="form.fullName" autocomplete="name" required minlength="2" />
          </HField>
          <HField v-slot="{ id }" :label="$t('common.password')" :hint="$t('invitation.passwordHint')" optional>
            <HInput :id="id" v-model="form.password" type="password" autocomplete="new-password" minlength="10" />
          </HField>
        </template>
        <label class="check">
          <input v-model="form.acceptTerms" type="checkbox" required />
          <span>{{ $t('auth.register.terms') }}</span>
        </label>
        <HButton type="submit" block :loading="accept.fetching.value">{{ $t('invitation.accept') }}</HButton>
      </form>
    </template>
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
