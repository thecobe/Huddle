import { defineStore } from 'pinia';
import { computed, ref, shallowRef } from 'vue';
import { createClient, request } from '@/api/client';
import { LogoutDoc, MeDoc, RefreshSessionDoc } from '@/api/operations';
import type { AuthFieldsFragment, MeFieldsFragment } from '@/gql/graphql';
import { can, type Permission, TWO_FACTOR_ROLES } from '@/permissions';

const CLUB_KEY = 'huddle.clubId';

function readStoredClub(): string | null {
  try {
    return localStorage.getItem(CLUB_KEY);
  } catch {
    return null;
  }
}

function storeClub(id: string | null): void {
  try {
    if (id) localStorage.setItem(CLUB_KEY, id);
    else localStorage.removeItem(CLUB_KEY);
  } catch {
    // Storage non disponibile (navigazione privata): la scelta vale solo per la sessione.
  }
}

/**
 * Sessione utente. L'access token resta solo in memoria; il refresh token è in un cookie httpOnly
 * gestito dal server, quindi al caricamento della pagina la sessione si ripristina con refreshSession.
 */
export const useSessionStore = defineStore('session', () => {
  const accessToken = ref<string | null>(null);
  const user = ref<MeFieldsFragment | null>(null);
  const clubId = ref<string | null>(readStoredClub());
  const ready = ref(false);
  let refreshing: Promise<boolean> | null = null;

  const auth = () => ({ accessToken: accessToken.value, clubId: clubId.value });
  const client = shallowRef(createClient(auth, () => refresh()));

  const isAuthenticated = computed(() => !!accessToken.value && !!user.value);
  const clubs = computed(() => {
    const map = new Map<string, { id: string; name: string; roles: string[] }>();
    for (const m of user.value?.memberships ?? []) {
      const club = map.get(m.clubId) ?? { id: m.clubId, name: m.clubName, roles: [] };
      club.roles.push(m.role);
      map.set(m.clubId, club);
    }
    return [...map.values()];
  });
  const currentRoles = computed(() =>
    (user.value?.memberships ?? []).filter((m) => m.clubId === clubId.value).map((m) => m.role),
  );
  const currentClub = computed(() => clubs.value.find((c) => c.id === clubId.value) ?? null);
  const needsTwoFactor = computed(
    () => !user.value?.twoFactorEnabled && currentRoles.value.some((r) => TWO_FACTOR_ROLES.includes(r)),
  );

  function allowed(permission: Permission): boolean {
    return can(currentRoles.value, permission);
  }

  /** Applica l'esito di login/registrazione/2FA. Restituisce lo stato per la navigazione. */
  function applyAuth(payload: AuthFieldsFragment) {
    if (payload.status === 'AUTHENTICATED' && payload.accessToken && payload.user) {
      accessToken.value = payload.accessToken;
      setUser(payload.user);
    }
    return payload.status;
  }

  function setUser(me: MeFieldsFragment) {
    user.value = me;
    const ids = new Set(me.memberships.map((m) => m.clubId));
    if (clubId.value && !ids.has(clubId.value)) selectClub(null);
    if (!clubId.value && ids.size === 1) selectClub([...ids][0]!);
  }

  function selectClub(id: string | null) {
    if (id === clubId.value) return;
    clubId.value = id;
    storeClub(id);
    client.value = createClient(auth, () => refresh());
  }

  async function refresh(): Promise<boolean> {
    refreshing ??= (async () => {
      try {
        const res = await request(RefreshSessionDoc, {}, { accessToken: null, clubId: null });
        if (res.data?.refreshSession) {
          applyAuth(res.data.refreshSession);
          return true;
        }
        clear();
        return false;
      } catch {
        return false;
      } finally {
        refreshing = null;
      }
    })();
    return refreshing;
  }

  async function bootstrap(): Promise<void> {
    if (ready.value) return;
    await refresh();
    ready.value = true;
  }

  async function reloadUser(): Promise<void> {
    const res = await request(MeDoc, {}, auth());
    if (res.data?.me) setUser(res.data.me);
  }

  async function logout(): Promise<void> {
    await request(LogoutDoc, {}, auth()).catch(() => undefined);
    clear();
  }

  function clear() {
    accessToken.value = null;
    user.value = null;
  }

  return {
    accessToken,
    user,
    clubId,
    ready,
    client,
    isAuthenticated,
    clubs,
    currentClub,
    currentRoles,
    needsTwoFactor,
    allowed,
    applyAuth,
    setUser,
    selectClub,
    refresh,
    bootstrap,
    reloadUser,
    logout,
  };
});
