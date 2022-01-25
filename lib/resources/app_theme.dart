import 'package:flutter/material.dart';
import 'package:kgino/resources/zoom_transition.dart';

class AppTheme {

  static const sliderCardSize = 140.0;

  static final dark = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xffe42520),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),

    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: ZoomSlideUpTransitionsBuilder(),
        TargetPlatform.macOS: ZoomSlideUpTransitionsBuilder(),
      }
    )
  );



}