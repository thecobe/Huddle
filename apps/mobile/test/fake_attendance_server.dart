import 'fake_api.dart';

/// Server finto: ricorda le scritture per clientMutationId come il vero `attendance_writes`.
class FakeAttendanceServer {
  FakeAttendanceServer({List<(String, String, int, String?)>? roster})
      : roster = roster ??
            const [
              ('p1', 'Giulia', 7, null),
              ('p2', 'Paolo', 9, null),
              ('p3', 'Sara', 10, 'Gita scolastica'),
            ];

  /// Rosa: id, nome, maglia, motivo dell'assenza annunciata (o null).
  final List<(String, String, int, String?)> roster;
  bool online = true;

  /// Simula la risposta persa: il server salva ma il client riceve un errore di rete.
  bool loseNextResponse = false;
  final writes = <String, Map<String, dynamic>>{};
  final completed = <String>{};
  final rejectPeople = <String>{};
  int recordCalls = 0;

  late final link = FakeLink({
    'RollCall': (vars) {
      _network();
      final status = <String, String>{for (final w in writes.values) w['personId'] as String: w['status'] as String};
      return {
        'data': {
          'rollCall': {
            '__typename': 'RollCall',
            'eventId': vars['eventId'],
            'teamId': 't1',
            'teamName': 'Under 15',
            'kind': 'TRAINING',
            'title': null,
            'opponent': null,
            'startsAt': '2026-10-05T16:00:00.000Z',
            'endsAt': '2026-10-05T17:30:00.000Z',
            'cancelled': false,
            'completedAt': completed.contains(vars['eventId']) ? '2026-10-05T17:30:00.000Z' : null,
            'editable': true,
            'players': [
              for (final (id, name, jersey, notice) in roster)
                {
                  '__typename': 'RollCallPlayer',
                  'personId': id,
                  'firstName': name,
                  'lastName': 'Test',
                  'jerseyNumber': jersey,
                  'status': status[id],
                  'note': null,
                  'formerPlayer': false,
                  'absenceNotice': notice == null ? null : {'__typename': 'AbsenceNotice', 'id': 'n-$id', 'reason': notice},
                },
            ],
          },
        },
      };
    },
    'RecordAttendance': (vars) {
      _network();
      recordCalls++;
      final results = <Map<String, dynamic>>[];
      for (final e in (vars['entries'] as List).cast<Map<String, dynamic>>()) {
        final id = e['clientMutationId'] as String;
        String result;
        String? code;
        if (rejectPeople.contains(e['personId'])) {
          result = 'REJECTED';
          code = 'NOT_IN_ROSTER';
        } else if (writes.containsKey(id)) {
          result = 'DUPLICATE';
        } else {
          writes[id] = e;
          result = 'APPLIED';
        }
        results.add({'__typename': 'AttendanceEntryResult', 'clientMutationId': id, 'result': result, 'code': code});
      }
      if (loseNextResponse) {
        loseNextResponse = false;
        throw Exception('connessione interrotta dopo la scrittura');
      }
      return {'data': {'recordAttendance': results}};
    },
    'CompleteRollCall': (vars) {
      _network();
      completed.add(vars['eventId'] as String);
      return {
        'data': {
          'completeRollCall': {'__typename': 'RollCall', 'eventId': vars['eventId'], 'completedAt': '2026-10-05T17:30:00.000Z'},
        },
      };
    },
  });

  void _network() {
    if (!online) throw Exception('rete assente');
  }
}

