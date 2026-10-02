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
}
