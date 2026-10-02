<script setup lang="ts">
import LocaleSwitcher from '@/components/LocaleSwitcher.vue';
</script>

<template>
  <div class="auth">
    <aside class="auth__brand">
      <div class="logo">
        <img src="/favicon.svg" alt="" width="36" height="36" />
        <span>Huddle</span>
      </div>
      <p class="auth__tagline">{{ $t('brand.tagline') }}</p>
    </aside>
    <main class="auth__main">
      <div class="auth__panel">
        <RouterView />
      </div>
      <LocaleSwitcher class="auth__locale" />
    </main>
  </div>
</template>

<style scoped>
.auth {
  min-height: 100dvh;
  display: grid;
  grid-template-columns: minmax(280px, 40%) 1fr;
}
.auth__brand {
  background:
    radial-gradient(circle at 80% 110%, color-mix(in srgb, var(--accent) 22%, transparent), transparent 55%),
    var(--sidebar-bg);
  color: #fff;
  padding: var(--space-7);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.logo {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  font-family: var(--font-display);
  font-size: var(--text-xl);
  font-weight: 800;
  letter-spacing: -0.02em;
}
.auth__tagline {
  font-family: var(--font-display);
  font-size: 2.5rem;
  font-weight: 700;
  line-height: 1.1;
  max-width: 12ch;
  color: var(--accent);
}
.auth__main {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--space-6) var(--space-4);
  gap: var(--space-5);
}
.auth__panel {
  width: 100%;
  max-width: 420px;
}
@media (max-width: 860px) {
  .auth {
    grid-template-columns: 1fr;
    grid-template-rows: auto 1fr;
  }
  .auth__brand {
    padding: var(--space-4) var(--space-4);
    flex-direction: row;
    align-items: center;
  }
  .auth__tagline {
    display: none;
  }
  .auth__main {
    justify-content: flex-start;
  }
}
</style>
