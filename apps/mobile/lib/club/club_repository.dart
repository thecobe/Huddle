import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import '../graphql/people.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/teams.graphql.dart';

typedef MyPerson = Fragment$MyPersonFields;
typedef TeamSummary = Query$MyTeams$teams;
typedef Roster = Query$TeamRoster$team;

/// Dati della società selezionata. I provider dipendono dalla società: cambiandola si ricaricano.
class ClubRepository {
  ClubRepository(this._ref);
  final Ref _ref;

  Future<List<MyPerson>> myPeople() async {
    final data = await _ref.read(apiClientProvider).query(documentNodeQueryMyPeople);
    return Query$MyPeople.fromJson(data).myPeople;
  }

  Future<MyPerson> updateContacts(String personId, Input$PersonContactsInput input) async {
    final data = await _ref.read(apiClientProvider).mutate(
          documentNodeMutationUpdatePersonContacts,
          variables: Variables$Mutation$UpdatePersonContacts(id: personId, input: input).toJson(),
        );
    return Mutation$UpdatePersonContacts.fromJson(data).updatePersonContacts;
  }

  Future<void> inviteAthleteAccount(String personId, String email) => _ref.read(apiClientProvider).mutate(
        documentNodeMutationInviteAthleteAccount,
        variables: Variables$Mutation$InviteAthleteAccount(personId: personId, email: email.trim()).toJson(),
      );

  Future<List<TeamSummary>> myTeams() async {
    final data = await _ref.read(apiClientProvider).query(documentNodeQueryMyTeams);
    return Query$MyTeams.fromJson(data).teams;
  }

  Future<Roster> roster(String teamId) async {
    final data = await _ref.read(apiClientProvider).query(
          documentNodeQueryTeamRoster,
          variables: Variables$Query$TeamRoster(id: teamId).toJson(),
        );
    return Query$TeamRoster.fromJson(data).team;
  }
}

final clubRepositoryProvider = Provider<ClubRepository>(ClubRepository.new);

/// Rende i provider dipendenti dalla società corrente.
String? _club(Ref ref) => ref.watch(sessionProvider.select((s) => s.clubId));

final myPeopleProvider = FutureProvider<List<MyPerson>>((ref) {
  _club(ref);
  return ref.read(clubRepositoryProvider).myPeople();
});

final myTeamsProvider = FutureProvider<List<TeamSummary>>((ref) {
  _club(ref);
  return ref.read(clubRepositoryProvider).myTeams();
});

final rosterProvider = FutureProvider.family<Roster, String>((ref, teamId) {
  _club(ref);
  return ref.read(clubRepositoryProvider).roster(teamId);
});
