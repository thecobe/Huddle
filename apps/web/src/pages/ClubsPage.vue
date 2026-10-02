<script setup lang="ts">
import { useMutation } from '@urql/vue';
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import { CreateClubDoc } from '@/api/operations';
import { ErrorAlert, HBadge, HButton, HField, HInput, HSelect } from '@/components/ui';
import { useAuthFlow } from '@/stores/auth-flow';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const router = useRouter();
const flow = useAuthFlow();

const creating = ref(session.clubs.length === 0);
const form = ref({ name: '', sport: 'FOOTBALL' });
const error = ref<string | null>(null);
const create = useMutation(CreateClubDoc);
const sports = ['FOOTBALL', 'FUTSAL', 'VOLLEYBALL', 'BASKETBALL', 'RUGBY', 'OTHER'];

async function open(id: string) {
  session.selectClub(id);
  await router.push(flow.landing());
}

async function submit() {
  error.value = null;
  const res = await create.executeMutation({ input: form.value });
  error.value = errorCode(res.error);
  if (!res.data) return;
  await session.reloadUser();
  await open(res.data.createClub.id);
}

async function logout() {
  await session.logout();
  await router.replace({ name: 'login' });
}
</script>

<template>
  <div class="stack">
    <template v-if="!creating">
      <div>
        <h1>{{ $t('clubs.title') }}</h1>
        <p class="muted">{{ $t('clubs.subtitle') }}</p>
      </div>
      <ul class="clubs">
        <li v-for="club in session.clubs" :key="club.id">
          <button type="button" class="club" @click="open(club.id)">
            <strong>{{ club.name }}</strong>
            <span class="row">
              <HBadge v-for="r in club.roles" :key="r" tone="brand">{{ $t(`roles.${r}`) }}</HBadge>
            </span>
          </button>
        </li>
      </ul>
      <HButton variant="secondary" block @click="creating = true">{{ $t('clubs.create') }}</HButton>
    </template>

    <template v-else>
      <div>
        <h1>{{ $t('clubs.createTitle') }}</h1>
        <p class="muted">{{ $t('clubs.createSubtitle') }}</p>
      </div>
      <p v-if="session.clubs.length === 0" class="muted">{{ $t('clubs.empty') }}</p>
      <ErrorAlert :code="error" />
      <form class="stack" @submit.prevent="submit">
        <HField v-slot="{ id }" :label="$t('club.name')">
          <HInput :id="id" v-model="form.name" required minlength="2" placeholder="ASD Polisportiva…" />
        </HField>
        <HField v-slot="{ id }" :label="$t('club.sport')">
          <HSelect :id="id" v-model="form.sport" :options="sports.map((s) => ({ value: s, label: $t(`sports.${s}`) }))" />
        </HField>
        <HButton type="submit" block :loading="create.fetching.value">{{ $t('clubs.create') }}</HButton>
        <HButton v-if="session.clubs.length" variant="ghost" block @click="creating = false">{{ $t('common.cancel') }}</HButton>
      </form>
    </template>

    <button type="button" class="logout" @click="logout">{{ $t('nav.logout') }}</button>
  </div>
</template>

<style scoped>
.clubs {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
}
.club {
  width: 100%;
  text-align: left;
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  padding: var(--space-4);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  background: var(--surface);
  color: var(--text);
  font: inherit;
  cursor: pointer;
}
.club:hover {
  border-color: var(--primary);
}
.logout {
  align-self: center;
  background: none;
  border: none;
  color: var(--text-muted);
  font: inherit;
  font-size: var(--text-sm);
  cursor: pointer;
  text-decoration: underline;
}
</style>
