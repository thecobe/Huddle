import { createRouter, createWebHistory } from 'vue-router';
import { useSessionStore } from '@/stores/session';

declare module 'vue-router' {
  interface RouteMeta {
    /** Pagina accessibile senza login. */
    public?: boolean;
    /** Solo per chi non ha effettuato l'accesso (login, registrazione). */
    guestOnly?: boolean;
    /** Richiede una società selezionata. */
    requiresClub?: boolean;
  }
}

export const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: () => import('@/layouts/AuthLayout.vue'),
      meta: { public: true },
      children: [
        { path: 'login', name: 'login', component: () => import('@/pages/auth/LoginPage.vue'), meta: { public: true, guestOnly: true } },
        { path: 'register', name: 'register', component: () => import('@/pages/auth/RegisterPage.vue'), meta: { public: true, guestOnly: true } },
        { path: 'auth/2fa', name: 'two-factor', component: () => import('@/pages/auth/TwoFactorPage.vue'), meta: { public: true } },
        { path: 'auth/magic', name: 'magic-link', component: () => import('@/pages/auth/MagicLinkPage.vue'), meta: { public: true } },
        { path: 'auth/forgot-password', name: 'forgot-password', component: () => import('@/pages/auth/ForgotPasswordPage.vue'), meta: { public: true, guestOnly: true } },
        { path: 'auth/reset-password', name: 'reset-password', component: () => import('@/pages/auth/ResetPasswordPage.vue'), meta: { public: true } },
        { path: 'invitations/accept', name: 'accept-invitation', component: () => import('@/pages/auth/AcceptInvitationPage.vue'), meta: { public: true } },
        { path: 'clubs', name: 'clubs', component: () => import('@/pages/ClubsPage.vue'), meta: { public: false } },
      ],
    },
    {
      path: '/app',
      component: () => import('@/layouts/AppLayout.vue'),
      meta: { requiresClub: true },
      children: [
        { path: '', name: 'home', component: () => import('@/pages/app/HomePage.vue') },
        { path: 'club', name: 'club', component: () => import('@/pages/app/ClubProfilePage.vue') },
        { path: 'seasons', name: 'seasons', component: () => import('@/pages/app/SeasonsPage.vue') },
        { path: 'people', name: 'people', component: () => import('@/pages/app/people/PeoplePage.vue') },
        { path: 'people/new', name: 'person-new', component: () => import('@/pages/app/people/PersonPage.vue') },
        { path: 'people/import', name: 'people-import', component: () => import('@/pages/app/people/PeopleImportPage.vue') },
        { path: 'people/:id', name: 'person', component: () => import('@/pages/app/people/PersonPage.vue') },
        { path: 'teams', name: 'teams', component: () => import('@/pages/app/teams/TeamsPage.vue') },
        { path: 'teams/:id', name: 'team', component: () => import('@/pages/app/teams/TeamPage.vue') },
        { path: 'members', name: 'members', component: () => import('@/pages/app/MembersPage.vue') },
        { path: 'audit', name: 'audit', component: () => import('@/pages/app/AuditPage.vue') },
      ],
    },
    {
      path: '/account',
      component: () => import('@/layouts/AppLayout.vue'),
      children: [
        { path: '', redirect: { name: 'profile' } },
        { path: 'profile', name: 'profile', component: () => import('@/pages/account/ProfilePage.vue') },
        { path: 'security', name: 'security', component: () => import('@/pages/account/SecurityPage.vue') },
        { path: 'privacy', name: 'privacy', component: () => import('@/pages/account/PrivacyPage.vue') },
      ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/app' },
  ],
});

router.beforeEach(async (to) => {
  const session = useSessionStore();
  await session.bootstrap();
  // to.meta unisce i meta dei record annidati: il figlio può ridefinire `public` del layout.
  if (!session.isAuthenticated) {
    return to.meta.public ? true : { name: 'login', query: { redirect: to.fullPath } };
  }
  if (to.meta.guestOnly) return session.clubId ? { name: 'home' } : { name: 'clubs' };
  if (to.matched.some((r) => r.meta.requiresClub)) {
    if (!session.clubId) return { name: 'clubs' };
    // I ruoli amministrativi devono attivare il 2FA prima di operare sulla società.
    if (session.needsTwoFactor) return { name: 'security' };
  }
  return true;
});
