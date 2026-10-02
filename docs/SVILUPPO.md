# Sviluppo locale

## Requisiti

- Node.js 22+ e pnpm (versione in `package.json` → `packageManager`)
- Docker (PostgreSQL, Redis, Mailpit)
- Flutter 3.47+ per l'app mobile (serve il supporto UIScene richiesto da iOS 27); Xcode 27 per iOS;
  Android SDK 36 + JDK 21 per Android (`flutter config --jdk-dir <percorso JDK 21>`)

## Avvio

```bash
pnpm install
pnpm dev:infra                     # PostgreSQL :5433, Redis :6379, Mailpit :8025
cp .env.example apps/api/.env
pnpm db:migrate
pnpm dev:api                       # http://localhost:4000/graphql
pnpm dev:web                       # http://localhost:5173
pnpm dev:mobile                    # app su simulatore/emulatore
```

Le e-mail (magic link, inviti, reset password) arrivano su Mailpit: http://localhost:8025.

Dati demo (società con stagione aperta, due squadre, atleti con tutori, un allenatore e un genitore con account),
con API in esecuzione:

```bash
pnpm --filter @huddle/api seed:demo   # stampa credenziali, segreto 2FA dell'admin e magic link per l'app
```

La demo include allenamenti ricorrenti per due squadre e una gara il sabato successivo.

## Calendario e fuso orario

Gli orari si salvano in UTC; date e ore locali usano `clubs.timezone` (predefinito `Europe/Rome`). Le occorrenze
degli allenamenti ricorrenti sono generate dal database (`CalendarService.generate`), che gestisce il cambio
dell'ora legale. Il web converte con `src/lib/zoned.ts`; l'app mostra l'ora del dispositivo.
I link iCal sono serviti da `GET /calendar/<token>.ics` (in sviluppo Vite inoltra `/calendar` all'API).

Emulatore Android: l'API locale è raggiungibile su `10.0.2.2`, quindi avviare con
`--dart-define=API_URL=http://10.0.2.2:4000/graphql`.

## Struttura

| Cartella | Contenuto |
|---|---|
| `apps/api` | NestJS 12, GraphQL code-first (Apollo), Kysely su PostgreSQL |
| `apps/web` | Vue 3, Vite, urql, Pinia, vue-i18n |
| `apps/mobile` | Flutter, Riverpod, go_router, client `graphql` |
| `packages/graphql-schema` | Schema GraphQL generato dall'API, fonte per i client |
| `infra/postgres` | Ruoli database (eseguito alla creazione del volume) |

## Multi-tenancy e sicurezza dei dati

- Ogni tabella di società ha `tenant_id` e una policy **Row Level Security**.
- L'API si connette come `huddle_app`, ruolo senza `BYPASSRLS`; le migrazioni girano come `huddle_owner`.
- Ogni resolver GraphQL gira in una transazione che imposta `app.user_id` e `app.tenant_id`
  (`DbContext` + `DbScopeInterceptor`). La società arriva dall'header `X-Tenant-Id`, ma viene usata solo
  dopo che `AccessGuard` ha verificato l'appartenenza dell'utente.
- I permessi sono per ruolo (`apps/api/src/permissions/permissions.ts`). La visibilità di persone e squadre
  (`apps/api/src/people/visibility.service.ts`): direzione e segreteria vedono tutto, lo staff le proprie squadre
  e i tutori dei propri atleti, ogni utente la propria scheda e quelle dei minori di cui è tutore.
  Codice fiscale, indirizzo e note sono visibili solo a segreteria, alla persona e ai suoi tutori.
- Gli accessi di squadra di allenatori e dirigenti derivano dalle rose (`team_staff`): aggiungere o togliere una
  persona dallo staff aggiorna i suoi permessi.
- **Le chiavi esterne non applicano la RLS:** prima di collegare righe con id ricevuti dal client, usare
  `assertInTenant` (`apps/api/src/database/tenant-guard.ts`), altrimenti si possono collegare dati di un'altra società.
- Amministratori e segreteria devono attivare il 2FA prima di operare sulla società.
- Gli eventi di errore (login fallito, riuso di refresh token) sono registrati in una transazione separata,
  così sopravvivono al rollback della richiesta.

## Sessioni

| Client | Access token | Refresh token |
|---|---|---|
| Web | in memoria (15 min) | cookie httpOnly `SameSite=Strict` su `/graphql`, stessa origine via proxy |
| Mobile | in memoria | Keychain / Keystore (`flutter_secure_storage`) |

I refresh token ruotano a ogni uso; il riuso di un token già ruotato revoca l'intera famiglia di sessioni.

## Codegen

Dopo una modifica allo schema API:

```bash
pnpm codegen      # schema in packages/graphql-schema, tipi web (apps/web/src/gql) e mobile (apps/mobile/lib/graphql)
```

Le operazioni mobile stanno nei file `.graphql` di `apps/mobile/lib/graphql`; `graphql_codegen` genera
variabili, risultati e `documentNode…` tipizzati. La CI fallisce se i file generati non sono aggiornati.

## Test

```bash
pnpm --filter @huddle/api test      # unit + integrazione su database huddle_test (RLS, auth, permessi)
pnpm --filter @huddle/web test      # unit
pnpm --filter @huddle/web e2e       # Playwright, desktop e mobile; richiede API e Mailpit attivi
pnpm test:mobile                    # unit e widget Flutter
```
