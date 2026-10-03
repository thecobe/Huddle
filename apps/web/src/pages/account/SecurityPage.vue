<script setup lang="ts">
import { useMutation } from '@urql/vue';
import QRCode from 'qrcode';
import { ref } from 'vue';
import { errorCode } from '@/api/client';
import { ChangePasswordDoc, DisableTwoFactorDoc, EnableTwoFactorDoc, SetupTwoFactorDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HBadge, HButton, HCard, HField, HInput, PageHeader } from '@/components/ui';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();

const setup = useMutation(SetupTwoFactorDoc);
const enable = useMutation(EnableTwoFactorDoc);
const disable = useMutation(DisableTwoFactorDoc);
const changePassword = useMutation(ChangePasswordDoc);

const pending = ref<{ secret: string; qr: string } | null>(null);
const code = ref('');
const recoveryCodes = ref<string[] | null>(null);
const tfaError = ref<string | null>(null);

const pwd = ref({ current: '', next: '' });
const pwdError = ref<string | null>(null);
const pwdSaved = ref(false);

async function startSetup() {
  tfaError.value = null;
  const res = await setup.executeMutation({});
  tfaError.value = errorCode(res.error);
  if (!res.data) return;
  const { secret, otpauthUri } = res.data.setupTwoFactor;
  // Senza QR resta comunque la chiave da inserire a mano.
  const qr = await QRCode.toDataURL(otpauthUri, { margin: 1, width: 200 }).catch(() => '');
  pending.value = { secret, qr };
}

async function confirmSetup() {
  tfaError.value = null;
  const res = await enable.executeMutation({ code: code.value });
  tfaError.value = errorCode(res.error);
  if (!res.data) return;
  recoveryCodes.value = res.data.enableTwoFactor;
  pending.value = null;
  code.value = '';
  await reload();
}

async function turnOff() {
  tfaError.value = null;
  const res = await disable.executeMutation({ code: code.value });
  tfaError.value = errorCode(res.error);
  if (res.error) return;
  code.value = '';
  await reload();
}

/** Ricarica il profilo; un errore di rete non deve interrompere l'azione già riuscita. */
async function reload() {
  try {
    await session.reloadUser();
  } catch {
    tfaError.value = 'NETWORK';
  }
}

async function submitPassword() {
  pwdSaved.value = false;
  const res = await changePassword.executeMutation({ currentPassword: pwd.value.current, newPassword: pwd.value.next });
  pwdError.value = errorCode(res.error);
  pwdSaved.value = !res.error;
  if (!res.error) pwd.value = { current: '', next: '' };
}
</script>

<template>
  <div>
    <PageHeader :title="$t('security.title')" />
    <div class="stack">
      <HAlert v-if="session.needsTwoFactor" tone="warning">{{ $t('security.twoFactorRequired') }}</HAlert>

      <HCard :title="$t('security.twoFactor')" :description="$t('security.twoFactorIntro')">
        <template #actions>
          <HBadge :tone="session.user?.twoFactorEnabled ? 'success' : 'neutral'">
            {{ session.user?.twoFactorEnabled ? $t('security.twoFactorOn') : $t('security.twoFactorOff') }}
          </HBadge>
        </template>

        <ErrorAlert :code="tfaError" />

        <div v-if="recoveryCodes" class="stack">
          <h3>{{ $t('security.recoveryTitle') }}</h3>
          <p class="muted">{{ $t('security.recoveryHint') }}</p>
          <ul class="codes">
            <li v-for="c in recoveryCodes" :key="c"><code>{{ c }}</code></li>
          </ul>
          <div class="row"><HButton @click="recoveryCodes = null">{{ $t('security.recoveryDone') }}</HButton></div>
        </div>

        <form v-else-if="pending" class="setup" @submit.prevent="confirmSetup">
          <img v-if="pending.qr" :src="pending.qr" alt="" width="200" height="200" class="qr" />
          <div class="stack">
            <p class="muted">{{ $t('security.scan') }}</p>
            <p>
              {{ $t('security.secret') }}: <code class="secret">{{ pending.secret }}</code>
            </p>
            <HField v-slot="{ id }" :label="$t('security.confirmCode')">
              <HInput :id="id" v-model="code" inputmode="numeric" autocomplete="one-time-code" required />
            </HField>
            <div class="row"><HButton type="submit" :loading="enable.fetching.value">{{ $t('security.enable') }}</HButton></div>
          </div>
        </form>

        <form v-else-if="session.user?.twoFactorEnabled" class="stack" @submit.prevent="turnOff">
          <HField v-slot="{ id }" :label="$t('security.confirmCode')" :hint="$t('security.disableHint')">
            <HInput :id="id" v-model="code" inputmode="numeric" autocomplete="one-time-code" required />
          </HField>
          <div class="row"><HButton type="submit" variant="danger" :loading="disable.fetching.value">{{ $t('security.disable') }}</HButton></div>
        </form>

        <div v-else class="row">
          <HButton :loading="setup.fetching.value" @click="startSetup">{{ $t('security.setup') }}</HButton>
        </div>
      </HCard>

      <HCard :title="$t('security.password')">
        <form class="stack" @submit.prevent="submitPassword">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('security.currentPassword')" :hint="$t('security.currentPasswordHint')">
              <HInput :id="id" v-model="pwd.current" type="password" autocomplete="current-password" />
            </HField>
            <HField v-slot="{ id }" :label="$t('security.newPassword')" :hint="$t('auth.register.passwordHint')">
              <HInput :id="id" v-model="pwd.next" type="password" autocomplete="new-password" minlength="10" required />
            </HField>
          </div>
          <ErrorAlert :code="pwdError" />
          <HAlert v-if="pwdSaved" tone="success">{{ $t('security.passwordChanged') }}</HAlert>
          <div class="row">
            <HButton type="submit" variant="secondary" :loading="changePassword.fetching.value">{{ $t('security.changePassword') }}</HButton>
          </div>
        </form>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
.setup {
  display: grid;
  grid-template-columns: auto 1fr;
  gap: var(--space-5);
  align-items: start;
}
.qr {
  border-radius: var(--radius);
  background: #fff;
  padding: var(--space-2);
}
.secret {
  word-break: break-all;
  font-size: var(--text-sm);
}
.codes {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: var(--space-2);
}
.codes code {
  display: block;
  padding: var(--space-2);
  background: var(--surface-muted);
  border-radius: var(--radius-sm);
  text-align: center;
  font-size: var(--text-sm);
}
@media (max-width: 640px) {
  .setup {
    grid-template-columns: 1fr;
  }
}
</style>
