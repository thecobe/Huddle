import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/offline/attendance_repository.dart';
import 'package:huddle/offline/offline_database.dart';

import 'fake_attendance_server.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late OfflineDatabase db;
  late FakeAttendanceServer server;
  late AttendanceRepository repo;

  setUp(() async {
    db = OfflineDatabase(NativeDatabase.memory());
    server = FakeAttendanceServer();
    repo = AttendanceRepository(db, ApiClient(link: server.link));
    await repo.claim('coach-1');
    await repo.refresh('e1');
  });
  tearDown(() => db.close());

  test('stato proposto: presenti, e giustificato chi ha un’assenza annunciata', () async {
    final view = await repo.watch('e1').first;
    expect({for (final e in view!.entries) e.firstName: e.status}, {
      'Giulia': 'PRESENT',
      'Paolo': 'PRESENT',
      'Sara': 'EXCUSED',
    });
    expect(view.entries.last.note, 'Gita scolastica');
  });

  test('appello senza rete: resta in coda e parte al ritorno della connessione', () async {
    server.online = false;
    await repo.setStatus('e1', 'p2', AttendanceStatus.absent, note: 'Influenza');
    await repo.complete('e1');
    expect(await repo.watchPendingCount().first, 4); // Paolo + Giulia e Sara confermati + conferma appello

    final view = await repo.watch('e1').first;
    expect(view!.entries.firstWhere((e) => e.personId == 'p2').pending, isTrue);
    await expectLater(repo.flush(), throwsA(isA<ApiException>().having((e) => e.code, 'code', 'NETWORK')));
    expect(await repo.watchPendingCount().first, 4);

    server.online = true;
    expect(await repo.flush(), isTrue);
    expect(await repo.watchPendingCount().first, 0);
    expect(server.writes.values.map((w) => '${w['personId']}:${w['status']}').toSet(), {'p1:PRESENT', 'p2:ABSENT', 'p3:EXCUSED'});
    expect(server.completed, {'e1'});
    final after = await repo.watch('e1').first;
    expect(after!.entries.every((e) => !e.pending), isTrue);
    expect(after.event.completedAt, isNotNull);
  });

  test('risposta persa dopo la scrittura: il reinvio non crea doppioni', () async {
    await repo.setStatus('e1', 'p1', AttendanceStatus.late);
    server.loseNextResponse = true;
    await expectLater(repo.flush(), throwsA(isA<ApiException>()));
    expect(server.writes, hasLength(1));
    expect(await repo.watchPendingCount().first, 1);

    expect(await repo.flush(), isTrue);
    expect(server.writes, hasLength(1));
    expect(server.recordCalls, 2);
  });

  test('righe rifiutate: fuori dalla coda attiva, visibili finché non si scartano', () async {
    server.rejectPeople.add('p2');
    await repo.setStatus('e1', 'p2', AttendanceStatus.absent);
    await repo.setStatus('e1', 'p1', AttendanceStatus.present);
    expect(await repo.flush(), isTrue);
    final rejected = await repo.watchRejected().first;
    expect(rejected.map((r) => r.rejectedCode), ['NOT_IN_ROSTER']);
    await repo.dismissRejected();
    expect(await repo.watchRejected().first, isEmpty);
  });

  test('cambio di account: i dati locali del precedente vengono cancellati', () async {
    await repo.setStatus('e1', 'p1', AttendanceStatus.absent);
    await repo.claim('coach-1');
    expect(await repo.watchPendingCount().first, 1);
    await repo.claim('altro-utente');
    expect(await repo.watchPendingCount().first, 0);
    expect(await repo.watch('e1').first, isNull);
  });
}
