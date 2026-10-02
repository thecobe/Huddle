import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In it, this message translates to:
  /// **'Huddle'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In it, this message translates to:
  /// **'La tua società, in un unico posto.'**
  String get tagline;

  /// No description provided for @email.
  ///
  /// In it, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullName.
  ///
  /// In it, this message translates to:
  /// **'Nome e cognome'**
  String get fullName;

  /// No description provided for @signIn.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get signIn;

  /// No description provided for @signInWithLink.
  ///
  /// In it, this message translates to:
  /// **'Ricevi un link via e-mail'**
  String get signInWithLink;

  /// No description provided for @signInWithPassword.
  ///
  /// In it, this message translates to:
  /// **'Accedi con password'**
  String get signInWithPassword;

  /// No description provided for @magicLinkSent.
  ///
  /// In it, this message translates to:
  /// **'Se l\'indirizzo è registrato, riceverai un\'e-mail con il link di accesso. Aprilo da questo telefono.'**
  String get magicLinkSent;

  /// No description provided for @twoFactorTitle.
  ///
  /// In it, this message translates to:
  /// **'Verifica in due passaggi'**
  String get twoFactorTitle;

  /// No description provided for @twoFactorHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il codice dell\'app di autenticazione o un codice di recupero.'**
  String get twoFactorHint;

  /// No description provided for @code.
  ///
  /// In it, this message translates to:
  /// **'Codice'**
  String get code;

  /// No description provided for @verify.
  ///
  /// In it, this message translates to:
  /// **'Verifica'**
  String get verify;

  /// No description provided for @verifyingLink.
  ///
  /// In it, this message translates to:
  /// **'Verifica del link in corso…'**
  String get verifyingLink;

  /// No description provided for @invitationTitle.
  ///
  /// In it, this message translates to:
  /// **'Sei stato invitato'**
  String get invitationTitle;

  /// No description provided for @invitationBody.
  ///
  /// In it, this message translates to:
  /// **'{club} ti ha invitato su Huddle come {role}.'**
  String invitationBody(String club, String role);

  /// No description provided for @acceptTerms.
  ///
  /// In it, this message translates to:
  /// **'Accetto l\'informativa privacy e i termini di servizio'**
  String get acceptTerms;

  /// No description provided for @acceptInvitation.
  ///
  /// In it, this message translates to:
  /// **'Accetta invito'**
  String get acceptInvitation;

  /// No description provided for @clubsTitle.
  ///
  /// In it, this message translates to:
  /// **'Le tue società'**
  String get clubsTitle;

  /// No description provided for @noClubs.
  ///
  /// In it, this message translates to:
  /// **'Non fai ancora parte di nessuna società. Chiedi alla segreteria di inviarti un invito.'**
  String get noClubs;

  /// No description provided for @home.
  ///
  /// In it, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @calendar.
  ///
  /// In it, this message translates to:
  /// **'Calendario'**
  String get calendar;

  /// No description provided for @team.
  ///
  /// In it, this message translates to:
  /// **'Squadra'**
  String get team;

  /// No description provided for @profile.
  ///
  /// In it, this message translates to:
  /// **'Profilo'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In it, this message translates to:
  /// **'Ciao, {name}'**
  String welcome(String name);

  /// No description provided for @comingSoon.
  ///
  /// In it, this message translates to:
  /// **'Calendario, convocazioni e chat di squadra arrivano con il prossimo rilascio.'**
  String get comingSoon;

  /// No description provided for @officeHint.
  ///
  /// In it, this message translates to:
  /// **'La gestione della società (persone, stagioni, dati legali) è disponibile dal sito web.'**
  String get officeHint;

  /// No description provided for @yourRoles.
  ///
  /// In it, this message translates to:
  /// **'I tuoi ruoli'**
  String get yourRoles;

  /// No description provided for @switchClub.
  ///
  /// In it, this message translates to:
  /// **'Cambia società'**
  String get switchClub;

  /// No description provided for @signOut.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get signOut;

  /// No description provided for @retry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get retry;

  /// No description provided for @roleADMIN.
  ///
  /// In it, this message translates to:
  /// **'Amministratore'**
  String get roleADMIN;

  /// No description provided for @roleSECRETARY.
  ///
  /// In it, this message translates to:
  /// **'Segreteria'**
  String get roleSECRETARY;

  /// No description provided for @roleSPORTS_DIRECTOR.
  ///
  /// In it, this message translates to:
  /// **'Direttore sportivo'**
  String get roleSPORTS_DIRECTOR;

  /// No description provided for @roleCOACH.
  ///
  /// In it, this message translates to:
  /// **'Allenatore'**
  String get roleCOACH;

  /// No description provided for @roleTEAM_MANAGER.
  ///
  /// In it, this message translates to:
  /// **'Dirigente accompagnatore'**
  String get roleTEAM_MANAGER;

  /// No description provided for @roleATHLETE.
  ///
  /// In it, this message translates to:
  /// **'Atleta'**
  String get roleATHLETE;

  /// No description provided for @rolePARENT.
  ///
  /// In it, this message translates to:
  /// **'Genitore / tutore'**
  String get rolePARENT;

  /// No description provided for @errorINVALID_CREDENTIALS.
  ///
  /// In it, this message translates to:
  /// **'E-mail o password non corretti.'**
  String get errorINVALID_CREDENTIALS;

  /// No description provided for @errorINVALID_TOKEN.
  ///
  /// In it, this message translates to:
  /// **'Il link non è valido o è scaduto.'**
  String get errorINVALID_TOKEN;

  /// No description provided for @errorINVALID_TWO_FACTOR_CODE.
  ///
  /// In it, this message translates to:
  /// **'Codice non valido.'**
  String get errorINVALID_TWO_FACTOR_CODE;

  /// No description provided for @errorTOO_MANY_REQUESTS.
  ///
  /// In it, this message translates to:
  /// **'Troppi tentativi. Riprova tra un minuto.'**
  String get errorTOO_MANY_REQUESTS;

  /// No description provided for @errorNETWORK.
  ///
  /// In it, this message translates to:
  /// **'Impossibile contattare il server. Controlla la connessione.'**
  String get errorNETWORK;

  /// No description provided for @errorUNKNOWN.
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore. Riprova.'**
  String get errorUNKNOWN;

  /// No description provided for @myData.
  ///
  /// In it, this message translates to:
  /// **'I miei dati e dei figli'**
  String get myData;

  /// No description provided for @myTeams.
  ///
  /// In it, this message translates to:
  /// **'Le mie squadre'**
  String get myTeams;

  /// No description provided for @noTeamsYet.
  ///
  /// In it, this message translates to:
  /// **'Nessuna squadra assegnata.'**
  String get noTeamsYet;

  /// No description provided for @contacts.
  ///
  /// In it, this message translates to:
  /// **'Recapiti'**
  String get contacts;

  /// No description provided for @phone.
  ///
  /// In it, this message translates to:
  /// **'Telefono'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In it, this message translates to:
  /// **'Indirizzo'**
  String get address;

  /// No description provided for @city.
  ///
  /// In it, this message translates to:
  /// **'Comune'**
  String get city;

  /// No description provided for @province.
  ///
  /// In it, this message translates to:
  /// **'Provincia'**
  String get province;

  /// No description provided for @postalCode.
  ///
  /// In it, this message translates to:
  /// **'CAP'**
  String get postalCode;

  /// No description provided for @save.
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In it, this message translates to:
  /// **'Modifiche salvate'**
  String get saved;

  /// No description provided for @teamsLabel.
  ///
  /// In it, this message translates to:
  /// **'Squadre'**
  String get teamsLabel;

  /// No description provided for @guardiansLabel.
  ///
  /// In it, this message translates to:
  /// **'Tutori'**
  String get guardiansLabel;

  /// No description provided for @athlete.
  ///
  /// In it, this message translates to:
  /// **'Atleta'**
  String get athlete;

  /// No description provided for @yearsOld.
  ///
  /// In it, this message translates to:
  /// **'{n} anni'**
  String yearsOld(int n);

  /// No description provided for @jerseyNumber.
  ///
  /// In it, this message translates to:
  /// **'n. {n}'**
  String jerseyNumber(int n);

  /// No description provided for @players.
  ///
  /// In it, this message translates to:
  /// **'Atleti'**
  String get players;

  /// No description provided for @staff.
  ///
  /// In it, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @call.
  ///
  /// In it, this message translates to:
  /// **'Chiama'**
  String get call;

  /// No description provided for @sendEmail.
  ///
  /// In it, this message translates to:
  /// **'Scrivi'**
  String get sendEmail;

  /// No description provided for @activateAccountTitle.
  ///
  /// In it, this message translates to:
  /// **'Account di {name}'**
  String activateAccountTitle(String name);

  /// No description provided for @activateAccountHint.
  ///
  /// In it, this message translates to:
  /// **'Dai 14 anni puoi attivare un account per tuo figlio: riceverà un\'e-mail con il link di accesso.'**
  String get activateAccountHint;

  /// No description provided for @activateAccount.
  ///
  /// In it, this message translates to:
  /// **'Attiva account'**
  String get activateAccount;

  /// No description provided for @accountActive.
  ///
  /// In it, this message translates to:
  /// **'Ha già un account Huddle.'**
  String get accountActive;

  /// No description provided for @invitationSent.
  ///
  /// In it, this message translates to:
  /// **'Invito inviato a {email}'**
  String invitationSent(String email);

  /// No description provided for @availabilityINJURED.
  ///
  /// In it, this message translates to:
  /// **'Infortunato'**
  String get availabilityINJURED;

  /// No description provided for @availabilitySUSPENDED.
  ///
  /// In it, this message translates to:
  /// **'Squalificato'**
  String get availabilitySUSPENDED;

  /// No description provided for @availabilityOTHER.
  ///
  /// In it, this message translates to:
  /// **'Non disponibile'**
  String get availabilityOTHER;

  /// No description provided for @staffHEAD_COACH.
  ///
  /// In it, this message translates to:
  /// **'Allenatore'**
  String get staffHEAD_COACH;

  /// No description provided for @staffASSISTANT_COACH.
  ///
  /// In it, this message translates to:
  /// **'Vice allenatore'**
  String get staffASSISTANT_COACH;

  /// No description provided for @staffFITNESS_COACH.
  ///
  /// In it, this message translates to:
  /// **'Preparatore atletico'**
  String get staffFITNESS_COACH;

  /// No description provided for @staffGOALKEEPER_COACH.
  ///
  /// In it, this message translates to:
  /// **'Preparatore dei portieri'**
  String get staffGOALKEEPER_COACH;

  /// No description provided for @staffTEAM_MANAGER.
  ///
  /// In it, this message translates to:
  /// **'Dirigente accompagnatore'**
  String get staffTEAM_MANAGER;

  /// No description provided for @errorATHLETE_TOO_YOUNG.
  ///
  /// In it, this message translates to:
  /// **'Sotto i 14 anni l\'atleta non può avere un account.'**
  String get errorATHLETE_TOO_YOUNG;

  /// No description provided for @errorPERSON_ALREADY_LINKED.
  ///
  /// In it, this message translates to:
  /// **'Ha già un account collegato.'**
  String get errorPERSON_ALREADY_LINKED;

  /// No description provided for @errorFORBIDDEN.
  ///
  /// In it, this message translates to:
  /// **'Non hai i permessi per questa operazione.'**
  String get errorFORBIDDEN;

  /// No description provided for @errorBAD_USER_INPUT.
  ///
  /// In it, this message translates to:
  /// **'Controlla i dati inseriti.'**
  String get errorBAD_USER_INPUT;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
