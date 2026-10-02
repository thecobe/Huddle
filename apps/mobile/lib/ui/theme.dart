import 'package:flutter/material.dart';

/// Stessi colori del design system web (apps/web/src/styles/tokens.css).
class HuddleColors {
  static const green900 = Color(0xFF14532D);
  static const green700 = Color(0xFF17633E);
  static const lime = Color(0xFFBEF264);
  static const background = Color(0xFFF6F7F5);
}

ThemeData huddleTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: HuddleColors.green700,
    brightness: brightness,
    primary: brightness == Brightness.light ? HuddleColors.green700 : const Color(0xFF2F9E66),
    secondary: HuddleColors.lime,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: brightness == Brightness.light ? HuddleColors.background : const Color(0xFF0F1512),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
  );
}
