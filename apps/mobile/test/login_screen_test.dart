import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/l10n/app_localizations.dart';
import 'package:huddle/screens/login_screen.dart';

import 'fake_api.dart';

Widget app(FakeLink link) => ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(ApiClient(link: link)),
        tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
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
        home: LoginScreen(),
      ),
    );

void main() {
  testWidgets('magic link come accesso predefinito', (tester) async {
    final link = FakeLink({'RequestMagicLink': (_) => {'data': {'requestMagicLink': true}}});
    await tester.pumpWidget(app(link));
    await tester.enterText(find.byType(TextField), 'genitore@example.test');
    await tester.tap(find.text('Ricevi un link via e-mail'));
    await tester.pumpAndSettle();
    expect(find.textContaining('riceverai un\'e-mail'), findsOneWidget);
    expect(link.calls, ['RequestMagicLink']);
  });

  testWidgets('password errata mostra il messaggio tradotto', (tester) async {
    final link = FakeLink({'Login': (_) => error('INVALID_CREDENTIALS')});
    await tester.pumpWidget(app(link));
    await tester.tap(find.text('Accedi con password'));
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, 'a@example.test');
    await tester.enterText(find.byType(TextField).last, 'sbagliata');
    await tester.tap(find.widgetWithText(FilledButton, 'Accedi'));
    await tester.pumpAndSettle();
    expect(find.text('E-mail o password non corretti.'), findsOneWidget);
  });
}
