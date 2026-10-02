import '../graphql/fragments.graphql.dart';
import '../graphql/invitations.graphql.dart';
import '../graphql/schema.graphql.dart';

/// Ruoli dell'app. Derivati dall'enum generato, con le regole di interfaccia.
enum MembershipRole {
  admin,
  secretary,
  sportsDirector,
  coach,
  teamManager,
  athlete,
  parent;

  /// Null per ruoli introdotti sul server dopo questa versione dell'app: vengono ignorati,
  /// così un ruolo sconosciuto non concede mai accesso.
  static MembershipRole? fromGraphql(Enum$MembershipRole role) => switch (role) {
        Enum$MembershipRole.ADMIN => admin,
        Enum$MembershipRole.SECRETARY => secretary,
        Enum$MembershipRole.SPORTS_DIRECTOR => sportsDirector,
        Enum$MembershipRole.COACH => coach,
        Enum$MembershipRole.TEAM_MANAGER => teamManager,
        Enum$MembershipRole.ATHLETE => athlete,
        Enum$MembershipRole.PARENT => parent,
        Enum$MembershipRole.$unknown => null,
      };

  /// Staff tecnico: in app vede gli strumenti di squadra (presenze, convocazioni) dalla Fase 1.
  bool get isStaff => this == coach || this == teamManager || this == sportsDirector;

  /// Ruoli amministrativi: la gestione completa è sul web.
  bool get isOffice => this == admin || this == secretary;
}

class Membership {
  Membership({required this.id, required this.role, required this.clubId, required this.clubName, this.teamId});

  final String id;
  final MembershipRole role;
  final String? teamId;
  final String clubId;
  final String clubName;
}

class Me {
  Me({
    required this.id,
    required this.email,
    required this.fullName,
    required this.locale,
    required this.twoFactorEnabled,
    required this.memberships,
  });

  factory Me.fromFragment(Fragment$MeFields f) => Me(
        id: f.id,
        email: f.email,
        fullName: f.fullName,
        locale: f.locale,
        twoFactorEnabled: f.twoFactorEnabled,
        memberships: [
          for (final m in f.memberships)
            if (MembershipRole.fromGraphql(m.role) case final role?)
              Membership(id: m.id, role: role, teamId: m.teamId, clubId: m.clubId, clubName: m.clubName),
        ],
      );

  final String id;
  final String email;
  final String fullName;
  final String locale;
  final bool twoFactorEnabled;
  final List<Membership> memberships;

  /// Società distinte a cui l'utente appartiene, con i relativi ruoli.
  List<ClubAccess> get clubs {
    final byId = <String, ClubAccess>{};
    for (final m in memberships) {
      byId.putIfAbsent(m.clubId, () => ClubAccess(id: m.clubId, name: m.clubName, roles: [])).roles.add(m.role);
    }
    return byId.values.toList()..sort((a, b) => a.name.compareTo(b.name));
  }
}

class ClubAccess {
  ClubAccess({required this.id, required this.name, required this.roles});
  final String id;
  final String name;
  final List<MembershipRole> roles;
}

enum AuthStatus { authenticated, twoFactorRequired }

class AuthPayload {
  AuthPayload({required this.status, this.accessToken, this.refreshToken, this.challengeToken, this.user});

  factory AuthPayload.fromFragment(Fragment$AuthFields f) => AuthPayload(
        status: f.status == Enum$AuthStatus.TWO_FACTOR_REQUIRED ? AuthStatus.twoFactorRequired : AuthStatus.authenticated,
        accessToken: f.accessToken,
        refreshToken: f.refreshToken,
        challengeToken: f.challengeToken,
        user: f.user == null ? null : Me.fromFragment(f.user!),
      );

  final AuthStatus status;
  final String? accessToken;
  final String? refreshToken;
  final String? challengeToken;
  final Me? user;
}

class InvitationPreview {
  InvitationPreview({
    required this.clubId,
    required this.clubName,
    required this.email,
    required this.role,
    required this.accountExists,
  });

  factory InvitationPreview.fromQuery(Query$InvitationPreview$invitationPreview q) => InvitationPreview(
        clubId: q.clubId,
        clubName: q.clubName,
        email: q.email,
        role: MembershipRole.fromGraphql(q.role),
        accountExists: q.accountExists,
      );

  final String clubId;
  final String clubName;
  final String email;

  /// Null se il ruolo non è noto a questa versione dell'app.
  final MembershipRole? role;
  final bool accountExists;
}
