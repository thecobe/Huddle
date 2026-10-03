import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/config/env.dart';
import 'package:huddle/offline/attendance_repository.dart';
import 'package:huddle/offline/sync_providers.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/deep_links.dart';
import 'package:huddle/main.dart';
import 'package:huddle/router.dart';
import 'package:integration_test/integration_test.dart';

/// Contro l'API locale con i dati di `pnpm --filter @huddle/api seed:demo`, che stampa i magic link.
///
/// `flutter test integration_test -d ID_SIMULATORE --dart-define-from-file=env/dev.json --dart-define-from-file=links.json`
/// con COACH_LINK, COACH_LINK_2, PARENT_LINK, PARENT_LINK_2 e ROLL_CALL_EVENT_ID stampati dallo script.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const coachLink = String.fromEnvironment('COACH_LINK');
  const parentLink = String.fromEnvironment('PARENT_LINK');
  // I magic link sono monouso: il secondo test del genitore ne usa un altro.
  const parentLink2 = String.fromEnvironment('PARENT_LINK_2');
  const coachLink2 = String.fromEnvironment('COACH_LINK_2');
  const rollCallEventId = String.fromEnvironment('ROLL_CALL_EVENT_ID');

  /// Avvia l'app in italiano, apre il magic link e attende l'accesso con l'API reale.
  Future<ProviderContainer> signIn(WidgetTester tester, String link, {ToggleLink? network}) async {
    expect(link, isNotEmpty, reason: 'Passare il magic link con --dart-define');
    tester.platformDispatcher.localesTestValue = const [Locale('it')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final container = ProviderContainer(overrides: [
      tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
      if (network != null) apiClientProvider.overrideWithValue(ApiClient(link: network)),
    ]);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const HuddleApp()));
    await tester.pumpAndSettle();
    container.read(routerProvider).go(routeForDeepLink(Uri.parse(link))!);
    await waitFor(tester, () => container.read(sessionProvider).isAuthenticated);
    expect(container.read(sessionProvider).currentClub?.name, 'ASD Aurora');
    return container;
  }

  testWidgets('allenatore: rosa della squadra con i recapiti dei tutori', (tester) async {
    await signIn(tester, coachLink);
    await tester.tap(find.text('Squadra'));
    await waitFor(tester, () => find.text('Under 15').evaluate().isNotEmpty);
    await tester.tap(find.text('Under 15'));
    await waitFor(tester, () => find.text('Verdi Giulia').evaluate().isNotEmpty);
    expect(find.text('Under 12'), findsNothing);
    await tester.tap(find.text('Verdi Giulia'));
    await settle(tester);
    expect(find.text('Anna Verdi'), findsOneWidget);
  });

  testWidgets('genitore: i due figli, attivazione account solo dai 14 anni', (tester) async {
    await signIn(tester, parentLink);
    await tester.tap(find.text('Profilo'));
    await waitFor(tester, () => find.text('Giulia Verdi').evaluate().isNotEmpty);
    expect(find.text('Marco Verdi'), findsOneWidget);

    await tester.tap(find.text('Giulia Verdi'));
    await waitFor(tester, () => find.text('Under 15').evaluate().isNotEmpty);
    await tester.scrollUntilVisible(find.text('Attiva account'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Attiva account'), findsOneWidget);
  });

  testWidgets('genitore: agenda con allenamenti e gara della squadra della figlia', (tester) async {
    await signIn(tester, parentLink2);
    await tester.tap(find.text('Calendario'));
    await waitFor(tester, () => find.text('Allenamento').evaluate().isNotEmpty);
    expect(find.text('vs ASD Rivali'), findsOneWidget);
    await tester.tap(find.text('vs ASD Rivali'));
    await waitFor(tester, () => find.text('Apri nelle mappe').evaluate().isNotEmpty);
    expect(find.text('In trasferta · Campionato provinciale'), findsOneWidget);
  });

  testWidgets('allenatore: appello senza rete, inviato una sola volta al ritorno della connessione', (tester) async {
    expect(rollCallEventId, isNotEmpty);
    final network = ToggleLink(HttpLink(Env.apiUrl));
    final container = await signIn(tester, coachLink2, network: network);
    final repo = container.read(attendanceRepositoryProvider);
    // Con la rete ancora attiva: l'allenamento in corso viene salvato in locale (come fa il precaricamento).
    await tester.runAsync(() => repo.refresh(rollCallEventId));

    network.offline = true;
    container.read(routerProvider).push('/home/rollcall/$rollCallEventId');
    await waitFor(tester, () => find.text('Conferma appello').evaluate().isNotEmpty);
    await tester.tap(find.text('Verdi Giulia'));
    await settle(tester);
    await tester.tap(find.text('Conferma appello'));
    await waitFor(tester, () => find.byIcon(Icons.cloud_off_outlined).evaluate().isNotEmpty);
    final pendingOffline = await tester.runAsync(() => repo.watchPendingCount().first);
    expect(pendingOffline, greaterThan(1));

    network.offline = false;
    await tester.runAsync(() => container.read(attendanceSyncProvider).trigger());
    await waitFor(tester, () => find.byIcon(Icons.cloud_off_outlined).evaluate().isEmpty);
    expect(await tester.runAsync(() => repo.watchPendingCount().first), 0);

    // Il server ha l'appello confermato, con Giulia assente e gli altri presenti.
    final view = await tester.runAsync(() async {
      await repo.refresh(rollCallEventId);
      return repo.watch(rollCallEventId).first;
    });
    expect(view!.event.completedAt, isNotNull);
    expect(view.entries.firstWhere((e) => e.firstName == 'Giulia').status, AttendanceStatus.absent);
    expect(view.entries.where((e) => e.firstName != 'Giulia').every((e) => e.status == AttendanceStatus.present), isTrue);
    expect(view.entries.every((e) => !e.pending), isTrue);
  });
}

/// Link GraphQL che si può "staccare" per simulare l'assenza di rete.
class ToggleLink extends Link {
  ToggleLink(this._inner);
  final Link _inner;
  bool offline = false;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    if (offline) return Stream.error(Exception('rete assente (simulata)'));
    return _inner.request(request, forward);
  }
}

/// Attende una condizione dando tempo reale alle richieste HTTP (il tempo del test è simulato).
Future<void> waitFor(WidgetTester tester, bool Function() condition) async {
  for (var i = 0; i < 50 && !condition(); i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pump();
  }
  await settle(tester);
  expect(condition(), isTrue);
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
