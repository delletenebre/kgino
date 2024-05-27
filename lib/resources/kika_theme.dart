import 'package:flutter/material.dart';

/// ширина навигационной панели
const kDrawerWidth = 260.0;

// const kCardHeight = 196.0 / (16 / 9);
const kCardWidth = 196.0;
const kCardHeight = 110.0; //kCardWidth / (16 / 9);
const kCardMaxHeight = kCardHeight + 21; // * 1.1;
const kListTitleHeight = 40.0;

class KikaTheme {
  /// тип прокрутки содержимого
  static const scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  /// стиль [FilledButton] для кнопок удаления
  static ButtonStyle dangerButtonStyleOf(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton.styleFrom(
      foregroundColor: theme.colorScheme.onError,
      backgroundColor: theme.colorScheme.error,
    );
  }

  /// главный цвет в соответствии с Material You
  static const seedColor = Color(0xff2e71e5);

  /// генерируем цветовые схемы в соответствии с Material You
  static final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: seedColor,
  );

  /// тёмная тема оформления
  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: seedColor,
    fontFamily: 'Golos UI',

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
        // textStyle: MaterialStateProperty.resolveWith((states) {
        //   return const TextStyle(fontSize: 14.0);
        // }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.inverseSurface;
          }

          return colorScheme.surfaceContainerHighest;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.onInverseSurface;
          }

          return colorScheme.inverseSurface;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.resolveWith((states) {
        //   return const TextStyle(fontSize: 14.0);
        // }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.inverseSurface;
          }

          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.onInverseSurface;
          }

          return colorScheme.inverseSurface;
        }),
      ),
    ),
  );
}

class TvUi {
  static const navigationBarSize = Size.fromHeight(32.0 + TvUi.vPadding * 2);

  static const columnWidth = 52.0;
  static const columnSpacing = 20.0;

  static const hPadding = 58.0;
  static const vPadding = 24.0;

  static const horizontalCardSize = Size(196.0, 110.0);
  static const verticalCardSize = Size(124.0, 186.0);

  static const backdropImageSize = Size(758.0, 428.0);

  static const cardListBottomSpacing = 86.0;
  static const cardListTitleHeight = 44.0;
  static final cardListHeight =
      cardListTitleHeight + horizontalCardSize.height + cardListBottomSpacing;

  static const featuredSize = Size(484.0, 316.0);
  static const featuredWidth = 484.0;
  static const featuredHeight = 316.0;

  static double verticalListHeight = horizontalCardSize.height + 44.0 + 24.0;
  static double verticalListHeightPad = verticalListHeight + 12.0;
}
