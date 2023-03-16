import 'package:flutter/material.dart';

class KrsTheme {

  /// тип прокрутки содержимого
  static const scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  /// закругление углов
  static const borderRadius = BorderRadius.all(Radius.circular(24.0));

  /// длительность анимаций
  static const animationDuration = Duration(milliseconds: 250);

  /// длительность быстрых анимаций
  static const fastAnimationDuration = Duration(milliseconds: 60);

  /// длительность показа уведомлений
  static const snackBarDuration = Duration(seconds: 5);

  /// стиль [ElevatedButton] для Filled-style
  static ButtonStyle filledButtonStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton.styleFrom(
      foregroundColor: theme.colorScheme.onPrimary,
      backgroundColor: theme.colorScheme.primary,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
  }

  static ButtonStyle filledTonalButtonStyleOf (BuildContext context) {
    return ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    ).copyWith(
      elevation: ButtonStyleButton.allOrNull(0.0)
    );
  }

  /// главный цвет
  static const seedColor = Color(0xff1a5dea);

  /// генерируем цветовые схемы в соответствии с Material You
  static final colorScheme = {
    'light': ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: seedColor,
    ),

    'dark': ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: seedColor,
    ),
  };

  /// светлая тема оформления
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Golos UI',
    visualDensity: VisualDensity.adaptivePlatformDensity,

    colorScheme: colorScheme['light']!.copyWith(
      primary: seedColor,
      //shadow: colorScheme['light']!.shadow,
    ),

    /// Define FadeUpwardsPageTransitionsBuilder as the default transition on
    /// iOS also. But again this will break the swipe back gesture on iOS
    /// убирает ненужную тень в macOS между станицами
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      }
    ),
  );

  /// тёмная тема оформления
  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Golos UI',
    visualDensity: VisualDensity.adaptivePlatformDensity,

    colorScheme: colorScheme['dark']!.copyWith(
      //primary: seedColor,
      shadow: colorScheme['dark']!.shadow.withOpacity(0.33),
    ),

  );

}