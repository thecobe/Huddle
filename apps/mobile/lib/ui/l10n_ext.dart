import 'package:flutter/widgets.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../graphql/schema.graphql.dart';
import '../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension RoleLabel on MembershipRole {
  String label(AppLocalizations l) => switch (this) {
        MembershipRole.admin => l.roleADMIN,
        MembershipRole.secretary => l.roleSECRETARY,
        MembershipRole.sportsDirector => l.roleSPORTS_DIRECTOR,
        MembershipRole.coach => l.roleCOACH,
        MembershipRole.teamManager => l.roleTEAM_MANAGER,
        MembershipRole.athlete => l.roleATHLETE,
        MembershipRole.parent => l.rolePARENT,
      };
}

/// Messaggio tradotto per un errore dell'API.
String errorMessage(AppLocalizations l, Object error) {
  final code = error is ApiException ? error.code : 'UNKNOWN';
  return switch (code) {
    'INVALID_CREDENTIALS' => l.errorINVALID_CREDENTIALS,
    'INVALID_TOKEN' => l.errorINVALID_TOKEN,
    'INVALID_TWO_FACTOR_CODE' => l.errorINVALID_TWO_FACTOR_CODE,
    'TOO_MANY_REQUESTS' => l.errorTOO_MANY_REQUESTS,
    'NETWORK' => l.errorNETWORK,
    'ATHLETE_TOO_YOUNG' => l.errorATHLETE_TOO_YOUNG,
    'PERSON_ALREADY_LINKED' => l.errorPERSON_ALREADY_LINKED,
    'FORBIDDEN' => l.errorFORBIDDEN,
    'BAD_USER_INPUT' => l.errorBAD_USER_INPUT,
    _ => l.errorUNKNOWN,
  };
}

extension StaffRoleLabel on Enum$StaffRole {
  String label(AppLocalizations l) => switch (this) {
        Enum$StaffRole.HEAD_COACH => l.staffHEAD_COACH,
        Enum$StaffRole.ASSISTANT_COACH => l.staffASSISTANT_COACH,
        Enum$StaffRole.FITNESS_COACH => l.staffFITNESS_COACH,
        Enum$StaffRole.GOALKEEPER_COACH => l.staffGOALKEEPER_COACH,
        Enum$StaffRole.TEAM_MANAGER => l.staffTEAM_MANAGER,
        Enum$StaffRole.$unknown => '',
      };
}

/// Etichetta di disponibilità; null se l'atleta è disponibile.
String? availabilityLabel(AppLocalizations l, Enum$PlayerAvailability a) => switch (a) {
      Enum$PlayerAvailability.INJURED => l.availabilityINJURED,
      Enum$PlayerAvailability.SUSPENDED => l.availabilitySUSPENDED,
      Enum$PlayerAvailability.OTHER => l.availabilityOTHER,
      _ => null,
    };

extension EventKindLabel on Enum$EventKind {
  String label(AppLocalizations l) => switch (this) {
        Enum$EventKind.TRAINING => l.kindTRAINING,
        Enum$EventKind.MATCH => l.kindMATCH,
        _ => l.kindOTHER,
      };
}
