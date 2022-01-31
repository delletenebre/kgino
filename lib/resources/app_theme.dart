import 'package:flutter/material.dart';

class AppTheme {

  static const sliderCardSize = 140.0;

  static final dark = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xffe42520),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
      )
    ),
  );



}