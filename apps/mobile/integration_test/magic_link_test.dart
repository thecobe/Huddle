import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/deep_links.dart';
import 'package:huddle/main.dart';
import 'package:huddle/router.dart';
import 'package:integration_test/integration_test.dart';

/// Contro l'API locale: apre un magic link reale (passato con --dart-define=MAGIC_LINK=huddle://…)
/// e verifica che l'utente arrivi alla home della sua società.
///
/// `flutter test integration_test -d ID_SIMULATORE --dart-define-from-file=env/dev.json --dart-define=MAGIC_LINK=…`
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const link = String.fromEnvironment('MAGIC_LINK');

  testWidgets('magic link: accesso e home della società', (tester) async {
    expect(link, isNotEmpty, reason: 'Passare --dart-define=MAGIC_LINK=…');
    final container = ProviderContainer(overrides: [
      tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const HuddleApp()));
    await tester.pumpAndSettle();

    container.read(routerProvider).go(routeForDeepLink(Uri.parse(link))!);
    // Attende la risposta dell'API reale: serve tempo reale, non quello simulato del test.
    for (var i = 0; i < 50 && !container.read(sessionProvider).isAuthenticated; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
      await tester.pump();
    }
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    final session = container.read(sessionProvider);
    expect(session.isAuthenticated, isTrue);
    expect(session.currentClub?.name, 'ASD Aurora');
    expect(find.textContaining('Luca'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
