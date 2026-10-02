<script setup lang="ts">
import { useMutation, useQuery } from '@urql/vue';
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRoute, useRouter } from 'vue-router';
import { errorCode } from '@/api/client';
import {
  AddGuardianDoc,
  CreatePersonDoc,
  InvitePersonAccountDoc,
  PersonDoc,
  RemoveGuardianDoc,
  SetPersonArchivedDoc,
  UpdatePersonDoc,
} from '@/api/people';
import PersonPicker from '@/components/PersonPicker.vue';
import { ErrorAlert, HAlert, HBadge, HButton, HCard, HField, HInput, HSelect, PageHeader } from '@/components/ui';
import type { GuardianRelation, MembershipRole, PersonCategory, PersonFieldsFragment, PersonGender } from '@/gql/graphql';
import { useSessionStore } from '@/stores/session';

const CATEGORIES: PersonCategory[] = ['ATHLETE', 'STAFF', 'MANAGER', 'VOLUNTEER', 'GUARDIAN'];
const RELATIONS: GuardianRelation[] = ['MOTHER', 'FATHER', 'GUARDIAN', 'OTHER'];
const MIN_ATHLETE_ACCOUNT_AGE = 14;

const route = useRoute();
const router = useRouter();
const session = useSessionStore();
const { t } = useI18n();

const isNew = computed(() => route.name === 'person-new');
const id = computed(() => String(route.params.id ?? ''));
const canManage = computed(() => session.allowed('people.manage'));

const query = useQuery({ query: PersonDoc, variables: computed(() => ({ id: id.value })), pause: isNew });
const person = ref<PersonFieldsFragment | null>(null);
watch(
  () => query.data.value?.person,
  (p) => {
    if (p) load(p);
  },
  { immediate: true },
);

const empty = () => ({
  firstName: '',
  lastName: '',
  birthDate: '',
  birthPlace: '',
  taxCode: '',
  gender: '' as PersonGender | '',
  categories: [] as PersonCategory[],
  email: '',
  phone: '',
  addressLine: '',
  city: '',
  province: '',
  postalCode: '',
  notes: '',
});
const form = ref(empty());

function load(p: PersonFieldsFragment) {
  person.value = p;
  form.value = {
    firstName: p.firstName,
    lastName: p.lastName,
    birthDate: p.birthDate ?? '',
    birthPlace: p.birthPlace ?? '',
    taxCode: p.taxCode ?? '',
    gender: p.gender ?? '',
    categories: [...p.categories],
    email: p.email ?? '',
    phone: p.phone ?? '',
    addressLine: p.addressLine ?? '',
    city: p.city ?? '',
    province: p.province ?? '',
    postalCode: p.postalCode ?? '',
    notes: p.notes ?? '',
  };
}

const create = useMutation(CreatePersonDoc);
const update = useMutation(UpdatePersonDoc);
const archive = useMutation(SetPersonArchivedDoc);
const addGuardian = useMutation(AddGuardianDoc);
const removeGuardian = useMutation(RemoveGuardianDoc);
const invite = useMutation(InvitePersonAccountDoc);

const error = ref<string | null>(null);
const notice = ref<string | null>(null);
const orNull = (v: string) => v.trim() || null;

function input() {
  const f = form.value;
  return {
    firstName: f.firstName,
    lastName: f.lastName,
    birthDate: orNull(f.birthDate),
    birthPlace: orNull(f.birthPlace),
    taxCode: orNull(f.taxCode),
    gender: (f.gender || null) as PersonGender | null,
    categories: f.categories,
    email: orNull(f.email),
    phone: orNull(f.phone),
    addressLine: orNull(f.addressLine),
    city: orNull(f.city),
    province: orNull(f.province),
    postalCode: orNull(f.postalCode),
    notes: orNull(f.notes),
  };
}

async function save() {
  error.value = null;
  notice.value = null;
  if (isNew.value) {
    const res = await create.executeMutation({ input: input() });
    error.value = errorCode(res.error);
    if (res.data) await router.replace({ name: 'person', params: { id: res.data.createPerson.id } });
    return;
  }
  const res = await update.executeMutation({ id: id.value, input: input() });
  error.value = errorCode(res.error);
  if (res.data) {
    load(res.data.updatePerson);
    notice.value = t('common.saved');
  }
}

async function toggleArchived() {
  const res = await archive.executeMutation({ id: id.value, archived: !person.value?.archivedAt });
  error.value = errorCode(res.error);
  if (res.data) load(res.data.setPersonArchived);
}

const relation = ref<GuardianRelation>('MOTHER');
async function linkGuardian(guardianId: string) {
  const res = await addGuardian.executeMutation({ minorId: id.value, guardianId, relation: relation.value });
  error.value = errorCode(res.error);
  if (res.data) load(res.data.addGuardian);
}

async function unlinkGuardian(guardianshipId: string) {
  const res = await removeGuardian.executeMutation({ guardianshipId });
  error.value = errorCode(res.error);
  if (res.data) load(res.data.removeGuardian);
}

// Ruolo suggerito per l'account: atleta dai 14 anni, genitore per i tutori, allenatore per lo staff.
const suggestedRole = computed<MembershipRole>(() => {
  const p = person.value;
  if (p?.categories.includes('ATHLETE')) return 'ATHLETE';
  if (p?.categories.includes('GUARDIAN')) return 'PARENT';
  if (p?.categories.includes('STAFF')) return 'COACH';
  return 'PARENT';
});
const accountRole = ref<MembershipRole>('PARENT');
const accountEmail = ref('');
watch(person, (p) => {
  accountRole.value = suggestedRole.value;
  accountEmail.value = p?.email ?? '';
});
const roleOptions = computed(() =>
  (['ATHLETE', 'PARENT', 'COACH', 'TEAM_MANAGER', 'SECRETARY', 'SPORTS_DIRECTOR', 'ADMIN'] as MembershipRole[]).map((r) => ({
    value: r,
    label: t(`roles.${r}`),
  })),
);
const athleteTooYoung = computed(
  () => accountRole.value === 'ATHLETE' && (person.value?.age ?? 0) < MIN_ATHLETE_ACCOUNT_AGE,
);

async function sendInvite() {
  error.value = null;
  const res = await invite.executeMutation({ personId: id.value, email: accountEmail.value, role: accountRole.value });
  error.value = errorCode(res.error);
  if (!res.error) notice.value = t('people.invited', { email: accountEmail.value });
}

const title = computed(() =>
  isNew.value ? t('people.new') : person.value ? `${person.value.firstName} ${person.value.lastName}` : t('common.loading'),
);
</script>

<template>
  <div>
    <RouterLink :to="{ name: 'people' }" class="back">← {{ $t('people.title') }}</RouterLink>
    <PageHeader :title="title">
      <div v-if="person" class="row">
        <HBadge v-if="person.isMinor" tone="warning">{{ $t('people.minor') }}</HBadge>
        <HBadge v-if="person.archivedAt">{{ $t('people.archived') }}</HBadge>
      </div>
    </PageHeader>

    <div class="stack">
      <ErrorAlert :code="error ?? errorCode(query.error.value)" />
      <HAlert v-if="notice" tone="success">{{ notice }}</HAlert>

      <form v-if="isNew || person" class="stack" @submit.prevent="save">
        <fieldset :disabled="!canManage" class="stack">
          <HCard :title="$t('people.personal')">
            <div class="grid-2">
              <HField v-slot="{ id: fid }" :label="$t('people.firstName')">
                <HInput :id="fid" v-model="form.firstName" required />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.lastName')">
                <HInput :id="fid" v-model="form.lastName" required />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.birthDate')" optional>
                <HInput :id="fid" v-model="form.birthDate" type="date" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.birthPlace')" optional>
                <HInput :id="fid" v-model="form.birthPlace" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.taxCode')" optional>
                <HInput :id="fid" v-model="form.taxCode" maxlength="16" autocapitalize="characters" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.gender')" optional>
                <HSelect
                  :id="fid"
                  v-model="form.gender"
                  :options="[{ value: '', label: '—' }, { value: 'F', label: $t('people.genders.F') }, { value: 'M', label: $t('people.genders.M') }]"
                />
              </HField>
            </div>
            <fieldset class="categories">
              <legend>{{ $t('people.categories') }}</legend>
              <label v-for="c in CATEGORIES" :key="c" class="check">
                <input v-model="form.categories" type="checkbox" :value="c" />
                {{ $t(`people.categoryLabels.${c}`) }}
              </label>
            </fieldset>
          </HCard>

          <HCard :title="$t('people.contacts')">
            <div class="grid-2">
              <HField v-slot="{ id: fid }" :label="$t('common.email')" optional>
                <HInput :id="fid" v-model="form.email" type="email" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('club.phone')" optional>
                <HInput :id="fid" v-model="form.phone" type="tel" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('club.address')" optional>
                <HInput :id="fid" v-model="form.addressLine" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('club.city')" optional>
                <HInput :id="fid" v-model="form.city" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('club.province')" optional>
                <HInput :id="fid" v-model="form.province" maxlength="2" />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('club.postalCode')" optional>
                <HInput :id="fid" v-model="form.postalCode" inputmode="numeric" maxlength="5" />
              </HField>
            </div>
            <HField v-if="canManage" v-slot="{ id: fid }" :label="$t('people.notes')" optional>
              <textarea :id="fid" v-model="form.notes" class="textarea" rows="3" />
            </HField>
          </HCard>
        </fieldset>

        <div v-if="canManage" class="row">
          <HButton type="submit" :loading="create.fetching.value || update.fetching.value">{{ $t('common.save') }}</HButton>
          <HButton v-if="person" variant="secondary" :loading="archive.fetching.value" @click="toggleArchived">
            {{ person.archivedAt ? $t('people.restore') : $t('people.archive') }}
          </HButton>
        </div>
      </form>

      <template v-if="person">
        <HCard v-if="person.isMinor || person.guardians.length" :title="$t('people.guardians')">
          <p v-if="!person.guardians.length" class="muted">{{ $t('people.noGuardians') }}</p>
          <ul class="list">
            <li v-for="g in person.guardians" :key="g.id">
              <div>
                <RouterLink :to="{ name: 'person', params: { id: g.person.id } }">
                  <strong>{{ g.person.firstName }} {{ g.person.lastName }}</strong>
                </RouterLink>
                <span class="muted"> · {{ $t(`people.relations.${g.relation}`) }}</span>
                <div class="muted small">{{ [g.person.phone, g.person.email].filter(Boolean).join(' · ') }}</div>
              </div>
              <HButton v-if="canManage" size="sm" variant="ghost" @click="unlinkGuardian(g.id)">{{ $t('common.remove') }}</HButton>
            </li>
          </ul>
          <div v-if="canManage" class="row">
            <HSelect v-model="relation" class="relation" :aria-label="$t('people.relation')" :options="RELATIONS.map((r) => ({ value: r, label: $t(`people.relations.${r}`) }))" />
            <PersonPicker
              :label="$t('people.addGuardian')"
              :exclude="[person.id, ...person.guardians.map((g) => g.person.id)]"
              @pick="(p) => linkGuardian(p.id)"
            />
          </div>
        </HCard>

        <HCard v-if="person.wards.length" :title="$t('people.wards')">
          <ul class="list">
            <li v-for="w in person.wards" :key="w.id">
              <RouterLink :to="{ name: 'person', params: { id: w.person.id } }">{{ w.person.firstName }} {{ w.person.lastName }}</RouterLink>
              <span class="muted">{{ $t(`people.relations.${w.relation}`) }}</span>
            </li>
          </ul>
        </HCard>

        <HCard :title="$t('people.teams')">
          <p v-if="!person.teams.length" class="muted">{{ $t('people.noTeams') }}</p>
          <ul class="list">
            <li v-for="tm in person.teams" :key="`${tm.teamId}-${tm.staffRole}`">
              <RouterLink :to="{ name: 'team', params: { id: tm.teamId } }">{{ tm.teamName }}</RouterLink>
              <span class="muted">
                {{ tm.seasonName }} ·
                {{ tm.asPlayer ? $t('people.player') + (tm.jerseyNumber !== null ? ` #${tm.jerseyNumber}` : '') : $t(`teams.staffRoles.${tm.staffRole}`) }}
              </span>
            </li>
          </ul>
        </HCard>

        <HCard :title="$t('people.accountTitle')">
          <p v-if="person.hasAccount" class="row">
            <HBadge tone="success">{{ $t('people.hasAccount') }}</HBadge>
            <span class="muted">{{ $t('people.accountActive') }}</span>
          </p>
          <form v-else-if="canManage" class="stack" @submit.prevent="sendInvite">
            <p class="muted">{{ $t('people.accountInviteHint') }}</p>
            <div class="grid-2">
              <HField v-slot="{ id: fid }" :label="$t('common.email')">
                <HInput :id="fid" v-model="accountEmail" type="email" required />
              </HField>
              <HField v-slot="{ id: fid }" :label="$t('people.accountRole')">
                <HSelect :id="fid" v-model="accountRole" :options="roleOptions" />
              </HField>
            </div>
            <HAlert v-if="athleteTooYoung" tone="warning">{{ $t('people.athleteTooYoung') }}</HAlert>
            <div class="row">
              <HButton type="submit" variant="secondary" :disabled="athleteTooYoung" :loading="invite.fetching.value">
                {{ $t('people.accountInvite') }}
              </HButton>
            </div>
          </form>
          <p v-else class="muted">{{ $t('people.noAccount') }}</p>
        </HCard>
      </template>
    </div>
  </div>
</template>

<style scoped>
.back {
  display: inline-block;
  margin-bottom: var(--space-3);
  font-size: var(--text-sm);
}
fieldset {
  border: none;
  padding: 0;
  margin: 0;
  min-width: 0;
}
.categories {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-2) var(--space-4);
}
.categories legend {
  font-size: var(--text-sm);
  font-weight: 600;
  margin-bottom: var(--space-2);
}
.check {
  display: flex;
  gap: var(--space-2);
  align-items: center;
  font-size: var(--text-sm);
}
.check input {
  accent-color: var(--primary);
}
.textarea {
  width: 100%;
  padding: var(--space-2) var(--space-3);
  border: 1px solid var(--border-strong);
  border-radius: var(--radius);
  background: var(--surface);
  color: var(--text);
  font: inherit;
  resize: vertical;
}
.list {
  list-style: none;
  margin: 0;
  padding: 0;
}
.list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-2) 0;
  border-bottom: 1px solid var(--border);
}
.list li:last-child {
  border-bottom: none;
}
.small {
  font-size: var(--text-xs);
}
.relation {
  max-width: 160px;
}
</style>
