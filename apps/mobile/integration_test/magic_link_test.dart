import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/deep_links.dart';
import 'package:huddle/main.dart';
import 'package:huddle/router.dart';
import 'package:integration_test/integration_test.dart';

/// Contro l'API locale con i dati di `pnpm --filter @huddle/api seed:demo`, che stampa i magic link.
///
/// `flutter test integration_test -d ID_SIMULATORE --dart-define-from-file=env/dev.json --dart-define=COACH_LINK=… --dart-define=PARENT_LINK=…`
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const coachLink = String.fromEnvironment('COACH_LINK');
  const parentLink = String.fromEnvironment('PARENT_LINK');

  /// Avvia l'app in italiano, apre il magic link e attende l'accesso con l'API reale.
  Future<ProviderContainer> signIn(WidgetTester tester, String link) async {
    expect(link, isNotEmpty, reason: 'Passare il magic link con --dart-define');
    tester.platformDispatcher.localesTestValue = const [Locale('it')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final container = ProviderContainer(overrides: [tokenStorageProvider.overrideWithValue(MemoryTokenStorage())]);
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
