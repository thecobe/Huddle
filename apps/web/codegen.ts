import type { CodegenConfig } from '@graphql-codegen/cli';

const config: CodegenConfig = {
  schema: '../../packages/graphql-schema/schema.graphql',
  documents: ['src/**/*.vue', 'src/**/*.ts', '!src/gql/**/*'],
  ignoreNoDocuments: true,
  generates: {
    './src/gql/': {
      preset: 'client',
      config: {
        useTypeImports: true,
        enumsAsTypes: true,
        scalars: { DateTime: 'string', JSON: 'unknown' },
      },
      presetConfig: { fragmentMasking: false },
    },
  },
};

export default config;
