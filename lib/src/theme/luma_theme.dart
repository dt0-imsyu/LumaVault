import 'package:flutter/material.dart';

class LumaTheme {
  static ThemeData dark() {
    const surface = Color(0xFF071318);
    const panel = Color(0xFF0E252B);
    const mint = Color(0xFF22E0B8);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mint,
        brightness: Brightness.dark,
        surface: surface,
        primary: mint,
        secondary: const Color(0xFFFFC857),
      ),
      cardTheme: CardThemeData(
        color: panel,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}
