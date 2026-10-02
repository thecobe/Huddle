import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/session.dart';
import 'deep_links.dart';
import 'l10n/app_localizations.dart';
import 'router.dart';
import 'ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: HuddleApp()));
}

class HuddleApp extends ConsumerStatefulWidget {
  const HuddleApp({super.key});

  @override
  ConsumerState<HuddleApp> createState() => _HuddleAppState();
}

class _HuddleAppState extends ConsumerState<HuddleApp> {
  @override
  void initState() {
    super.initState();
    ref.read(sessionProvider.notifier).bootstrap();
    listenToDeepLinks(ref.read(routerProvider));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: huddleTheme(Brightness.light),
      darkTheme: huddleTheme(Brightness.dark),
      routerConfig: ref.watch(routerProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
