<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { errorCode } from '@/api/client';
import { InviteMemberDoc, MembersDoc, RemoveMembershipDoc, RevokeInvitationDoc } from '@/api/operations';
import { ErrorAlert, HAlert, HBadge, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import type { MembershipRole } from '@/gql/graphql';
import { ADMIN_ASSIGNED_ROLES, ALL_ROLES } from '@/permissions';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const { t, d } = useI18n();
const canInvite = computed(() => session.allowed('member.invite'));
const canManage = computed(() => session.allowed('member.manage'));

const members = useQuery({ query: MembersDoc });
const invite = useMutation(InviteMemberDoc);
const revoke = useMutation(RevokeInvitationDoc);
const remove = useMutation(RemoveMembershipDoc);

const showInvite = ref(false);
const form = ref<{ email: string; role: MembershipRole }>({ email: '', role: 'COACH' });
const error = ref<string | null>(null);
const notice = ref<string | null>(null);

// La segreteria può invitare solo ruoli non amministrativi (stessa regola del server).
const roleOptions = computed(() =>
  ALL_ROLES.filter((r) => session.currentRoles.includes('ADMIN') || !ADMIN_ASSIGNED_ROLES.includes(r)).map((r) => ({
    value: r,
    label: t(`roles.${r}`),
  })),
);

const refetch = () => members.executeQuery({ requestPolicy: 'network-only' });
const fmt = (iso: string) => d(new Date(iso), { day: 'numeric', month: 'short', year: 'numeric' });

async function submitInvite() {
  error.value = null;
  const email = form.value.email;
  const res = await invite.executeMutation({ input: form.value });
  error.value = errorCode(res.error);
  if (res.error) return;
  notice.value = t('members.invited', { email });
  form.value = { email: '', role: form.value.role };
  showInvite.value = false;
  refetch();
}

async function revokeInvitation(id: string) {
  const res = await revoke.executeMutation({ id });
  error.value = errorCode(res.error);
  refetch();
}

async function removeMember(m: { membershipId: string; fullName: string; role: MembershipRole }) {
  if (!confirm(t('members.confirmRemove', { name: m.fullName, role: t(`roles.${m.role}`) }))) return;
  const res = await remove.executeMutation({ membershipId: m.membershipId });
  error.value = errorCode(res.error);
  refetch();
}
</script>

<template>
  <div>
    <PageHeader :title="$t('members.title')" :subtitle="$t('members.subtitle')">
      <HButton v-if="canInvite && !showInvite" @click="showInvite = true">{{ $t('members.invite') }}</HButton>
    </PageHeader>

    <div class="stack">
      <HCard v-if="showInvite" :title="$t('members.inviteTitle')" :description="$t('members.inviteHint')">
        <form class="stack" @submit.prevent="submitInvite">
          <div class="grid-2">
            <HField v-slot="{ id }" :label="$t('common.email')">
              <HInput :id="id" v-model="form.email" type="email" required />
            </HField>
            <HField v-slot="{ id }" :label="$t('members.role')">
              <HSelect :id="id" v-model="form.role" :options="roleOptions" />
            </HField>
          </div>
          <div class="row">
            <HButton type="submit" :loading="invite.fetching.value">{{ $t('members.invite') }}</HButton>
            <HButton variant="ghost" @click="showInvite = false">{{ $t('common.cancel') }}</HButton>
          </div>
        </form>
      </HCard>

      <HAlert v-if="notice" tone="success">{{ notice }}</HAlert>
      <ErrorAlert :code="error ?? errorCode(members.error.value)" />

      <HCard :padded="false">
        <div class="table-wrap">
          <table class="data">
            <thead>
              <tr>
                <th>{{ $t('common.fullName') }}</th>
                <th>{{ $t('members.role') }}</th>
                <th>{{ $t('members.since') }}</th>
                <th v-if="canManage"><span class="sr-only">Azioni</span></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="m in members.data.value?.members" :key="m.membershipId">
                <td>
                  <strong>{{ m.fullName }}</strong>
                  <div class="muted small">{{ m.email }}</div>
                </td>
                <td><HBadge tone="brand">{{ $t(`roles.${m.role}`) }}</HBadge></td>
                <td>{{ fmt(m.createdAt) }}</td>
                <td v-if="canManage" class="actions">
                  <HButton v-if="m.userId !== session.user?.id" size="sm" variant="danger" @click="removeMember(m)">{{ $t('common.remove') }}</HButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </HCard>

      <HCard v-if="canInvite" :title="$t('members.pending')" :padded="false">
        <p v-if="!members.data.value?.invitations.length" class="muted empty">{{ $t('members.empty') }}</p>
        <div v-else class="table-wrap">
          <table class="data">
            <tbody>
              <tr v-for="i in members.data.value?.invitations" :key="i.id">
                <td>{{ i.email }}</td>
                <td><HBadge>{{ $t(`roles.${i.role}`) }}</HBadge></td>
                <td class="muted small">{{ $t('members.expires') }} {{ fmt(i.expiresAt) }}</td>
                <td class="actions">
                  <HButton size="sm" variant="ghost" @click="revokeInvitation(i.id)">{{ $t('common.revoke') }}</HButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </HCard>
    </div>
  </div>
</template>

<style scoped>
.small {
  font-size: var(--text-xs);
}
.empty {
  padding: 0 var(--space-5) var(--space-5);
}
.actions {
  text-align: right;
}
</style>
