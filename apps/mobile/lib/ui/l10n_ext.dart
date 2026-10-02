import 'package:flutter/widgets.dart';

import '../api/api_client.dart';
import '../api/models.dart';
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
    _ => l.errorUNKNOWN,
  };
}
