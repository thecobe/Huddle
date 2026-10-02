import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/l10n/app_localizations.dart';
import 'package:huddle/screens/club/person_screen.dart';
import 'package:huddle/screens/club/roster_screen.dart';

import 'fake_api.dart';

Map<String, dynamic> personJson({required String id, required String name, int? age, bool hasAccount = false, bool ward = true}) => {
      '__typename': 'Person',
      'id': id,
      'firstName': name,
      'lastName': 'Verdi',
      'birthDate': null,
      'age': age,
      'isMinor': age != null && age < 18,
      'hasAccount': hasAccount,
      'email': null,
      'phone': '3331234567',
      'addressLine': null,
      'city': null,
      'province': null,
      'postalCode': null,
      'teams': [
        {
          '__typename': 'PersonTeam',
          'teamId': 't1',
          'teamName': 'Under 15',
          'seasonName': '2026/27',
          'asPlayer': true,
          'staffRole': null,
          'jerseyNumber': 7,
        },
      ],
      'guardians': ward
          ? [
              {
                '__typename': 'GuardianLink',
                'id': 'g1',
                'relation': 'MOTHER',
                'person': {'__typename': 'PersonRef', 'id': 'p0', 'firstName': 'Anna', 'lastName': 'Verdi'},
              },
            ]
          : [],
    };

Widget app(FakeLink link, Widget home) => ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(ApiClient(link: link)),
        tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
      ],
      child: MaterialApp(
        locale: const Locale('it'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: home,
      ),
    );

void main() {
  testWidgets('figlio di 15 anni: il genitore può attivargli l’account', (tester) async {
    String? invitedEmail;
    final link = FakeLink({
      'MyPeople': (_) => {
            'data': {
              'myPeople': [personJson(id: 'k1', name: 'Giulia', age: 15)],
            },
          },
      'InviteAthleteAccount': (vars) {
        invitedEmail = vars['email'] as String;
        return {
          'data': {
            'invitePersonAccount': {'__typename': 'Invitation', 'id': 'i1'},
          },
        };
      },
    });
    await tester.pumpWidget(app(link, const PersonScreen(personId: 'k1')));
    await tester.pumpAndSettle();

    expect(find.text('Under 15'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Attiva account'), 200, scrollable: find.byType(Scrollable).first);
    await tester.enterText(find.widgetWithText(TextField, 'E-mail').last, 'giulia@example.test');
    await tester.tap(find.text('Attiva account'));
    await tester.pumpAndSettle();
    expect(invitedEmail, 'giulia@example.test');
    expect(find.text('Invito inviato a giulia@example.test'), findsOneWidget);
  });

  testWidgets('figlio sotto i 14 anni: nessuna attivazione', (tester) async {
    final link = FakeLink({
      'MyPeople': (_) => {
            'data': {
              'myPeople': [personJson(id: 'k2', name: 'Piccolo', age: 11)],
            },
          },
    });
    await tester.pumpWidget(app(link, const PersonScreen(personId: 'k2')));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.textContaining('Sotto i 14 anni'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Attiva account'), findsNothing);
  });

  testWidgets('rosa: disponibilità e recapiti dei tutori', (tester) async {
    final link = FakeLink({
      'TeamRoster': (_) => {
            'data': {
              'team': {
                '__typename': 'TeamDetail',
                'id': 't1',
                'name': 'Under 15',
                'seasonName': '2026/27',
                'color': '#17633e',
                'players': [
                  {
                    '__typename': 'RosterPlayer',
                    'id': 'r1',
                    'personId': 'k1',
                    'firstName': 'Giulia',
                    'lastName': 'Verdi',
                    'birthDate': null,
                    'jerseyNumber': 7,
                    'position': null,
                    'availability': 'INJURED',
                    'availabilityNote': null,
                    'email': null,
                    'phone': null,
                    'guardians': [
                      {
                        '__typename': 'GuardianContact',
                        'personId': 'p0',
                        'name': 'Anna Verdi',
                        'relation': 'MOTHER',
                        'email': 'anna@example.test',
                        'phone': '3331234567',
                      },
                    ],
                  },
                ],
                'staff': [],
              },
            },
          },
    });
    await tester.pumpWidget(app(link, const RosterScreen(teamId: 't1')));
    await tester.pumpAndSettle();
    expect(find.text('Verdi Giulia'), findsOneWidget);
    expect(find.text('Infortunato'), findsOneWidget);
    await tester.tap(find.text('Verdi Giulia'));
    await tester.pumpAndSettle();
    expect(find.text('Anna Verdi'), findsOneWidget);
    expect(find.byTooltip('Chiama 3331234567'), findsOneWidget);
  });
}
