import path from 'node:path';
import { fileURLToPath } from 'node:url';

process.loadEnvFile(path.join(path.dirname(fileURLToPath(import.meta.url)), '..', '.env.test'));
