import { writeFileSync } from 'node:fs';
import { NestFactory } from '@nestjs/core';
import { GraphQLSchemaHost } from '@nestjs/graphql';
import { lexicographicSortSchema, printSchema } from 'graphql';
import { AppModule } from './app.module.js';

// Genera packages/graphql-schema/schema.graphql senza avviare il server HTTP.
const app = await NestFactory.create(AppModule, { logger: ['error'] });
await app.init();
const { schema } = app.get(GraphQLSchemaHost);
writeFileSync(new URL('../../../packages/graphql-schema/schema.graphql', import.meta.url), printSchema(lexicographicSortSchema(schema)));
await app.close();
console.log('Schema GraphQL aggiornato');
