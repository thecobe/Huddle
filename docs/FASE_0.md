# Fase 0 – Fondamenta: stato

Riferimento: [PIANO_SVILUPPO.md](PIANO_SVILUPPO.md), sezione 4. Guida tecnica: [SVILUPPO.md](SVILUPPO.md).

## Criterio di uscita

> Un admin crea la società, invita un allenatore e un genitore; ognuno accede da web o app vedendo solo ciò
> che gli compete. Test automatici verificano l'isolamento tra tenant.

Verificato il 2026-10-02 rieseguendo tutto sullo stato attuale del codice:

- `apps/web/e2e/onboarding.spec.ts` (Playwright, desktop e smartphone): registrazione → creazione società →
  2FA obbligatorio → stagione aperta → invito allenatore via e-mail → accettazione senza password →
  l'allenatore vede la società ma non la gestione delle persone.
- `apps/api/test/rls.spec.ts`: isolamento verificato direttamente sul database con il ruolo applicativo.
- `apps/api/test/tenancy.spec.ts`, `auth.spec.ts`: permessi, inviti, 2FA, rotazione sessioni.
- `apps/mobile/test`: sessione, rinnovo token, redirect per ruolo, deep link, schermata di accesso.
- CI GitHub Actions verde sul commit `e81d1aa` (job api, web, mobile; run 37003706012).
- `apps/mobile/integration_test`: su simulatore iOS 27 contro l'API locale, magic link reale → home della società.
- Genitore (verifica manuale contro l'API): invito, accesso senza password con magic link, vede società e stagioni,
  non vede elenco persone né registro attività, non modifica la società, nessun accesso a un'altra società.
  Non ancora coperto da un test automatico.

## Consegnato

| Sprint | Area | Stato |
|---|---|---|
| S1 | Monorepo pnpm, Docker Compose (PostgreSQL, Redis, Mailpit), CI GitHub Actions | ✅ |
| S1 | Scaffolding API, web, mobile; i18n IT/EN su tutti e tre | ✅ |
| S1 | Design system web (token, componenti base, tema scuro) e tema mobile allineato | ✅ |
| S2 | Multi-tenancy con Row Level Security, ruoli `huddle_owner` / `huddle_app` | ✅ |
| S2 | Ruoli e permessi con ambito squadra predisposto | ✅ |
| S2 | Login password, magic link, reset password, 2FA TOTP con codici di recupero | ✅ |
| S2 | Refresh token a rotazione con rilevamento riuso; cookie httpOnly per il web | ✅ |
| S2 | Rate limiting sulle operazioni di accesso | ✅ |
| S3 | Società, stagioni (una sola aperta), inviti, rimozione membri (protezione ultimo admin) | ✅ |
| S3 | Registro di audit append-only, consultabile dall'amministratore | ✅ |
| S3 | Registro consensi (privacy, termini, liberatoria immagini), esportazione dati GDPR art. 15 | ✅ |
| S3 | App mobile: accesso, 2FA, deep link, scelta società, home per ruolo, registrazione dispositivo | ✅ |
| S3 | Test E2E web (Playwright) e test unit/widget Flutter | ✅ |

## Non completato in questa fase

| Voce | Motivo / prossimo passo |
|---|---|
| Testo dell'informativa privacy e dei termini | Registrazione e inviti chiedono di accettarli e salvano la versione accettata, ma i documenti non esistono ancora. Servono i testi (consulenza legale) e una pagina pubblica sul web e nell'app. |
| Ambiente di staging su cloud UE | Richiede scelta del provider (decisione aperta n. 5) e credenziali. |
| Gestione dei segreti | Oggi solo file `.env` locali. Da definire con il provider cloud insieme allo staging. |
| Firebase Cloud Messaging | Serve il progetto Firebase; l'app registra già il dispositivo, manca la sorgente del token. |
| Sentry su web e mobile | Attivo solo sull'API (con `SENTRY_DSN`). Da aggiungere quando c'è il progetto Sentry. |
| Cancellazione account (GDPR art. 17) | Implementata solo l'esportazione; la cancellazione va progettata con la conservazione dei dati contabili (Fase 2). |
| Policy di backup | Da definire con il provider cloud (PITR del database gestito). |
| Test dell'app su emulatore Android | L'APK compila (Flutter 3.47, JDK 21), ma l'emulatore installato (35.4) è troppo vecchio per l'immagine Android 36. Aggiornare il pacchetto Emulator dall'Android SDK. |
| Universal Links / App Links | Servono il dominio di produzione e i file di associazione. |

## Decisioni prese durante l'implementazione

| Tema | Scelta | Motivo |
|---|---|---|
| Accesso ai dati | Kysely (query builder tipizzato) invece di un ORM | Serve controllo esplicito di transazioni e `set_config` per la RLS. |
| Versioni | NestJS 12 (ESM), TypeScript 5.9, graphql 16 | TypeScript 7 non ancora compatibile con la toolchain Nest; Apollo 5 richiede graphql 16. |
| Codegen mobile | `graphql_codegen` da file `.graphql` in `apps/mobile/lib/graphql`, solo tipi e parser | Le richieste passano da `ApiClient` (header, rinnovo sessione, codici errore). Ruoli sconosciuti all'app vengono ignorati. |
| Query web | Sempre POST | Le GET di urql vengono bloccate dalla protezione CSRF di Apollo. |
| Sessione web | Refresh token in cookie httpOnly sulla stessa origine | Il token non è leggibile da JavaScript; in produzione API e web dietro lo stesso dominio. |
| Accesso famiglie | Account senza password, accesso con magic link | Onboarding più semplice; la password resta facoltativa. |

## Verifiche native

- **iOS 27 (simulatore):** build e avvio ok. Test di integrazione `apps/mobile/integration_test/magic_link_test.dart`
  contro l'API locale: magic link reale → accesso → home della società.
- **Android:** APK debug compilato; non eseguito su emulatore (vedi sopra).
- L'aggiornamento a Flutter 3.47 ha richiesto la rigenerazione delle cartelle `ios/` e `android/`
  (ciclo di vita UIScene richiesto da iOS 27, Gradle 9 / AGP 9).

## Bug trovati e corretti dai test

- Rollback che annullava la revoca della famiglia di sessioni in caso di riuso del refresh token.
- Registrazioni concorrenti con la stessa e-mail restituivano un errore interno invece di `EMAIL_TAKEN`.
- Schema GraphQL scritto da due processi con formati diversi (server di sviluppo e `pnpm codegen`): il controllo della CI sarebbe fallito a seconda di chi l'aveva scritto per ultimo. Ora lo scrive solo `pnpm codegen`, in modo deterministico.
- App mobile: dopo il magic link o l'accettazione dell'invito l'utente restava bloccato sulla schermata di caricamento invece di arrivare alla home.
- Su smartphone le tabelle allargavano la pagina con scorrimento orizzontale; la barra superiore copriva
  gli elementi portati in vista.
