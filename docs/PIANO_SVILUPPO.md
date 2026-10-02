# 🛠 Huddle – Piano di sviluppo

Piano operativo per web app e mobile app, derivato da [README](../README.md). Traduce la roadmap in fasi, epiche e sprint, con la ripartizione del lavoro tra backend, web e mobile.

---

## 1. Assunzioni

Da confermare o correggere: cambiano tempi e parallelismo, non la sequenza.

| Tema | Assunzione |
|---|---|
| Team | 2 backend, 1 frontend web, 2 mobile (Flutter), 1 designer UX/UI part-time, 1 QA part-time, 1 product owner |
| Cadenza | Sprint di 2 settimane, demo e retrospettiva a fine sprint |
| Disciplina di partenza | Calcio (terminologia, ruoli, distinta gara); modello dati generico per estendere ad altri sport |
| Lingue al lancio | Italiano + inglese (i18n predisposto dal primo giorno) |
| Clienti pilota | 2–3 società ASD reali coinvolte da fine Fase 1 |

---

## 2. Decisioni architetturali (da chiudere in Fase 0)

| Area | Scelta proposta | Motivo |
|---|---|---|
| Repository | Monorepo: `apps/api` (NestJS), `apps/web` (Vue 3 + Vite), `apps/mobile` (Flutter), `packages/graphql-schema` | Schema GraphQL unico, versioning e CI condivisi |
| API | GraphQL code-first (NestJS) con accesso dati via Kysely; codegen tipizzato per Vue (`graphql-codegen`) e Flutter (`graphql_codegen`) | Tipi coerenti tra i tre client, niente drift manuale |
| Multi-tenancy | Schema condiviso con `tenant_id` su ogni tabella + **Row Level Security** PostgreSQL | Isolamento garantito dal database, non solo dal codice |
| Autorizzazione | RBAC con scope per squadra (`ruolo × squadra`), policy centralizzate nel backend | Un allenatore vede solo i propri gruppi (requisito README) |
| Autenticazione | Modulo interno: e-mail + password per staff, magic link/OTP per famiglie, **2FA obbligatorio** per admin e segreteria | Onboarding facile per genitori, sicurezza per ruoli sensibili |
| Tempo reale | GraphQL subscriptions (`graphql-ws`) + Redis pub/sub | Chat e conferme convocazioni live, scalabile su più istanze |
| Job asincroni | BullMQ su Redis | Promemoria, solleciti, scadenze certificati, generazione PDF |
| Mobile offline | SQLite locale (`drift`) + coda di sincronizzazione (outbox) | Presenze ed eventi di gara a bordo campo senza rete |
| Notifiche | FCM (Android + iOS via APNs), e-mail transazionali, SMS solo per convocazioni urgenti | Costi SMS contenuti |
| Storage | Object storage S3-compatibile in UE, file sanitari cifrati, URL firmati a scadenza breve | Dati sanitari = categoria particolare GDPR |
| Hosting | Cloud UE (es. Hetzner, OVH, Scaleway), container Docker, Postgres gestito con backup PITR | Residenza dati UE |
| Osservabilità | OpenTelemetry, Sentry (web, mobile, api), log di audit su tabella dedicata | Debug e tracciabilità operazioni sensibili |

**Una sola app mobile, non due.** Stessa app per staff, atleti e genitori, con interfaccia adattata al ruolo e selettore di contesto (società / squadra / figlio). Motivo: molte persone hanno più ruoli (genitore e dirigente accompagnatore, allenatore di una squadra e genitore in un'altra).

### Ripartizione delle funzionalità per piattaforma

| Area | Web (segreteria, DS, admin) | App – staff tecnico | App – atleti e genitori |
|---|---|---|---|
| Configurazione società, stagioni, utenti | ● | | |
| Anagrafiche, tesseramenti, certificati | ● | consultazione | caricamento certificato, dati propri |
| Squadre e rose | ● | ● | consultazione |
| Calendario allenamenti e gare | ● | ● | ● |
| Presenze | consultazione/report | ● (anche offline) | |
| Convocazioni | ● | ● | conferma/assenza |
| Chat e bacheca | ● | ● | ● |
| Pagamenti e ricevute | ● | | pagamento e storico |
| Libreria esercizi e pianificazione | ● (editing completo) | consultazione e uso in seduta | |
| Eventi di gara e statistiche | ● | ● (live, offline) | statistiche personali |
| Impianti e planner | ● | consultazione | |
| Dashboard e report | ● | dashboard allenatore | |

---

## 3. Panoramica fasi

| Fase | Durata | Sprint | Rilascio |
|---|---|---|---|
| 0 – Fondamenta | 6 settimane | S1–S3 | Ambiente staging, login, società e utenti |
| 1 – MVP | 14 settimane | S4–S10 | Beta chiusa con società pilota, app su TestFlight / Play test interno |
| 1b – Hardening e lancio | 4 settimane | S11–S12 | Pubblicazione store, prima versione commerciale |
| 2 – Amministrazione | 10–12 settimane | S13–S18 | Pagamenti, moduli firmati, impianti |
| 3 – Area tecnica avanzata | 12 settimane | S19–S24 | Esercizi, programmazione, valutazioni, statistiche |
| 4 – Estensioni | continuativa | S25+ | Moduli a priorità variabile |

Totale fino al lancio commerciale: circa **6 mesi**. Fino a Fase 3 completa: circa **12 mesi**.

---

## 4. Fase 0 – Fondamenta (S1–S3)

> **Stato:** criterio di uscita raggiunto e verificato; restano voci di infrastruttura e conformità elencate in [FASE_0.md](FASE_0.md) (CI da eseguire, testi informativa, staging e segreti, FCM, Sentry client, backup).

Obiettivo: tutto ciò che è costoso cambiare dopo. Nessuna funzionalità di dominio oltre a società e utenti.

| Sprint | Backend | Web | Mobile | Trasversale |
|---|---|---|---|---|
| **S1** | Scaffolding NestJS, Postgres + migrazioni, struttura moduli | Scaffolding Vue 3, router, i18n, layout base | Scaffolding Flutter, flavors dev/staging/prod, i18n | Monorepo, CI (lint, test, build), Docker Compose locale, design system: palette, tipografia, componenti base |
| **S2** | Tenancy + RLS, modello utenti/ruoli/scope, auth (login, refresh token, magic link, 2FA) | Login, recupero password, 2FA, shell applicativa | Login, magic link (deep link), storage sicuro token, selettore contesto | Ambiente staging su cloud UE, gestione segreti, Sentry |
| **S3** | Società, stagioni, inviti utenti, audit log, codegen GraphQL | Profilo società, gestione stagioni, inviti e permessi | Registrazione push FCM, schermata profilo, gestione multi-ruolo | Registro consensi GDPR, informative, policy di backup; test E2E di base (Playwright web, integration test Flutter) |

**Uscita Fase 0:** un admin crea la società, invita un allenatore e un genitore; ognuno accede da web o app vedendo solo ciò che gli compete. Test automatici verificano l'isolamento tra tenant.

---

## 5. Fase 1 – MVP (S4–S10)

Scope dal README: anagrafiche, squadre, certificati medici, calendario allenamenti e gare, presenze, convocazioni con conferma, chat di squadra, bacheca, app mobile base.

### Epiche

| ID | Epica | Contenuto | Piattaforme |
|---|---|---|---|
| E1 | Anagrafiche | Schede atleti/staff/dirigenti, legame atleta ↔ genitori, import da Excel/CSV | Web; app in sola lettura |
| E2 | Tesseramenti e certificati | Tessere federali con scadenza, certificati (agonistico/non agonistico) con upload cifrato, **blocco automatico convocabilità**, promemoria scadenza | Web; upload certificato da app famiglie |
| E3 | Squadre e rose | Squadre per categoria/stagione, assegnazione atleti e staff, stato atleta (disponibile, infortunato, squalificato, certificato scaduto) | Web + app staff |
| E4 | Calendario | Allenamenti ricorrenti con eccezioni, gare, eventi; vista per squadra e personale; export iCal per Google/Apple Calendar | Web + app |
| E5 | Presenze | Appello rapido (presente, assente, giustificato, infortunato, ritardo), **funzionamento offline**, report per atleta/squadra | App staff; report su web |
| E6 | Convocazioni | Creazione da gara, evidenza non convocabili, invio push/e-mail, conferma da atleta/genitore, promemoria automatici, riepilogo live, distinta gara PDF | App staff + web; conferma da app famiglie |
| E7 | Comunicazione | Chat di squadra e canali, bacheca con conferma lettura, regole tutela minori (niente 1-a-1 adulto–minore, genitori visibili) | Web + app |
| E8 | Notifiche | Centro notifiche in-app, preferenze per tipo di evento | App + web |

### Piano sprint

| Sprint | Backend | Web | Mobile |
|---|---|---|---|
| **S4** | E1 anagrafiche, legami familiari, import CSV | E1 liste, schede, import guidato | Dettaglio profilo personale e figli |
| **S5** | E2 tesseramenti, certificati, job scadenze; E3 squadre | E2 gestione certificati e scadenziario; E3 squadre e rose | E3 rosa squadra (staff); upload certificato (famiglie) |
| **S6** | E4 calendario con ricorrenze ed eccezioni, iCal | E4 calendario società e squadre | E4 calendario personale e di squadra |
| **S7** | E5 presenze + API di sincronizzazione offline | E5 report presenze | E5 appello offline-first (drift + outbox) |
| **S8** | E6 convocazioni, regole convocabilità, promemoria | E6 convocazioni e distinta PDF | E6 creazione convocazione (staff), conferma (famiglie) |
| **S9** | E7 chat (subscriptions), bacheca, moderazione | E7 bacheca e comunicazioni broadcast | E7 chat e bacheca, notifiche push |
| **S10** | E8 preferenze notifiche, ottimizzazioni query | Dashboard essenziale segreteria | E8 centro notifiche; build beta su TestFlight / Play test interno |

**Uscita Fase 1:** società pilota gestisce una settimana reale (allenamenti, presenze, una convocazione per gara, comunicazioni) senza Excel né WhatsApp.

---

## 6. Fase 1b – Hardening e lancio (S11–S12)

- Correzioni dal feedback delle società pilota.
- Test di carico (picchi tipici: venerdì sera, convocazioni del weekend), test di sicurezza e penetration test esterno.
- Accessibilità (WCAG 2.1 AA su web, dimensioni dinamiche e screen reader su app).
- Pubblicazione store:
  - account sviluppatore Apple e Google intestati a persona giuridica;
  - dichiarazioni privacy (App Privacy di Apple, Data Safety di Google);
  - app destinata ad adulti e famiglie, **non** alla categoria Kids: i minori accedono con account collegato al genitore;
  - pagina di supporto e informativa privacy pubbliche.
- Onboarding self-service per nuove società, documentazione utente, materiali di formazione.
- Monitoraggio: dashboard di errori, tempi di risposta, consegna notifiche.

---

## 7. Fase 2 – Amministrazione (S13–S18)

| Epica | Backend | Web | Mobile |
|---|---|---|---|
| Piani quote | Piani annuali/rate, sconti fratelli, agevolazioni | Configurazione piani e assegnazione | Visualizzazione quote dovute |
| Pagamenti online | Integrazione Stripe (carta, SEPA), webhook, riconciliazione, contanti | Registro incassi, riconciliazione | Pagamento in-app e storico |
| Ricevute e solleciti | Generazione ricevute (anche per detrazione spese sportive figli), solleciti automatici | Gestione ricevute ed export commercialista | Download ricevute |
| Moduli e firma | Moduli configurabili, firma elettronica semplice con tracciamento, autorizzazioni trasferte | Editor moduli e stato firme | Compilazione e firma |
| Prima nota | Entrate/uscite per centro di costo, compensi collaboratori | Prima nota, report economici | — |
| Impianti | Anagrafica impianti, planner con rilevamento conflitti, richieste cambio orario | Planner occupazione | Consultazione e richieste |

Nota: i pagamenti per servizi sportivi passano dal sito o da un link esterno ove necessario; verificare in fase di design le regole degli store sugli acquisti in-app per evitare rifiuti in revisione.

---

## 8. Fase 3 – Area tecnica avanzata (S19–S24)

| Epica | Contenuto | Piattaforme |
|---|---|---|
| Libreria esercizi | Esercizi con schema grafico, video, materiali, tag; condivisione nella società | Editing web, consultazione app |
| Pianificazione | Sedute con fasi, microcicli e mesocicli, vista stagionale | Web; seduta del giorno in app |
| Valutazioni | Schede personalizzabili, condivisione selettiva con atleta/famiglia | Web + app staff |
| Carichi e RPE | Raccolta RPE post-seduta da app atleta, grafici carico | App atleta + web |
| Infortuni | Registro, tempi di recupero, rientro graduale; accesso ristretto | Web + app staff |
| Partite | Formazioni, eventi di gara live e offline, minutaggi, statistiche, squalifiche automatiche, report post-partita | App staff (live) + web |
| Report | Dashboard presidente e allenatore complete, export PDF/Excel | Web |

---

## 9. Fase 4 – Estensioni (backlog prioritizzato)

Ordine proposto, da rivedere con i dati d'uso:

1. **Check-in QR**, **registrazione volontari**, **widget sito pubblico** — sforzo basso, valore alto.
2. **Promemoria meteo** — job schedulato su API meteo per allenamenti all'aperto.
3. **Lavagna tattica** e **gestione tornei**.
4. **Video analisi** (richiede transcoding e storage dedicato: valutare costi prima).
5. **E-commerce**, **camp estivi**, **scouting**.
6. **Funzionalità AI** (assistente allenatore, report post-partita automatico, rischio infortuni) — dopo almeno una stagione di dati raccolti.
7. **Integrazioni federali** — dipende dalla disponibilità di API ufficiali.

---

## 10. Qualità e processo

**Definition of Done** di ogni storia:

- test automatici (unit backend, componenti web, widget Flutter) e, per i flussi critici, test E2E;
- test di isolamento tenant e permessi per ogni nuova query/mutation;
- testi tradotti in italiano e inglese;
- funzionante su web desktop, web mobile, iOS e Android dove previsto;
- voce nel log di audit per operazioni su pagamenti e dati sanitari;
- revisione del codice da almeno una persona.

**Flussi E2E da proteggere sempre:** login e 2FA, convocazione → conferma → distinta, appello offline → sincronizzazione, pagamento → ricevuta (da Fase 2).

**Rilasci:** web e API in continuous delivery su staging, rilascio in produzione a fine sprint. App mobile: build interne a ogni merge, rilascio store ogni 2–4 settimane, feature flag per attivare moduli per singola società.

---

## 11. Metriche di successo

| Metrica | Obiettivo a 3 mesi dal lancio |
|---|---|
| Tasso di risposta alle convocazioni entro 24 h | > 80% |
| Allenatori che registrano le presenze in app | > 70% delle sedute |
| Famiglie attivate (almeno un accesso) | > 75% degli iscritti |
| Tempo medio per creare una convocazione | < 2 minuti |
| Crash-free sessions app | > 99,5% |

---

## 12. Rischi principali

| Rischio | Mitigazione |
|---|---|
| Adozione bassa da parte delle famiglie | Onboarding con magic link, nessuna password, valore immediato (calendario e convocazioni) |
| Sincronizzazione offline complessa | Limitare l'offline a presenze ed eventi di gara; regole di conflitto semplici (ultimo scrittore vince per campo, log dei conflitti) |
| Dati sanitari e minori | RLS, cifratura, audit log, DPIA prima del lancio, consulenza legale su informative |
| Revisione degli store | Coinvolgere presto TestFlight / Play test, verificare regole su pagamenti e account di minori |
| Scope creep dalle società pilota | Backlog unico gestito dal product owner, richieste valutate a fine fase |

---

## 13. Decisioni aperte

1. Composizione reale del team e budget: determina se le fasi 2 e 3 possono procedere in parallelo.
2. Disciplina sportiva di partenza (calcio o multi-sport fin da subito).
3. Modello di prezzo (per atleta, per squadra, a fasce) e se i pagamenti delle quote prevedono commissioni per la piattaforma.
4. Provider di firma elettronica (firma semplice interna o servizio esterno).
5. Provider SMS e cloud UE definitivi.
