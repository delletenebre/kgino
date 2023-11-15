import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class KrsTheme {
  /// высота контейнера с информацией о фильме
  static const movieDetailsHeight = 220.0;
  static const movieDetailsExpandedHeight = 320.0;

  static const appBarHeight = 48.0 + (24.0 * 2);

  /// тип прокрутки содержимого
  static const scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  /// закругление углов
  static const borderRadius = BorderRadius.all(Radius.circular(24.0));

  /// длительность анимаций
  static const animationDuration = Duration(milliseconds: 250);
  static const animationDurationLong = Duration(milliseconds: 350);

  /// длительность показа уведомлений
  static const snackBarDuration = Duration(seconds: 5);

  /// отступы обычные
  static const md = 24.0;
  static const paddingMd = EdgeInsets.all(md);

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

  static Color getSurfaceContainer(BuildContext context) {
    final theme = Theme.of(context);
    CorePalette p = CorePalette.of(seedColor.value);
    return Color(p.neutral.get(theme.brightness == Brightness.dark ? 12 : 94));
  }

  /// светлая тема оформления
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Golos UI',
    colorScheme: colorScheme['light']!.copyWith(
      primary: seedColor,
    ),

    /// Define FadeUpwardsPageTransitionsBuilder as the default transition on
    /// iOS also. But again this will break the swipe back gesture on iOS
    /// убирает ненужную тень в macOS между станицами
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          return const TextStyle(fontSize: 14.0);
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme['light']!.onPrimary;
          }

          return colorScheme['light']!.onSurface;
        }),
      ),
    ),
  );

  /// тёмная тема оформления
  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Golos UI',
    colorScheme: colorScheme['dark']!,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.resolveWith((states) {
        //   return const TextStyle(fontSize: 14.0);
        // }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme['dark']!.inverseSurface;
          }

          return colorScheme['dark']!.surfaceVariant;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme['dark']!.onInverseSurface;
          }

          return colorScheme['dark']!.inverseSurface;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.resolveWith((states) {
        //   return const TextStyle(fontSize: 14.0);
        // }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme['dark']!.inverseSurface;
          }

          return null;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme['dark']!.onInverseSurface;
          }

          return colorScheme['dark']!.inverseSurface;
        }),
      ),
    ),
  );
}
