import './instrument.js';
import { NestFactory } from '@nestjs/core';
import type { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module.js';
import { configureApp } from './bootstrap.js';
import { loadEnv } from './config/env.js';

const env = loadEnv();
const app = await NestFactory.create<NestExpressApplication>(AppModule);
// Dietro un reverse proxy: IP reale del client per audit log e rate limiting.
app.set('trust proxy', 1);
configureApp(app, env);
await app.listen(env.PORT);
console.log(`Huddle API su http://localhost:${env.PORT}/graphql`);
