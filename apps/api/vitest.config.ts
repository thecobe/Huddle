import { createRequire } from 'node:module';
import { defineConfig } from 'vitest/config';

const require = createRequire(import.meta.url);

export default defineConfig({
  // Decorator legacy con metadata: servono alla dependency injection di Nest.
  oxc: {
    decorator: { legacy: true, emitDecoratorMetadata: true },
  },
  resolve: {
    // graphql 16 ha un campo `module` che Vite preferisce, mentre Nest carica la build CommonJS:
    // due istanze del modulo rompono i controlli instanceof sugli scalari personalizzati.
    alias: [{ find: /^graphql$/, replacement: require.resolve('graphql') }],
  },
  test: {
    include: ['src/**/*.spec.ts', 'test/**/*.spec.ts'],
    globalSetup: ['test/global-setup.ts'],
    setupFiles: ['test/load-env.ts'],
    fileParallelism: false,
    testTimeout: 20000,
  },
});
