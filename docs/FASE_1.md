# Fase 1 – MVP: piano dettagliato

Riferimenti: [PIANO_SVILUPPO.md](PIANO_SVILUPPO.md) §5, stato delle fondamenta in [FASE_0.md](FASE_0.md),
convenzioni tecniche in [SVILUPPO.md](SVILUPPO.md).

**Obiettivo.** Una società pilota gestisce una settimana reale (allenamenti, presenze, una convocazione per gara,
comunicazioni) senza Excel né WhatsApp.

**Chi sviluppa.** Due persone: Marco e Claude. Non ci sono ruoli separati per backend, web e mobile, quindi il
lavoro procede per **traguardi verticali**: ogni traguardo porta una funzione completa (database, API, web, app,
test) fino a un risultato utilizzabile, prima di passare al successivo.

---

## 1. Principi per lavorare in due

1. **Una funzione su una sola piattaforma quando basta.** La segreteria lavora dal web, staff e famiglie dall'app.
   In Fase 1 non si costruisce la stessa schermata due volte (vedi §5).
2. **Pilota presto.** Una società pilota inizia a usare Huddle già dopo il terzo traguardo (anagrafiche, calendario,
   presenze), non alla fine della fase: il riscontro arriva quando costa ancora poco cambiare.
3. **Le attività con tempi lunghi partono subito.** Account sviluppatore Apple e Google, testi legali, scelta del cloud
   e accordi con le società pilota hanno tempi che non dipendono dal codice (§6).
4. **Niente stime a calendario finché non c'è un dato reale.** Dopo il primo traguardo misuriamo quanto è servito e
   ricalibriamo. Le dimensioni indicate (S, M, L) sono relative tra loro.
5. **Ogni traguardo si chiude con:** CI verde, test end-to-end del flusso principale, tua revisione e prova
   su dispositivo reale, documentazione aggiornata.

---

## 2. Chi fa cosa

| Claude | Marco |
|---|---|
| Codice di API, web e app; migrazioni del database | Decisioni di prodotto (§3) e priorità |
| Test automatici (unità, integrazione, end-to-end) | Revisione del codice e approvazione dei traguardi |
| Documentazione tecnica e aggiornamento del piano | Prova su dispositivi reali (iPhone, Android) |
| Configurazione di CI, staging e build, una volta creati gli account | Creazione degli account: cloud, Apple Developer, Google Play, Firebase, Sentry |
| Bozze di testi per l'interfaccia ed e-mail | Testi legali con il consulente (informativa, termini, DPIA) |
| Analisi dei riscontri delle società pilota | Rapporto con le società pilota, raccolta dei riscontri |

---

## 3. Decisioni da prendere

| # | Decisione | Proposta | Serve entro |
|---|---|---|---|
| D1 | Gli atleti minorenni hanno un account proprio? | **Deciso (2026-10-02):** nessun account sotto i 14 anni (età del consenso digitale in Italia); dai 14 anni account facoltativo, attivato dal genitore. | M1 |
| D2 | Chi risponde alle convocazioni di un minore? | Qualsiasi tutore collegato; l'atleta dai 14 anni con account. Vale l'ultima risposta. | M5 |
| D3 | Una quota non pagata blocca la convocabilità? | No in Fase 1 (i pagamenti arrivano in Fase 2); regola configurabile più avanti. | M4 |
| D4 | Object storage | MinIO in sviluppo; in produzione storage S3-compatibile dello stesso provider dello staging. | M4 |
| D5 | Cloud UE per lo staging | Decisione aperta n. 5 del piano generale. | Prima del pilota (P) |
| D6 | Società pilota | Una società con un referente disponibile e almeno una squadra giovanile. | Prima del pilota (P) |
| D7 | Sistema operativo di test | Almeno un iPhone e un Android reali tra quelli usati dalle famiglie della società pilota. | M3 |

---

## 4. Modello dati

Tutte le nuove tabelle hanno `tenant_id` e una policy RLS come quelle della Fase 0. Date e orari usano il fuso
orario della società (`clubs.timezone`, nuova colonna, predefinito `Europe/Rome`).

```
clubs ─┬─ seasons ── teams ─┬─ team_staff (persona, ruolo staff)
       │                    ├─ team_players (persona, maglia, ruolo, disponibilità)
       │                    ├─ event_series ── events ─┬─ attendance (persona)
       │                    │                          └─ callups ── callup_players (persona, risposta)
       │                    └─ channels ── messages ── message_reads
       ├─ people ─┬─ guardianships (tutore ↔ minore)
       │          ├─ licenses (tesseramenti)
       │          └─ medical_certificates (file cifrato)
       ├─ announcements ── announcement_reads
       └─ notifications, notification_preferences, files
```

| Tabella | Campi principali | Note |
|---|---|---|
| `people` | nome, cognome, data e luogo di nascita, codice fiscale, sesso, contatti, indirizzo, foto, `user_id` facoltativo | Anagrafica della società, separata dagli account: molti atleti sono minori senza account. Codice fiscale unico per società. |
| `guardianships` | `minor_person_id`, `guardian_person_id`, relazione (madre, padre, tutore) | Il genitore vede i dati dei figli tramite questo legame. |
| `teams` | `season_id`, nome, categoria, anni di nascita, disciplina, colore | Il passaggio di stagione copia le squadre. |
| `team_players` | `team_id`, `person_id`, numero di maglia, ruolo in campo, `availability` (disponibile, infortunato, squalificato, altro), note | La convocabilità si calcola, non si salva. |
| `team_staff` | `team_id`, `person_id`, ruolo (allenatore, vice, preparatore, dirigente accompagnatore) | L'accesso resta in `memberships` con `team_id`, ora con chiave esterna verso `teams`. |
| `licenses` | `person_id`, federazione o ente, numero, categoria, validità da/a | |
| `medical_certificates` | `person_id`, tipo (agonistico, non agonistico), data visita, scadenza, `file_id`, verificato da/il | File cifrato; accesso solo a segreteria, amministratore e tutori del minore. |
| `files` | chiave nello storage, tipo MIME, dimensione, hash, cifrato, caricato da | Download solo tramite URL firmati di breve durata. |
| `event_series` | `team_id`, tipo, regola di ricorrenza (RRULE), orario, durata, luogo, valida da/a | Genera le occorrenze in `events`. |
| `events` | `series_id` facoltativo, `team_id`, tipo (allenamento, gara, altro), inizio, fine, luogo, stato (programmato, annullato), modificato rispetto alla serie | Le occorrenze sono salvate una per una: presenze, convocazioni e annullamenti si agganciano a una data precisa. Per le gare: avversario, casa/trasferta, competizione. |
| `attendance` | `event_id`, `person_id`, stato (presente, assente, giustificato, infortunato, ritardo), nota, registrato da/il, `client_mutation_id` | Univoco per (evento, persona); `client_mutation_id` rende idempotente la sincronizzazione offline. |
| `callups` | `event_id`, orario e luogo di ritrovo, abbigliamento, note, stato (bozza, inviata, chiusa), scadenza risposte | Una convocazione per gara. |
| `callup_players` | `callup_id`, `person_id`, risposta (in attesa, confermato, assente), motivazione, risposto da/il, convocabilità al momento dell'invio | La convocabilità viene fotografata all'invio per la tracciabilità. |
| `channels` | `team_id`, tipo (squadra, staff, genitori), nome | I membri si ricavano dai ruoli. |
| `messages` | `channel_id`, autore, testo, allegato, nascosto da/il | Nessuna cancellazione fisica durante la conservazione. |
| `message_reads` | `channel_id`, `user_id`, ultimo messaggio letto | Un record per utente e canale. |
| `announcements` | ambito (società o squadra), titolo, testo, richiede conferma, pubblicato da/il | |
| `announcement_reads` | `announcement_id`, `user_id`, letto il, confermato il | |
| `notifications` | `user_id`, tipo, titolo, testo, link in app, letta il, esito degli invii | Centro notifiche e storico. |
| `notification_preferences` | `user_id`, tipo, push sì/no, e-mail sì/no | Convocazioni e avvisi della società non disattivabili. |

---

## 5. Traguardi

Ogni traguardo elenca le storie con la piattaforma su cui vengono costruite e una dimensione relativa
(**S** piccola, **M** media, **L** grande). **API** = backend e database.

### M1 – Anagrafiche e squadre

> **Stato (2026-10-02): completato, in attesa della tua revisione e prova su dispositivo.**
> Verifiche: 57 test API (permessi, visibilità, isolamento tra società, import, regola dei 14 anni),
> e2e web su desktop e smartphone (import CSV → rosa → invito al genitore), 19 test Flutter e 2 test di
> integrazione su simulatore iOS 27 contro l'API locale (rosa per l'allenatore, figli e attivazione account per il genitore).
> Dati demo per le prove: `pnpm --filter @huddle/api seed:demo`.

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Scheda persona | La segreteria crea e modifica atleti, staff, dirigenti e volontari; codice fiscale validato e univoco nella società. | API, web | M |
| Tutori | Un minore ha uno o più tutori; il tutore si collega a un account esistente o viene invitato dalla scheda. | API, web | M |
| Persona ↔ account | All'accettazione di un invito l'account si collega alla scheda corrispondente. | API | S |
| Account atleta dai 14 anni (D1) | Un tutore (o la segreteria) attiva l'account di un atleta dai 14 anni con un invito legato alla scheda; il server rifiuta inviti con ruolo atleta senza scheda o sotto i 14 anni; l'operazione resta nel log di audit. | API, web, app | M |
| Import da Excel/CSV | Mappatura colonne, anteprima con errori per riga, nessuna scrittura prima della conferma, duplicati riconosciuti per codice fiscale. | API, web | M |
| Elenchi e ricerca | Filtri per ruolo e squadra; paginazione lato server. | API, web | S |
| Squadre e rose | Squadre per stagione con categoria e anni di nascita; atleti e staff in rosa; numero di maglia univoco; copia dalla stagione precedente. | API, web | M |
| Ambito squadra | `memberships.team_id` con chiave esterna; un allenatore vede e modifica solo le sue squadre; test di permesso per ogni nuova query. | API | M |
| Profilo e figli in app | Il genitore vede la sua scheda e quelle dei figli; lo staff vede la rosa delle sue squadre con i recapiti dei tutori. | API, app | M |

### M2 – Calendario

> **Stato (2026-10-02): completato, in attesa della tua revisione e prova su dispositivo.**
> Verifiche: 68 test API (generazione con cambio dell'ora legale, modifiche di serie che preservano le date
> modificate a mano, chiusure, permessi di allenatore e genitore, link iCal e revoca), 6 e2e web, 20 test Flutter,
> 3 test di integrazione su simulatore iOS 27 (rosa, figli, agenda con allenamenti e gara).
> Scelta: ricorrenze settimanali generate in PostgreSQL con `generate_series` e il fuso della società, senza libreria RRULE.
> Le date passate non vengono mai modificate da un cambio della serie. Il link iCal personale contiene le squadre
> proprie e dei figli (per un amministratore senza squadre solo gli eventi di società); per una squadra si usa il link di squadra.

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Allenamenti ricorrenti | Serie settimanali con giorni, orario e luogo; occorrenze per tutta la stagione; modifica di una data o di tutte le successive; corretto al cambio dell'ora legale. | API, web | L |
| Eccezioni | Annullamento di una data o di un periodo (festività, chiusura impianto). | API, web | S |
| Gare ed eventi | Gare con avversario, casa/trasferta, competizione; altri eventi. | API, web | M |
| Agenda in app | Agenda personale; per il genitore gli eventi di tutti i figli; dettaglio evento con luogo apribile nelle mappe. | API, app | M |
| Export calendario | Link iCal personale e per squadra, revocabile. | API, web, app | S |

### M3 – Presenze

> Piano dettagliato: [M3_PRESENZE.md](M3_PRESENZE.md).
>
> **Stato (2026-10-03): completato, in attesa della tua revisione e prova su dispositivo** (lista di prova in M3_PRESENZE.md §9).

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Struttura offline | Database locale (`drift`) e coda di operazioni in uscita, rinviate al ritorno della rete; conflitti registrati. | app | L |
| Appello rapido | Dall'evento del giorno, rosa con tutti presenti per default; un tocco cambia stato; nota per atleta; meno di 30 secondi per 20 atleti; funziona senza rete. | API, app | M |
| Registro presenze | Tabella atleti × date con percentuali; filtri per periodo e tipo evento; esportazione CSV. | API, web | M |
| Assenza annunciata | Il genitore segnala in anticipo un'assenza con motivo; l'appello la propone come giustificata. | API, app | S |
| Presenze del figlio (D10) | Il genitore vede in sola lettura le presenze recenti del figlio. | API, app | S |

### P – Pronti per il pilota

Dopo M3 la società pilota inizia a usare anagrafiche, calendario e presenze.

| Voce | Chi | Note |
|---|---|---|
| Staging su cloud UE, gestione dei segreti, backup con prova di ripristino | Marco crea l'account, Claude configura | Dipende da D5. |
| Build interne TestFlight e Play (test interno) | Marco crea gli account, Claude configura le build | La verifica dell'account Apple per una società può richiedere settimane: avviare subito. |
| Sentry su API, web e app | Marco crea il progetto, Claude integra | |
| Informativa privacy e termini pubblicati su web e app; DPIA | Marco con il consulente; Claude prepara la pagina | Senza testi approvati non si raccolgono dati reali. |
| Onboarding della società pilota | Marco | Import dei dati reali con l'import guidato di M1. |

### M4 – Certificati e notifiche

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Storage file e foto | MinIO in sviluppo; upload tramite URL firmato; limiti di tipo e dimensione; foto nella scheda persona. Spostato da M1: il primo uso necessario sono i certificati. | API, web, app | M |
| Code di lavoro | BullMQ su Redis, retry con backoff, stesso isolamento per società delle richieste; anche le e-mail esistenti passano dalla coda. | API | M |
| Notifiche push | FCM per Android e iOS; token non validi rimossi; nessun dato sanitario nel testo delle notifiche. | API, app | M |
| Centro notifiche | Elenco letto/non letto, link all'elemento collegato, badge. | API, app | M |
| Tesseramenti | Federazione, numero, categoria, validità; scadenziario. | API, web | S |
| Certificati | Upload cifrato, tipo, data visita, scadenza; accessi registrati nel log di audit; file visibile solo a segreteria, amministratore e tutori. | API, web | M |
| Upload dalle famiglie | Il genitore fotografa il certificato dall'app; resta da verificare finché la segreteria non lo approva. | API, app | S |
| Convocabilità | Regola unica lato server: non convocabile se certificato assente, scaduto o non verificato, oppure se infortunato o squalificato; ogni motivo esposto all'interfaccia; test su tutti i casi. | API | M |
| Disponibilità atleta | Lo staff imposta infortunato, squalificato o altro dall'app. | API, app | S |
| Promemoria scadenze | Avviso a tutori e segreteria a 30, 7 e 0 giorni; nessun doppio invio. | API | S |

### M5 – Convocazioni

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Creazione e invio | Dalla gara in calendario, **solo da app** (lo staff è a bordo campo); non convocabili evidenziati con il motivo; includerne uno richiede conferma esplicita, registrata nel log; push ed e-mail a convocati e tutori. | API, app | L |
| Risposta | Confermo / non ci sono con motivo, dall'app o dal link nell'e-mail senza accesso (token monouso legato alla persona). | API, app, pagina web pubblica | M |
| Riepilogo | Confermati, assenti, in attesa, aggiornati in tempo reale (GraphQL subscriptions). | API, app | M |
| Promemoria | Sollecito automatico a chi non ha risposto (predefinito 24 ore prima della scadenza). | API | S |
| Distinta gara | PDF generato in coda con dati della società, gara, convocati con numero, data di nascita e tessera; scaricabile da app e web. | API, app, web | M |
| Convocazioni sul web | Sola consultazione per la segreteria: elenco e distinte. | web | S |

### M6 – Comunicazione

| Storia | Criteri di accettazione | Dove | Dim. |
|---|---|---|---|
| Canali di squadra | Canale squadra (staff, atleti con account, tutori), canale staff, canale genitori; membri ricavati dai ruoli. | API | M |
| Chat in app | Testo, immagini e PDF; stato di lettura; paginazione; tempo reale. **Solo app** in Fase 1. | API, app | L |
| Tutela minori | Nessun messaggio diretto; un minore con account vede solo il canale squadra, dove ci sono anche i suoi tutori; nessuna anteprima dei messaggi nelle notifiche sul dispositivo di un minore; immagini di atleti solo con liberatoria. | API, app | M |
| Moderazione | Lo staff nasconde un messaggio; ogni intervento resta nel log di audit. | API, app | S |
| Bacheca | Avvisi per società o squadra pubblicati dal web; lettura e conferma dall'app; elenco di chi non ha letto. | API, web, app | M |
| Preferenze notifiche | Per tipo: push ed e-mail, con i tipi obbligatori non disattivabili. | API, app | S |

### Rinviato alla Fase 1b o successive

| Funzione | Motivo |
|---|---|
| Chat sul web | Lo staff la usa dall'app; la segreteria comunica con la bacheca. |
| Creazione convocazioni sul web | Chi convoca è l'allenatore, dall'app. |
| Import gare da CSV, esportazione CSV delle anagrafiche | Utili ma non necessari per la settimana pilota. |
| Riepilogo e-mail delle notifiche non lette | La risposta alle convocazioni via e-mail copre già le famiglie senza app. |
| Segnalazione di messaggi al referente della società | La moderazione da parte dello staff basta per il pilota. |
| Dashboard della segreteria | Da progettare sui riscontri del pilota. |

---

## 6. Da avviare subito (tempi indipendenti dal codice)

| Attività | Chi | Perché subito |
|---|---|---|
| Account Apple Developer e Google Play intestati alla società | Marco | Verifica dell'organizzazione (D-U-N-S) e revisione possono richiedere settimane. |
| Scelta del cloud UE (D5) e creazione dell'account | Marco | Blocca staging, storage di produzione e backup. |
| Contatto con il consulente privacy per informativa, termini e DPIA | Marco | Senza testi approvati il pilota non può partire. |
| Individuazione della società pilota (D6) | Marco | Serve un referente disponibile già dopo M3. |
| Progetto Firebase e progetto Sentry | Marco | Servono in M4 e in P; richiedono pochi minuti ma sono tuoi account. |

---

## 7. Sicurezza, privacy e qualità

- **Permessi:** ogni nuova query e mutation ha un test che verifica l'accesso negato a un'altra società, a un'altra squadra e a un genitore non collegato.
- **Dati sanitari:** certificati cifrati, accessi nel log di audit, URL di download validi pochi minuti, nessun dato sanitario nelle notifiche.
- **Conservazione:** chat per la stagione in corso più una; presenze e convocazioni 5 anni; da confermare con il consulente privacy.
- **Test end-to-end da aggiungere:** flusso genitore (invito → magic link → accesso limitato); import anagrafiche → squadra → allenamento ricorrente → appello offline → registro; gara → convocazione → risposta del genitore via e-mail → distinta; messaggio in chat visibile ai soli membri del canale.
- **Prestazioni:** appello e risposta alla convocazione sotto i 300 ms lato server al 95° percentile, misurati su staging con 20 squadre e 400 atleti.

---

## 8. Rischi

| Rischio | Mitigazione |
|---|---|
| Il tempo per revisioni e prove su dispositivo diventa il collo di bottiglia | Traguardi piccoli; Claude prepara per ogni traguardo una lista di prova di pochi minuti e i test automatici coprono il resto. |
| Sincronizzazione offline più complessa del previsto | Limitata alle presenze in Fase 1; costruita in M3 e provata dal vero con la società pilota. |
| Ricorrenze e cambio dell'ora legale | Libreria RRULE collaudata, test sulle date di cambio ora. |
| Famiglie che non installano l'app | Risposta alle convocazioni dal link nell'e-mail. |
| Account degli store o testi legali in ritardo | Avviati subito (§6); il codice procede in parallelo con lo staging. |
| Richieste del pilota che allargano il perimetro | Raccolte e valutate a fine traguardo, non durante. |

---

## 9. Criterio di uscita

Per almeno una società pilota e per 7 giorni consecutivi:

- tutti gli allenamenti della settimana hanno l'appello registrato in app;
- almeno una gara ha la convocazione inviata da Huddle, con risposta di almeno l'80% dei convocati entro 24 ore e distinta generata;
- le comunicazioni della squadra passano dalla chat e dalla bacheca di Huddle;
- nessun errore bloccante aperto, nessuna segnalazione di accesso a dati non autorizzati.
