<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import LocaleSwitcher from '@/components/LocaleSwitcher.vue';
import { HAlert } from '@/components/ui';
import type { Permission } from '@/permissions';
import { useSessionStore } from '@/stores/session';

const session = useSessionStore();
const router = useRouter();
const route = useRoute();
const menuOpen = ref(false);

watch(() => route.fullPath, () => (menuOpen.value = false));

interface NavItem {
  name: string;
  label: string;
  permission?: Permission;
}

const clubNav = computed<NavItem[]>(() =>
  (
    [
      { name: 'home', label: 'nav.club' },
      { name: 'club', label: 'club.title' },
      { name: 'seasons', label: 'nav.seasons' },
      { name: 'teams', label: 'nav.teams' },
      { name: 'people', label: 'nav.people' },
      { name: 'members', label: 'nav.members', permission: 'member.view' },
      { name: 'audit', label: 'nav.audit', permission: 'audit.view' },
    ] as NavItem[]
  ).filter((i) => !i.permission || session.allowed(i.permission)),
);

const accountNav: NavItem[] = [
  { name: 'profile', label: 'nav.profile' },
  { name: 'security', label: 'nav.security' },
  { name: 'privacy', label: 'nav.privacy' },
];

async function logout() {
  await session.logout();
  await router.replace({ name: 'login' });
}
</script>

<template>
  <div class="shell">
    <header class="topbar">
      <button class="topbar__menu" type="button" :aria-expanded="menuOpen" aria-controls="sidebar" @click="menuOpen = !menuOpen">
        <span class="sr-only">{{ $t('nav.menu') }}</span>
        <svg width="22" height="22" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h18M3 12h18M3 18h18" stroke="currentColor" stroke-width="2" stroke-linecap="round" /></svg>
      </button>
      <span class="topbar__club">{{ session.currentClub?.name ?? 'Huddle' }}</span>
    </header>

    <nav id="sidebar" class="sidebar" :class="{ open: menuOpen }">
      <RouterLink :to="{ name: 'clubs' }" class="sidebar__club">
        <img src="/favicon.svg" alt="" width="32" height="32" />
        <span>
          <strong>{{ session.currentClub?.name ?? 'Huddle' }}</strong>
          <small>{{ $t('nav.switchClub') }}</small>
        </span>
      </RouterLink>

      <ul v-if="session.currentClub" class="sidebar__list">
        <li v-for="item in clubNav" :key="item.name">
          <!-- Le sottopagine (es. scheda di una persona) evidenziano la voce di sezione. -->
          <RouterLink :to="{ name: item.name }" :active-class="item.name === 'home' ? '' : 'active'" exact-active-class="active">
            {{ $t(item.label) }}
          </RouterLink>
        </li>
      </ul>

      <p class="sidebar__section">{{ $t('nav.account') }}</p>
      <ul class="sidebar__list">
        <li v-for="item in accountNav" :key="item.name">
          <RouterLink :to="{ name: item.name }" exact-active-class="active">{{ $t(item.label) }}</RouterLink>
        </li>
      </ul>

      <div class="sidebar__footer">
        <span class="sidebar__user">{{ session.user?.fullName }}</span>
        <div class="row">
          <LocaleSwitcher class="sidebar__locale" />
          <button type="button" class="sidebar__logout" @click="logout">{{ $t('nav.logout') }}</button>
        </div>
      </div>
    </nav>
    <div v-if="menuOpen" class="scrim" @click="menuOpen = false" />

    <main class="content">
      <HAlert v-if="session.needsTwoFactor && route.name !== 'security'" tone="warning" class="content__alert">
        {{ $t('security.twoFactorRequired') }}
        <RouterLink :to="{ name: 'security' }">{{ $t('security.setup') }}</RouterLink>
      </HAlert>
      <RouterView />
    </main>
  </div>
</template>

<style scoped>
.shell {
  min-height: 100dvh;
  display: grid;
  grid-template-columns: 248px 1fr;
}
.topbar {
  display: none;
}
.sidebar {
  background: var(--sidebar-bg);
  color: var(--sidebar-text);
  padding: var(--space-4) var(--space-3);
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  position: sticky;
  top: 0;
  height: 100dvh;
}
.sidebar__club {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-2);
  border-radius: var(--radius);
  color: #fff;
  margin-bottom: var(--space-3);
}
.sidebar__club:hover {
  background: var(--sidebar-active);
  text-decoration: none;
}
.sidebar__club span {
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.sidebar__club strong {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.sidebar__club small {
  color: var(--accent);
  font-size: var(--text-xs);
}
.sidebar__section {
  margin: var(--space-4) var(--space-3) var(--space-1);
  font-size: var(--text-xs);
  text-transform: uppercase;
  letter-spacing: 0.06em;
  opacity: 0.6;
}
.sidebar__list {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}
.sidebar__list a {
  display: block;
  padding: var(--space-2) var(--space-3);
  border-radius: var(--radius-sm);
  color: var(--sidebar-text);
  font-size: var(--text-sm);
  font-weight: 500;
}
.sidebar__list a:hover {
  background: var(--sidebar-active);
  text-decoration: none;
}
.sidebar__list a.active {
  background: var(--sidebar-active);
  color: #fff;
  box-shadow: inset 3px 0 0 var(--accent);
}
.sidebar__footer {
  margin-top: auto;
  padding: var(--space-3);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  font-size: var(--text-sm);
}
.sidebar__user {
  color: #fff;
  font-weight: 600;
}
.sidebar__locale :deep(button) {
  color: var(--sidebar-text);
}
.sidebar__locale :deep(button.active) {
  background: var(--sidebar-active);
  color: #fff;
}
.sidebar__logout {
  margin-left: auto;
  background: none;
  border: none;
  color: var(--sidebar-text);
  font: inherit;
  cursor: pointer;
  text-decoration: underline;
}
.content {
  padding: var(--space-6) var(--space-6) var(--space-7);
  max-width: 1080px;
  width: 100%;
  /* Senza, le tabelle larghe allargano la colonna e la pagina scorre in orizzontale. */
  min-width: 0;
}
.content__alert {
  margin-bottom: var(--space-5);
}
.scrim {
  display: none;
}

@media (max-width: 860px) {
  .shell {
    grid-template-columns: 1fr;
  }
  .topbar {
    display: flex;
    align-items: center;
    gap: var(--space-3);
    position: sticky;
    top: 0;
    z-index: 20;
    background: var(--sidebar-bg);
    color: #fff;
    padding: var(--space-2) var(--space-3);
  }
  .topbar__menu {
    background: none;
    border: none;
    color: inherit;
    padding: var(--space-2);
    cursor: pointer;
  }
  .topbar__club {
    font-weight: 700;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  .sidebar {
    position: fixed;
    inset: 0 auto 0 0;
    width: min(300px, 85vw);
    z-index: 40;
    transform: translateX(-100%);
    transition: transform 0.2s ease;
  }
  .sidebar.open {
    transform: none;
  }
  .scrim {
    display: block;
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.4);
    z-index: 30;
  }
  .content {
    padding: var(--space-5) var(--space-4) var(--space-7);
  }
}
</style>
