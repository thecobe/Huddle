import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/l10n/app_localizations.dart';
import 'package:huddle/offline/attendance_repository.dart';
import 'package:huddle/offline/attendance_sync.dart';
import 'package:huddle/offline/offline_database.dart';
import 'package:huddle/offline/sync_providers.dart';
import 'package:huddle/screens/club/roll_call_screen.dart';

import 'fake_attendance_server.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('appello di 20 atleti con 3 assenti: 4 tocchi, tutto inviato', (tester) async {
    final server = FakeAttendanceServer(roster: [
      for (var i = 1; i <= 20; i++) ('p$i', 'Atleta$i', i, null),
    ]);
    final db = OfflineDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final api = ApiClient(link: server.link);
    final repo = AttendanceRepository(db, api);
    await tester.runAsync(() => repo.claim('coach-1'));

    var taps = 0;
    Future<void> tap(Finder f) async {
      taps++;
      // Scorrere fino all'atleta non è un tocco: la lista mostra solo le righe visibili.
      await tester.scrollUntilVisible(f, 200, scrollable: find.byType(Scrollable).first);
      await tester.tap(f);
      // Il database locale e l'invio lavorano in tempo reale: lasciamo loro spazio.
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pumpAndSettle();
    }

    await tester.pumpWidget(ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(api),
        tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
        offlineDatabaseProvider.overrideWithValue(db),
        attendanceSyncProvider.overrideWithValue(AttendanceSync(repo, connectivity: const Stream.empty())),
      ],
      child: const MaterialApp(
        locale: Locale('it'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: RollCallScreen(eventId: 'e1'),
      ),
    ));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pumpAndSettle();
    expect(find.text('20/20'), findsOneWidget);

    await tap(find.text('Test Atleta2'));
    await tap(find.text('Test Atleta5'));
    await tap(find.text('Test Atleta9'));
    expect(find.text('17/20'), findsOneWidget);
    taps++;
    await tester.tap(find.text('Conferma appello'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pumpAndSettle();

    expect(taps, lessThanOrEqualTo(30));
    final statuses = {for (final w in server.writes.values) w['personId']: w['status']};
    expect(statuses, hasLength(20));
    expect(statuses.entries.where((e) => e.value == 'ABSENT').map((e) => e.key).toSet(), {'p2', 'p5', 'p9'});
    expect(server.completed, {'e1'});

    // drift chiude i flussi delle query con un timer a zero: smontiamo e lasciamolo scattare.
    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
  });
}
