import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session.dart';
import '../graphql/calendar.graphql.dart';
import '../graphql/people.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/teams.graphql.dart';

typedef MyPerson = Fragment$MyPersonFields;
typedef TeamSummary = Query$MyTeams$teams;
typedef Roster = Query$TeamRoster$team;
typedef AgendaEvent = Fragment$AgendaEvent;

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

  Future<List<AgendaEvent>> agenda(DateTime from, DateTime to) async {
    final data = await _ref.read(apiClientProvider).query(
          documentNodeQueryMyAgenda,
          variables: Variables$Query$MyAgenda(from: from.toUtc().toIso8601String(), to: to.toUtc().toIso8601String()).toJson(),
        );
    return Query$MyAgenda.fromJson(data).myAgenda;
  }

  Future<AgendaEvent> event(String id) async {
    final data = await _ref.read(apiClientProvider).query(
          documentNodeQueryEventDetail,
          variables: Variables$Query$EventDetail(id: id).toJson(),
        );
    return Query$EventDetail.fromJson(data).event;
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

/// Agenda dei prossimi 30 giorni (da inizio giornata).
final agendaProvider = FutureProvider<List<AgendaEvent>>((ref) {
  _club(ref);
  final now = DateTime.now();
  final from = DateTime(now.year, now.month, now.day);
  return ref.read(clubRepositoryProvider).agenda(from, from.add(const Duration(days: 30)));
});

final eventProvider = FutureProvider.family<AgendaEvent, String>((ref, id) {
  _club(ref);
  return ref.read(clubRepositoryProvider).event(id);
});
