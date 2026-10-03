import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:huddle/api/api_client.dart';
import 'package:huddle/auth/session.dart';
import 'package:huddle/auth/token_storage.dart';
import 'package:huddle/l10n/app_localizations.dart';
import 'package:huddle/screens/club/agenda_tab.dart';

import 'fake_api.dart';

Map<String, dynamic> ev(String id, DateTime start, {String kind = 'TRAINING', String? opponent, String status = 'SCHEDULED', String? reason}) => {
      '__typename': 'CalendarEvent',
      'id': id,
      'teamId': 't1',
      'teamName': 'Under 15',
      'teamColor': '#17633e',
      'kind': kind,
      'title': null,
      'startsAt': start.toUtc().toIso8601String(),
      'endsAt': start.add(const Duration(minutes: 90)).toUtc().toIso8601String(),
      'location': 'Campo comunale',
      'notes': null,
      'status': status,
      'cancelReason': reason,
      'opponent': opponent,
      'isHome': opponent == null ? null : true,
      'competition': null,
      'canEdit': false,
    };

void main() {
  testWidgets('agenda: raggruppa per giorno, mostra gare e annullamenti', (tester) async {
    final day = DateTime.now().add(const Duration(days: 2));
    final at = DateTime(day.year, day.month, day.day, 18);
    final link = FakeLink({
      'MyAgenda': (_) => {
            'data': {
              'myAgenda': [
                ev('e1', at),
                ev('e2', at.add(const Duration(hours: 1)), kind: 'MATCH', opponent: 'ASD Rivali'),
                ev('e3', at.add(const Duration(days: 1)), status: 'CANCELLED', reason: 'Campo allagato'),
              ],
            },
          },
    });
    await tester.pumpWidget(ProviderScope(
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
        home: Scaffold(body: AgendaTab()),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Allenamento'), findsNWidgets(2));
    expect(find.text('vs ASD Rivali'), findsOneWidget);
    expect(find.text('Annullato: Campo allagato'), findsOneWidget);
    // Due giorni distinti: due intestazioni.
    expect(find.textContaining(RegExp(r'^(Lunedì|Martedì|Mercoledì|Giovedì|Venerdì|Sabato|Domenica)')), findsNWidgets(2));
  });
}
