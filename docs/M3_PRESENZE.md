# M3 – Presenze: piano

Traguardo di [FASE_1.md](FASE_1.md). Dopo M3 una società pilota può usare Huddle per anagrafiche, calendario e
presenze (traguardo P).

**Risultato atteso.** A bordo campo, anche senza rete, l'allenatore fa l'appello di 20 atleti in meno di 30 secondi;
i dati arrivano sul server appena torna la connessione, senza doppioni. La segreteria consulta il registro sul web.
Il genitore segnala in anticipo un'assenza e l'appello la propone già come giustificata.

---

## 1. Decisioni

Confermate il 2026-10-02 come proposte.

| # | Decisione | Scelta |
|---|---|---|
| D8 | Fino a quando si può fare o correggere l'appello? | Staff della squadra: da 2 ore prima dell'inizio a 7 giorni dopo. Oltre: solo segreteria e amministrazione, con log di audit. |
| D9 | Dati salvati sul telefono per l'uso offline | Solo il necessario (eventi dei prossimi 7 giorni delle proprie squadre, nome, cognome e maglia degli atleti, appelli non ancora inviati); nessun dato sanitario né recapito; protezione di sistema di iOS e Android; database locale cancellato al logout e al cambio account. Cifratura con SQLCipher solo se la richiede il consulente privacy. |
| D10 | Il genitore vede lo storico presenze del figlio? | Sì, in sola lettura nell'app (storia piccola, inclusa in M3). |
| D11 | Appello: tutti presenti per impostazione predefinita? | Sì. L'allenatore tocca solo chi manca; l'appello si chiude con "Conferma". |

---

## 2. Modello dati (migrazione `0004_attendance`)

| Tabella | Campi | Note |
|---|---|---|
| `attendance` | `event_id`, `person_id`, `status` (PRESENT, ABSENT, EXCUSED, INJURED, LATE), `note`, `recorded_by`, `recorded_at` (ora del dispositivo, limitata all'ora del server), `updated_at` | Una riga per (evento, persona). |
| `attendance_writes` | `client_mutation_id` (univoco), `event_id`, `person_id`, `status`, `note`, `recorded_by`, `recorded_at`, `received_at`, `outcome` (APPLIED, DUPLICATE, SUPERSEDED) | Registro append-only di ogni scrittura: rende idempotente l'invio offline e tiene traccia dei conflitti. |
| `absence_notices` | `event_id`, `person_id`, `reason`, `created_by`, `created_at`, `withdrawn_at` | Assenza annunciata dal genitore (o dall'atleta dai 14 anni). |
| `events` (nuove colonne) | `roll_call_at`, `roll_call_by` | Appello confermato: serve al criterio di uscita della fase ("tutti gli allenamenti hanno l'appello"). |

Tutte con `tenant_id` e RLS come le tabelle esistenti; id dal client verificati con `assertInTenant`.

---

## 3. API

| Operazione | Chi | Comportamento |
|---|---|---|
| `rollCall(eventId)` | Staff della squadra, direzione, segreteria | Rosa della squadra con stato attuale, assenze annunciate e motivo, stato dell'appello. |
| `recordAttendance(entries)` | Come sopra, entro la finestra D8 | Riceve un lotto di righe `{clientMutationId, eventId, personId, status, note, recordedAt}` e risponde riga per riga: APPLIED, DUPLICATE (già ricevuta: nessun effetto), SUPERSEDED (sul server c'è un dato più recente: vince l'ultimo), REJECTED con codice (fuori finestra, evento annullato, atleta non in rosa, permesso). Un errore su una riga non blocca le altre. |
| `completeRollCall(eventId, clientMutationId)` | Come sopra | Segna l'appello come fatto; idempotente. |
| `attendanceRegister(teamId, from, to, kind)` | Staff, direzione, segreteria | Tabella atleti × eventi e percentuali; base del registro web e del CSV. |
| `reportAbsence(eventId, personId, reason)` / `withdrawAbsence(id)` | Tutore del minore, atleta con account | Solo eventi futuri non annullati. |
| `myAttendance(personId, from, to)` | Persona stessa e tutori | Storico del figlio (D10). |

Regola di conflitto: per ogni (evento, persona) vince la scrittura con `recorded_at` più recente; a parità vince quella
arrivata dopo. Ogni scrittura, compresa quella scartata, resta in `attendance_writes`.

---

## 4. App: funzionamento offline

**Componenti nuovi** (`lib/offline/`):

| Componente | Ruolo |
|---|---|
| Database locale (`drift` su SQLite) | Tabelle: eventi in cache, rose in cache, presenze locali, coda in uscita (`outbox`). |
| Coda in uscita | Ogni tocco dell'appello diventa una riga con `clientMutationId` (UUID) e `recordedAt`; viene inviata a lotti. |
| Sincronizzazione | Parte al ritorno della rete (`connectivity_plus`), al rientro in primo piano, dopo ogni modifica e ogni 60 secondi se ci sono righe in coda. Ritenta con backoff; rimuove le righe con esito APPLIED, DUPLICATE o SUPERSEDED; tiene quelle REJECTED con il motivo da mostrare. |
| Precaricamento | All'apertura dell'app con rete: eventi dei prossimi 7 giorni delle proprie squadre e relative rose. |
| Stato visibile | Indicatore "N modifiche da inviare" / "Tutto inviato" e avviso per le righe rifiutate. |

**Sessione senza rete.** L'access token scade dopo 15 minuti; l'appello resta in coda e viene inviato dopo il rinnovo
della sessione al ritorno della rete. Se il refresh token è stato revocato, le righe restano in coda finché l'utente
non accede di nuovo (stesso account) e vengono cancellate solo al logout esplicito, con avviso se non ancora inviate.

**Pacchetti da aggiungere:** `drift`, `drift_flutter`, `connectivity_plus`, `uuid` (più `drift_dev` per il codegen).

---

## 5. Interfaccia

| Dove | Cosa |
|---|---|
| App, agenda staff | Sull'evento di oggi, pulsante "Appello". |
| App, appello | Rosa ordinata per maglia, tutti presenti; un tocco alterna presente/assente; tocco lungo per giustificato, infortunato, ritardo e nota; chi ha un'assenza annunciata appare già giustificato con il motivo; "Conferma appello". Funziona senza rete. |
| App, genitore | Nel dettaglio di un evento futuro: "Segnala assenza" con motivo, ritirabile fino all'inizio. Nella scheda del figlio: presenze recenti. |
| Web, registro | Pagina "Presenze": squadra, periodo, tipo di evento; tabella atleti × date con icone di stato e percentuale; eventi senza appello evidenziati; esportazione CSV. |

---

## 6. Ordine di lavoro

1. **API e database:** migrazione, `recordAttendance` con idempotenza e conflitti, finestra D8, assenze annunciate, registro. Test di integrazione su tutti i casi di §3.
2. **App, struttura offline:** database locale, coda, sincronizzazione, precaricamento. Test unitari con database in memoria e API finta che va e viene.
3. **App, appello e assenze:** schermate e collegamento alla coda; test widget sul tempo dell'appello (20 atleti con meno di 30 tocchi).
4. **Web, registro presenze** ed esportazione CSV; e2e.
5. **Verifica su simulatore iOS:** appello fatto con l'API irraggiungibile, poi riattivata: le righe arrivano una sola volta. Dati demo aggiornati con presenze passate.
6. **Documentazione** e lista di prova per te su dispositivo reale (anche in modalità aereo).

---

## 7. Rischi

| Rischio | Mitigazione |
|---|---|
| Doppioni o dati persi nella sincronizzazione | Idempotenza lato server con `client_mutation_id` univoco; righe tolte dalla coda solo dopo esito definitivo; test con rete intermittente. |
| Orologio del telefono sbagliato | `recordedAt` limitato all'ora del server; vince comunque l'ultima scrittura arrivata a parità. |
| Due allenatori fanno l'appello insieme | Regola dell'ultima scrittura per atleta; entrambe le versioni restano in `attendance_writes`. |
| Dati di minori sul telefono | Dati minimi, niente recapiti né dati sanitari, cancellazione al logout (D9). |
| Test offline difficili sul simulatore | Interruzione simulata nel client API per i test; prova in modalità aereo da parte tua su dispositivo reale. |

---

## 8. Fuori da M3

- Notifica all'allenatore quando un genitore annuncia un'assenza: arriva con le notifiche push di M4.
- Statistiche avanzate (carichi, RPE): Fase 3.
- Check-in con QR code: Fase 4.

---

## 9. Stato e prova su dispositivo

**Completato il 2026-10-03.** Verifiche automatiche:

- API: idempotenza dei reinvii, conflitti (vince la registrazione più recente, entrambe restano nel registro),
  orologio del telefono avanti, finestra D8 (prima, dopo 7 giorni, correzione della segreteria con log),
  evento annullato, atleta non in rosa, permessi, assenze annunciate, registro con percentuali, storico D10.
- App: coda offline con database in memoria (rete assente, risposta persa dopo la scrittura, righe rifiutate,
  cambio account); appello di 20 atleti con 3 assenti in 4 tocchi.
- Web: registro con percentuali, appelli non confermati evidenziati, CSV.
- Simulatore iOS 27 contro l'API locale: appello fatto con la rete staccata e inviato una sola volta al ritorno.

**Da provare tu su un telefono reale** (dati: `pnpm --filter @huddle/api seed:demo`, accesso dell'allenatore con
il magic link stampato; l'allenamento "Allenamento di oggi" è già aperto per l'appello):

1. Apri l'app con la rete: Calendario → "Allenamento di oggi" → **Appello**.
2. Attiva la **modalità aereo**. Tocca due atleti (assenti), tieni premuto su un terzo e scegli "In ritardo" con una nota.
3. Premi **Conferma appello**: nella barra compare la nuvola barrata con il numero di modifiche da inviare.
4. Chiudi e riapri l'app ancora offline: l'appello è come l'hai lasciato.
5. Togli la modalità aereo: entro pochi secondi la nuvola sparisce.
6. Sul web, **Presenze** → squadra Under 15: l'allenamento ha l'appello confermato con i tuoi stati.
7. Con l'account del genitore (secondo magic link): dettaglio di un allenamento futuro → **Segnala assenza**;
   con l'allenatore, l'appello di quell'allenamento propone l'atleta come giustificato con il motivo.
