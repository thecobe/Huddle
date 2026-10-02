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
}
