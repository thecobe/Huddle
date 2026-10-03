// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Huddle';

  @override
  String get tagline => 'Your club, in one place.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get fullName => 'Full name';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInWithLink => 'Get a link by email';

  @override
  String get signInWithPassword => 'Sign in with password';

  @override
  String get magicLinkSent =>
      'If the address is registered, you\'ll get an email with a sign-in link. Open it on this phone.';

  @override
  String get twoFactorTitle => 'Two-step verification';

  @override
  String get twoFactorHint =>
      'Enter the code from your authenticator app or a recovery code.';

  @override
  String get code => 'Code';

  @override
  String get verify => 'Verify';

  @override
  String get verifyingLink => 'Checking your link…';

  @override
  String get invitationTitle => 'You\'re invited';

  @override
  String invitationBody(String club, String role) {
    return '$club invited you to Huddle as $role.';
  }

  @override
  String get acceptTerms => 'I accept the privacy policy and terms of service';

  @override
  String get acceptInvitation => 'Accept invitation';

  @override
  String get clubsTitle => 'Your clubs';

  @override
  String get noClubs =>
      'You\'re not part of any club yet. Ask your club office to send you an invitation.';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

  @override
  String get team => 'Team';

  @override
  String get profile => 'Profile';

  @override
  String welcome(String name) {
    return 'Hi, $name';
  }

  @override
  String get comingSoon =>
      'Calendar, call-ups and team chat are coming in the next release.';

  @override
  String get officeHint =>
      'Club management (people, seasons, legal details) is available on the website.';

  @override
  String get yourRoles => 'Your roles';

  @override
  String get switchClub => 'Switch club';

  @override
  String get signOut => 'Sign out';

  @override
  String get retry => 'Retry';

  @override
  String get roleADMIN => 'Administrator';

  @override
  String get roleSECRETARY => 'Secretary';

  @override
  String get roleSPORTS_DIRECTOR => 'Sports director';

  @override
  String get roleCOACH => 'Coach';

  @override
  String get roleTEAM_MANAGER => 'Team manager';

  @override
  String get roleATHLETE => 'Athlete';

  @override
  String get rolePARENT => 'Parent / guardian';

  @override
  String get errorINVALID_CREDENTIALS => 'Wrong email or password.';

  @override
  String get errorINVALID_TOKEN => 'This link is invalid or has expired.';

  @override
  String get errorINVALID_TWO_FACTOR_CODE => 'Invalid code.';

  @override
  String get errorTOO_MANY_REQUESTS =>
      'Too many attempts. Try again in a minute.';

  @override
  String get errorNETWORK => 'Can\'t reach the server. Check your connection.';

  @override
  String get errorUNKNOWN => 'Something went wrong. Please try again.';

  @override
  String get myData => 'My details and my children';

  @override
  String get myTeams => 'My teams';

  @override
  String get noTeamsYet => 'No team assigned yet.';

  @override
  String get contacts => 'Contacts';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get city => 'City';

  @override
  String get province => 'Province';

  @override
  String get postalCode => 'Postal code';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Changes saved';

  @override
  String get teamsLabel => 'Teams';

  @override
  String get guardiansLabel => 'Guardians';

  @override
  String get athlete => 'Athlete';

  @override
  String yearsOld(int n) {
    return '$n years old';
  }

  @override
  String jerseyNumber(int n) {
    return 'no. $n';
  }

  @override
  String get players => 'Athletes';

  @override
  String get staff => 'Staff';

  @override
  String get call => 'Call';

  @override
  String get sendEmail => 'Email';

  @override
  String activateAccountTitle(String name) {
    return '$name\'s account';
  }

  @override
  String get activateAccountHint =>
      'From age 14 you can activate an account for your child: they\'ll get an email with a sign-in link.';

  @override
  String get activateAccount => 'Activate account';

  @override
  String get accountActive => 'Already has a Huddle account.';

  @override
  String invitationSent(String email) {
    return 'Invitation sent to $email';
  }

  @override
  String get availabilityINJURED => 'Injured';

  @override
  String get availabilitySUSPENDED => 'Suspended';

  @override
  String get availabilityOTHER => 'Unavailable';

  @override
  String get staffHEAD_COACH => 'Head coach';

  @override
  String get staffASSISTANT_COACH => 'Assistant coach';

  @override
  String get staffFITNESS_COACH => 'Fitness coach';

  @override
  String get staffGOALKEEPER_COACH => 'Goalkeeper coach';

  @override
  String get staffTEAM_MANAGER => 'Team manager';

  @override
  String get errorATHLETE_TOO_YOUNG =>
      'Athletes under 14 can\'t have an account.';

  @override
  String get errorPERSON_ALREADY_LINKED => 'Already has a linked account.';

  @override
  String get errorFORBIDDEN => 'You don\'t have permission for this action.';

  @override
  String get errorBAD_USER_INPUT => 'Please check the data you entered.';

  @override
  String get kindTRAINING => 'Training';

  @override
  String get kindMATCH => 'Match';

  @override
  String get kindOTHER => 'Event';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get openMap => 'Open in maps';

  @override
  String get noEvents => 'No events in the next 30 days.';

  @override
  String versus(String opponent) {
    return 'vs $opponent';
  }

  @override
  String get homeMatch => 'Home';

  @override
  String get awayMatch => 'Away';

  @override
  String get clubWide => 'Whole club';

  @override
  String get notes => 'Notes';

  @override
  String get rollCall => 'Roll call';

  @override
  String get confirmRollCall => 'Confirm roll call';

  @override
  String get rollCallDone => 'Roll call confirmed';

  @override
  String get rollCallReadOnly => 'The roll call can no longer be changed.';

  @override
  String get rollCallHint =>
      'Tap whoever is missing. Long-press for excused, injured, late or a note.';

  @override
  String get statusPRESENT => 'Present';

  @override
  String get statusABSENT => 'Absent';

  @override
  String get statusEXCUSED => 'Excused';

  @override
  String get statusINJURED => 'Injured';

  @override
  String get statusLATE => 'Late';

  @override
  String get noteLabel => 'Note';

  @override
  String absenceNotice(String reason) {
    return 'Absence reported: $reason';
  }

  @override
  String pendingChanges(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n changes to send',
      one: '1 change to send',
    );
    return '$_temp0';
  }

  @override
  String get allSent => 'All sent';

  @override
  String get offlineNotCached =>
      'Offline and no saved data for this event: try again with a connection.';

  @override
  String get rejectedChanges => 'Some changes were rejected by the server.';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get participation => 'Attendance';

  @override
  String get reportAbsence => 'Report absence';

  @override
  String get withdrawAbsence => 'Withdraw';

  @override
  String get absenceReason => 'Reason (optional)';

  @override
  String get send => 'Send';

  @override
  String get absenceReported => 'Absence reported';

  @override
  String get recentAttendance => 'Recent attendance';

  @override
  String get noAttendanceYet => 'No attendance recorded yet.';

  @override
  String get logoutPendingTitle => 'Unsent changes';

  @override
  String get logoutPendingBody =>
      'Some roll call changes haven\'t been sent yet. Signing out will discard them.';

  @override
  String get logoutAnyway => 'Sign out anyway';

  @override
  String get errorOUT_OF_WINDOW =>
      'Outside the period when the roll call can be changed.';

  @override
  String get errorEVENT_CANCELLED => 'The event was cancelled.';

  @override
  String get errorNOT_IN_ROSTER => 'The athlete is no longer in the roster.';

  @override
  String get errorEVENT_STARTED => 'The event has already started.';
}
