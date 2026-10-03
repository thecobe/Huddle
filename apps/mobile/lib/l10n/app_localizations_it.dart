// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Huddle';

  @override
  String get tagline => 'La tua società, in un unico posto.';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password';

  @override
  String get fullName => 'Nome e cognome';

  @override
  String get signIn => 'Accedi';

  @override
  String get signInWithLink => 'Ricevi un link via e-mail';

  @override
  String get signInWithPassword => 'Accedi con password';

  @override
  String get magicLinkSent =>
      'Se l\'indirizzo è registrato, riceverai un\'e-mail con il link di accesso. Aprilo da questo telefono.';

  @override
  String get twoFactorTitle => 'Verifica in due passaggi';

  @override
  String get twoFactorHint =>
      'Inserisci il codice dell\'app di autenticazione o un codice di recupero.';

  @override
  String get code => 'Codice';

  @override
  String get verify => 'Verifica';

  @override
  String get verifyingLink => 'Verifica del link in corso…';

  @override
  String get invitationTitle => 'Sei stato invitato';

  @override
  String invitationBody(String club, String role) {
    return '$club ti ha invitato su Huddle come $role.';
  }

  @override
  String get acceptTerms =>
      'Accetto l\'informativa privacy e i termini di servizio';

  @override
  String get acceptInvitation => 'Accetta invito';

  @override
  String get clubsTitle => 'Le tue società';

  @override
  String get noClubs =>
      'Non fai ancora parte di nessuna società. Chiedi alla segreteria di inviarti un invito.';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendario';

  @override
  String get team => 'Squadra';

  @override
  String get profile => 'Profilo';

  @override
  String welcome(String name) {
    return 'Ciao, $name';
  }

  @override
  String get comingSoon =>
      'Calendario, convocazioni e chat di squadra arrivano con il prossimo rilascio.';

  @override
  String get officeHint =>
      'La gestione della società (persone, stagioni, dati legali) è disponibile dal sito web.';

  @override
  String get yourRoles => 'I tuoi ruoli';

  @override
  String get switchClub => 'Cambia società';

  @override
  String get signOut => 'Esci';

  @override
  String get retry => 'Riprova';

  @override
  String get roleADMIN => 'Amministratore';

  @override
  String get roleSECRETARY => 'Segreteria';

  @override
  String get roleSPORTS_DIRECTOR => 'Direttore sportivo';

  @override
  String get roleCOACH => 'Allenatore';

  @override
  String get roleTEAM_MANAGER => 'Dirigente accompagnatore';

  @override
  String get roleATHLETE => 'Atleta';

  @override
  String get rolePARENT => 'Genitore / tutore';

  @override
  String get errorINVALID_CREDENTIALS => 'E-mail o password non corretti.';

  @override
  String get errorINVALID_TOKEN => 'Il link non è valido o è scaduto.';

  @override
  String get errorINVALID_TWO_FACTOR_CODE => 'Codice non valido.';

  @override
  String get errorTOO_MANY_REQUESTS =>
      'Troppi tentativi. Riprova tra un minuto.';

  @override
  String get errorNETWORK =>
      'Impossibile contattare il server. Controlla la connessione.';

  @override
  String get errorUNKNOWN => 'Si è verificato un errore. Riprova.';

  @override
  String get myData => 'I miei dati e dei figli';

  @override
  String get myTeams => 'Le mie squadre';

  @override
  String get noTeamsYet => 'Nessuna squadra assegnata.';

  @override
  String get contacts => 'Recapiti';

  @override
  String get phone => 'Telefono';

  @override
  String get address => 'Indirizzo';

  @override
  String get city => 'Comune';

  @override
  String get province => 'Provincia';

  @override
  String get postalCode => 'CAP';

  @override
  String get save => 'Salva';

  @override
  String get saved => 'Modifiche salvate';

  @override
  String get teamsLabel => 'Squadre';

  @override
  String get guardiansLabel => 'Tutori';

  @override
  String get athlete => 'Atleta';

  @override
  String yearsOld(int n) {
    return '$n anni';
  }

  @override
  String jerseyNumber(int n) {
    return 'n. $n';
  }

  @override
  String get players => 'Atleti';

  @override
  String get staff => 'Staff';

  @override
  String get call => 'Chiama';

  @override
  String get sendEmail => 'Scrivi';

  @override
  String activateAccountTitle(String name) {
    return 'Account di $name';
  }

  @override
  String get activateAccountHint =>
      'Dai 14 anni puoi attivare un account per tuo figlio: riceverà un\'e-mail con il link di accesso.';

  @override
  String get activateAccount => 'Attiva account';

  @override
  String get accountActive => 'Ha già un account Huddle.';

  @override
  String invitationSent(String email) {
    return 'Invito inviato a $email';
  }

  @override
  String get availabilityINJURED => 'Infortunato';

  @override
  String get availabilitySUSPENDED => 'Squalificato';

  @override
  String get availabilityOTHER => 'Non disponibile';

  @override
  String get staffHEAD_COACH => 'Allenatore';

  @override
  String get staffASSISTANT_COACH => 'Vice allenatore';

  @override
  String get staffFITNESS_COACH => 'Preparatore atletico';

  @override
  String get staffGOALKEEPER_COACH => 'Preparatore dei portieri';

  @override
  String get staffTEAM_MANAGER => 'Dirigente accompagnatore';

  @override
  String get errorATHLETE_TOO_YOUNG =>
      'Sotto i 14 anni l\'atleta non può avere un account.';

  @override
  String get errorPERSON_ALREADY_LINKED => 'Ha già un account collegato.';

  @override
  String get errorFORBIDDEN => 'Non hai i permessi per questa operazione.';

  @override
  String get errorBAD_USER_INPUT => 'Controlla i dati inseriti.';

  @override
  String get kindTRAINING => 'Allenamento';

  @override
  String get kindMATCH => 'Gara';

  @override
  String get kindOTHER => 'Evento';

  @override
  String get cancelled => 'Annullato';

  @override
  String get openMap => 'Apri nelle mappe';

  @override
  String get noEvents => 'Nessun evento nei prossimi 30 giorni.';

  @override
  String versus(String opponent) {
    return 'vs $opponent';
  }

  @override
  String get homeMatch => 'In casa';

  @override
  String get awayMatch => 'In trasferta';

  @override
  String get clubWide => 'Tutta la società';

  @override
  String get notes => 'Note';

  @override
  String get rollCall => 'Appello';

  @override
  String get confirmRollCall => 'Conferma appello';

  @override
  String get rollCallDone => 'Appello confermato';

  @override
  String get rollCallReadOnly => 'L\'appello non è più modificabile.';

  @override
  String get rollCallHint =>
      'Tocca chi manca. Tieni premuto per giustificato, infortunato, ritardo o una nota.';

  @override
  String get statusPRESENT => 'Presente';

  @override
  String get statusABSENT => 'Assente';

  @override
  String get statusEXCUSED => 'Giustificato';

  @override
  String get statusINJURED => 'Infortunato';

  @override
  String get statusLATE => 'In ritardo';

  @override
  String get noteLabel => 'Nota';

  @override
  String absenceNotice(String reason) {
    return 'Assenza annunciata: $reason';
  }

  @override
  String pendingChanges(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n modifiche da inviare',
      one: '1 modifica da inviare',
    );
    return '$_temp0';
  }

  @override
  String get allSent => 'Tutto inviato';

  @override
  String get offlineNotCached =>
      'Senza rete e senza dati salvati per questo evento: riprova con la connessione.';

  @override
  String get rejectedChanges =>
      'Alcune modifiche sono state rifiutate dal server.';

  @override
  String get dismiss => 'Ignora';

  @override
  String get participation => 'Partecipazione';

  @override
  String get reportAbsence => 'Segnala assenza';

  @override
  String get withdrawAbsence => 'Ritira';

  @override
  String get absenceReason => 'Motivo (facoltativo)';

  @override
  String get send => 'Invia';

  @override
  String get absenceReported => 'Assenza segnalata';

  @override
  String get recentAttendance => 'Presenze recenti';

  @override
  String get noAttendanceYet => 'Nessuna presenza registrata.';

  @override
  String get logoutPendingTitle => 'Modifiche non inviate';

  @override
  String get logoutPendingBody =>
      'Ci sono modifiche all\'appello non ancora inviate. Uscendo andranno perse.';

  @override
  String get logoutAnyway => 'Esci comunque';

  @override
  String get errorOUT_OF_WINDOW =>
      'Fuori dal periodo in cui l\'appello è modificabile.';

  @override
  String get errorEVENT_CANCELLED => 'L\'evento è stato annullato.';

  @override
  String get errorNOT_IN_ROSTER => 'L\'atleta non è più in rosa.';

  @override
  String get errorEVENT_STARTED => 'L\'evento è già iniziato.';
}
