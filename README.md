# ⚽ Huddle

Piattaforma web e mobile denominata Huddle per la gestione completa delle **società sportive dilettantistiche (ASD/SSD)**: dalla segreteria e amministrazione fino al lavoro quotidiano degli **allenatori** su allenamenti, convocazioni e comunicazione con la squadra.

---

## 🚀 Sviluppo

- [Piano di sviluppo](docs/PIANO_SVILUPPO.md)
- [Stato Fase 0](docs/FASE_0.md)
- [Sviluppo locale](docs/SVILUPPO.md)

---

## 📌 Indice

1. [Obiettivi](#-obiettivi)
2. [Ruoli e permessi](#-ruoli-e-permessi)
3. [Funzionalità principali](#-funzionalità-principali)
   - [Gestione società](#1-gestione-società)
   - [Anagrafiche e tesseramenti](#2-anagrafiche-e-tesseramenti)
   - [Amministrazione e pagamenti](#3-amministrazione-e-pagamenti)
   - [Squadre e staff](#4-squadre-e-staff)
   - [Allenamenti](#5-allenamenti)
   - [Convocazioni](#6-convocazioni)
   - [Partite e campionati](#7-partite-e-campionati)
   - [Comunicazione](#8-comunicazione)
   - [Impianti e risorse](#9-impianti-e-risorse)
   - [Dashboard e report](#10-dashboard-e-report)
4. [App per atleti e genitori](#-app-per-atleti-e-genitori)
5. [Funzionalità aggiuntive suggerite](#-funzionalità-aggiuntive-suggerite)
6. [Roadmap consigliata](#-roadmap-consigliata)
7. [Architettura tecnica proposta](#-architettura-tecnica-proposta)
8. [Sicurezza, privacy e tutela dei minori](#-sicurezza-privacy-e-tutela-dei-minori)

---

## 🎯 Obiettivi

- Centralizzare in un unico strumento tutte le attività della società, eliminando fogli Excel, gruppi WhatsApp sparsi e moduli cartacei.
- Ridurre il carico della segreteria automatizzando scadenze, pagamenti e documenti.
- Dare agli allenatori uno strumento rapido, usabile da smartphone a bordo campo.
- Tenere atleti e famiglie informati in modo ordinato e tracciabile.

---

## 👥 Ruoli e permessi

| Ruolo | Cosa può fare |
|---|---|
| **Amministratore / Presidente** | Accesso completo, configurazione società, bilancio, gestione utenti e permessi |
| **Segreteria** | Anagrafiche, tesseramenti, certificati medici, pagamenti, documenti |
| **Direttore sportivo** | Supervisione di tutte le squadre, staff tecnico, calendari, report |
| **Allenatore / Staff tecnico** | Gestione della propria squadra: allenamenti, presenze, convocazioni, comunicazioni, valutazioni |
| **Dirigente accompagnatore** | Convocazioni, distinte gara, logistica trasferte |
| **Atleta** | Calendario, risposta alle convocazioni, chat di squadra, proprie statistiche e documenti |
| **Genitore / Tutore** | Tutto ciò che riguarda i figli minorenni: conferme, pagamenti, autorizzazioni, comunicazioni |

I permessi sono granulari e configurabili per singola squadra (un allenatore vede solo i propri gruppi).

---

## 🧩 Funzionalità principali

### 1. Gestione società

- Profilo della società: dati legali, codice fiscale/P.IVA, affiliazioni a federazioni ed enti di promozione sportiva.
- Organigramma con cariche sociali e scadenze dei mandati.
- Gestione stagioni sportive (apertura, chiusura, passaggio dati alla stagione successiva).
- Archivio documentale: statuto, verbali di assemblea, delibere, regolamenti interni.
- Gestione soci e libro soci, con convocazione assemblee e raccolta deleghe.
- Supporto agli adempimenti previsti per le realtà sportive dilettantistiche (es. promemoria per gli aggiornamenti sul Registro Nazionale delle Attività Sportive Dilettantistiche).

### 2. Anagrafiche e tesseramenti

- Scheda completa di atleti, staff, dirigenti e volontari, con foto e contatti.
- Collegamento atleta ↔ genitori/tutori per i minorenni.
- Tesseramenti federali con numero tessera, categoria e scadenza.
- **Certificati medici**: caricamento, tipologia (agonistico / non agonistico), scadenza e **blocco automatico** della convocabilità quando il certificato è scaduto.
- Moduli digitali con firma: iscrizione, consenso privacy, liberatoria immagini, autorizzazioni trasferte.
- Gestione taglie e kit (divise, materiale consegnato).

### 3. Amministrazione e pagamenti

- Piani quote personalizzabili (annuale, rate, sconti fratelli, agevolazioni).
- Pagamenti online (carta, bonifico, PagoPA/SEPA) e registrazione pagamenti in contanti.
- Solleciti automatici per quote scadute.
- Emissione ricevute, incluse quelle utili alla detrazione delle spese sportive dei figli.
- Prima nota, entrate/uscite per centro di costo (squadra, evento, impianto).
- Gestione compensi e rimborsi per collaboratori e lavoratori sportivi.
- Gestione sponsor: contratti, scadenze, visibilità concordata.
- Esportazione dati verso il commercialista (CSV/Excel).

### 4. Squadre e staff

- Creazione squadre per categoria, fascia d'età e disciplina.
- Assegnazione atleti e staff tecnico (anche su più squadre).
- Gestione dei trasferimenti tra squadre durante la stagione.
- Rosa con ruoli, numeri di maglia e stato (disponibile, infortunato, squalificato, certificato scaduto).

### 5. Allenamenti

- **Calendario allenamenti** ricorrente con eccezioni (festività, chiusura impianto).
- **Pianificazione sedute**: obiettivi, durata, fasi (riscaldamento, parte centrale, defaticamento).
- **Libreria esercizi** della società con descrizione, schema grafico, video, materiali necessari e tag (tecnica, tattica, atletica, portieri…).
- Creazione di microcicli e mesocicli e visione della programmazione stagionale.
- **Registro presenze** rapido da smartphone (presente, assente, giustificato, infortunato, ritardo).
- Note individuali sull'atleta durante la seduta.
- Valutazioni periodiche (tecniche, fisiche, comportamentali) con schede personalizzabili.
- Monitoraggio dei carichi di lavoro e della percezione della fatica (RPE).
- Gestione infortuni: data, tipo, tempi di recupero stimati, rientro graduale.

### 6. Convocazioni

- Creazione della convocazione in pochi tocchi a partire dalla gara in calendario.
- Selezione atleti con evidenza immediata di **non convocabili** (certificato scaduto, squalifica, infortunio, quota non pagata se configurato).
- Invio tramite notifica push, e-mail e/o SMS con luogo, orario di ritrovo, abbigliamento e note.
- **Conferma di presenza** da parte dell'atleta o del genitore, con promemoria automatico a chi non risponde.
- Riepilogo in tempo reale: confermati, assenti, in attesa.
- Gestione **trasporti**: chi offre passaggi, posti disponibili, punto di ritrovo.
- Generazione automatica della **distinta gara** in PDF.
- Storico convocazioni e minutaggi per una gestione equa del gruppo (utile soprattutto nel settore giovanile).

### 7. Partite e campionati

- Calendario gare (campionato, coppe, amichevoli, tornei).
- Importazione del calendario da file o inserimento manuale.
- Formazioni e schieramento tattico grafico.
- Registrazione eventi di gara: gol, assist, cartellini, sostituzioni, minuti giocati.
- Classifiche e statistiche individuali e di squadra.
- Gestione squalifiche con conteggio automatico delle ammonizioni.
- Report post-partita condivisibile con la squadra.

### 8. Comunicazione

- **Chat di squadra** e canali tematici (staff, genitori, prima squadra…).
- **Bacheca** con avvisi ufficiali, con conferma di lettura.
- Comunicazioni broadcast della società a tutti o per gruppi filtrati.
- Notifiche push configurabili per tipo di evento.
- Sondaggi rapidi (es. disponibilità per un torneo, scelta data cena di fine stagione).
- Condivisione di documenti, foto e video con permessi di visibilità.
- Traduzione automatica dei messaggi per le famiglie non italofone.

### 9. Impianti e risorse

- Anagrafica impianti, campi e palestre (proprietà, concessione, affitto).
- **Planner occupazione** con prevenzione dei conflitti tra squadre.
- Prenotazione spazi e gestione delle richieste di cambio orario.
- Inventario materiale sportivo (palloni, conetti, pettorine, attrezzature) e assegnazione alle squadre.
- Gestione manutenzioni e scadenze (es. defibrillatore, estintori).

### 10. Dashboard e report

- **Dashboard presidente**: iscritti, incassi, quote insolute, certificati in scadenza.
- **Dashboard allenatore**: prossimi eventi, presenze medie, atleti indisponibili.
- Report presenze per atleta e per squadra.
- Report economici per stagione e per centro di costo.
- Esportazione in PDF ed Excel.

---

## 📱 App per atleti e genitori

- Calendario personale (allenamenti, partite, eventi) sincronizzabile con Google Calendar / Apple Calendar.
- Risposta alle convocazioni e segnalazione di assenze con motivazione.
- Pagamento quote e storico ricevute.
- Caricamento del certificato medico e promemoria di scadenza.
- Statistiche personali e schede di valutazione (se l'allenatore le condivide).
- Gestione di più figli dallo stesso account genitore.

---

## 💡 Funzionalità aggiuntive suggerite

Ordinate per rapporto tra valore percepito e complessità di sviluppo.

### Alto valore, sforzo contenuto

| Funzionalità | Descrizione |
|---|---|
| **Check-in con QR code** | L'atleta scansiona un QR all'ingresso del campo e la presenza viene registrata automaticamente. |
| **Registrazione volontari** | Turni per bar, segreteria campo, accompagnamento; i genitori si iscrivono da app. |
| **Calendario pubblico e widget sito** | Calendario, risultati e classifiche incorporabili nel sito della società. |
| **Modalità offline** | L'allenatore registra presenze ed eventi di gara anche senza connessione; sincronizzazione al rientro. |
| **Promemoria meteo** | Avviso automatico se le condizioni meteo previste possono far annullare l'allenamento. |

### Alto valore, sforzo medio

| Funzionalità | Descrizione |
|---|---|
| **Lavagna tattica digitale** | Disegno di schemi ed esercizi con animazioni, salvabili nella libreria. |
| **Video analisi** | Caricamento video delle partite con tag degli eventi e clip condivisibili al singolo atleta. |
| **Integrazione dispositivi wearable** | Importazione dati da GPS e cardiofrequenzimetri per il monitoraggio dei carichi. |
| **E-commerce della società** | Vendita di merchandising, kit e biglietti per eventi. |
| **Gestione tornei** | Organizzazione di tornei interni o ospitati: gironi, tabellone, risultati in diretta. |
| **Portale scouting** | Schede osservazione di atleti esterni e gestione degli open day / provini. |
| **Gestione camp estivi** | Iscrizioni, turni settimanali, pagamenti e liste per i centri estivi. |

### Innovative / a lungo termine

| Funzionalità | Descrizione |
|---|---|
| **Assistente AI per l'allenatore** | Suggerimento di sedute in base a obiettivi, età e presenze; generazione automatica del report post-partita. |
| **Previsione rischio infortuni** | Segnalazione di atleti con carichi anomali rispetto alla loro media. |
| **Diario dell'atleta** | Qualità del sonno, alimentazione, stato d'animo, a supporto della crescita del giovane atleta. |
| **Gamification** | Badge per presenze, impegno e fair play, pensati soprattutto per le fasce più giovani. |
| **Integrazione con portali federali** | Sincronizzazione di tesseramenti, calendari e risultati dove le federazioni rendono disponibili API. |
| **Multi-società / consorzi** | Gestione di più società affiliate o di un gruppo di club con dati condivisi. |
| **Live streaming e cronaca live** | Aggiornamenti in diretta delle partite per i familiari che non possono essere presenti. |

---

## 🗺 Roadmap consigliata

**Fase 1 – MVP (3–4 mesi)**
Anagrafiche, squadre, certificati medici, calendario allenamenti e gare, presenze, convocazioni con conferma, chat di squadra, bacheca, app mobile base.

**Fase 2 – Amministrazione (2–3 mesi)**
Quote e pagamenti online, ricevute, solleciti automatici, moduli con firma digitale, impianti e planner occupazione.

**Fase 3 – Area tecnica avanzata (3 mesi)**
Libreria esercizi, pianificazione stagionale, valutazioni, statistiche di gara, gestione infortuni, report.

**Fase 4 – Estensioni**
Video analisi, lavagna tattica, e-commerce, tornei, integrazioni esterne, funzionalità AI.

---

## 🏗 Architettura tecnica proposta

| Livello | Tecnologie suggerite |
|---|---|
| **Frontend web** | Vue, con interfaccia responsive per la segreteria |
| **App mobile** | Flutter (iOS e Android da un unico codice) |
| **Backend** | Node.js (NestJS), GraphQL |
| **Database** | PostgreSQL, con architettura multi-tenant (una società = un tenant) |
| **Tempo reale** | WebSocket per chat e aggiornamento conferme convocazioni |
| **Notifiche** | Firebase Cloud Messaging, e-mail transazionali, SMS |
| **Pagamenti** | Stripe, PayPal o gateway bancario con supporto SEPA |
| **Storage file** | Object storage compatibile S3 per documenti, foto e video |
| **Hosting** | Cloud europeo, per mantenere i dati personali all'interno dell'UE |
| **Languages** | Multilingua i18n |
| **Virtualization** | Docker |

---

## 🔒 Sicurezza, privacy e tutela dei minori

- **Conformità GDPR**: registro dei consensi, informative, diritto di accesso e cancellazione, conservazione dei dati limitata nel tempo.
- **Dati sanitari** (certificati, infortuni) trattati come categorie particolari: accesso ristretto ai soli ruoli autorizzati e cifratura dei file.
- **Tutela dei minori**:
  - comunicazioni rivolte agli atleti minorenni visibili anche ai genitori/tutori;
  - niente chat private uno-a-uno tra adulti dello staff e minori: i messaggi passano da canali di squadra o includono il genitore;
  - pubblicazione di foto e video solo con liberatoria valida;
  - possibilità di nominare un referente per la tutela (safeguarding) con canale di segnalazione riservato.
- Autenticazione a due fattori per i ruoli amministrativi.
- Log delle operazioni sensibili (modifiche ai pagamenti, accesso a dati sanitari).
- Backup automatici e piano di ripristino.

---

## 📄 Licenza

Da definire.
