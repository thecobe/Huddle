import { ref } from 'vue';
import type { Router } from 'vue-router';
import type { AuthFieldsFragment } from '@/gql/graphql';
import { useSessionStore } from './session';

// Sfida 2FA in corso tra la pagina di login e quella di verifica (solo in memoria).
const pendingChallenge = ref<string | null>(null);
const pendingRedirect = ref<string | null>(null);

export function useAuthFlow() {
  const session = useSessionStore();

  /** Applica l'esito di un accesso e porta l'utente alla pagina giusta. */
  async function finish(payload: AuthFieldsFragment, router: Router, redirect?: string | null) {
    const status = session.applyAuth(payload);
    if (status === 'TWO_FACTOR_REQUIRED') {
      pendingChallenge.value = payload.challengeToken ?? null;
      pendingRedirect.value = redirect ?? null;
      await router.push({ name: 'two-factor' });
      return;
    }
    pendingChallenge.value = null;
    const target = redirect ?? pendingRedirect.value;
    pendingRedirect.value = null;
    await router.replace(target && target.startsWith('/') ? target : landing());
  }

  function landing() {
    if (session.needsTwoFactor) return { name: 'security' };
    return session.clubId ? { name: 'home' } : { name: 'clubs' };
  }

  return { pendingChallenge, finish, landing };
}
