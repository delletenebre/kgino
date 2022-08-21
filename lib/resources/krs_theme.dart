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

  /// длительность показа уведомлений
  static const snackBarDuration = Duration(seconds: 5);

  /// стиль [ElevatedButton] для Filled-style
  static ButtonStyle filledButtonStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton.styleFrom(
      onPrimary: theme.colorScheme.onPrimary,
      primary: theme.colorScheme.primary,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
  }

  /// главный цвет
  static const seedColor = Color(0xffe50914);

  /// генерируем цветовые схемы в соответствии с Material You
  static final colorScheme = {
    'light': ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),

    'dark': ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
  };

  /// светлая тема оформления
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    
    fontFamily: 'Galos UI',

    colorScheme: colorScheme['light']!.copyWith(
      primary: seedColor,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      backgroundColor: colorScheme['light']!.primaryContainer,
      foregroundColor: colorScheme['light']!.onPrimaryContainer,
      elevation: 3.0,
    ),

    /// Define FadeUpwardsPageTransitionsBuilder as the default transition on
    /// iOS also. But again this will break the swipe back gesture on iOS
    /// убирает ненужную тень в macOS между станицами
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      }
    ),

    // navigationBarTheme: const NavigationBarThemeData().copyWith(
    //   indicatorColor: colorScheme['light']!.secondaryContainer,

    //   iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       /// ^ если активна
          
    //       return IconThemeData(
    //         color: colorScheme['light']!.onSecondaryContainer,
    //       );
        
    //     } else {
    //       /// ^ если неактивна

    //       return IconThemeData(
    //         color: colorScheme['light']!.onSurfaceVariant,
    //       );

    //     }
    //   }),

    //   labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       /// ^ если активна
          
    //       return TextStyle(
    //         color: colorScheme['light']!.onSurface,
    //         fontSize: 12.0,
    //         letterSpacing: 1.0,
    //       );
        
    //     } else {
    //       /// ^ если неактивна

    //       return TextStyle(
    //         color: colorScheme['light']!.onSurfaceVariant,
    //         fontSize: 12.0,
    //         letterSpacing: 1.0,
    //       );

    //     }
    //   }),

    // ),
  );

  /// тёмная тема оформления
  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    fontFamily: 'Galos UI',

    colorScheme: colorScheme['dark']!.copyWith(
      primary: seedColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme['dark']!.secondary,
      foregroundColor: colorScheme['dark']!.onSecondary,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      backgroundColor: colorScheme['dark']!.primaryContainer,
      foregroundColor: colorScheme['dark']!.onPrimaryContainer,
      elevation: 3.0,
    ),

    /// Define FadeUpwardsPageTransitionsBuilder as the default transition on
    /// iOS also. But again this will break the swipe back gesture on iOS
    /// убирает ненужную тень в macOS между станицами
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      }
    ),
  );


  static List<BoxShadow> cardShadow(BuildContext context) {
    return <BoxShadow>[
      BoxShadow(
        offset: const Offset(0.0, 1.0),
        color: Theme.of(context).colorScheme.shadow,
        blurRadius: 2.0,
      ),
    ];
  }
  
  static BoxDecoration boxDecoration(BuildContext context, {
    bool enabled = true
  }) {
    final theme = Theme.of(context);

    return BoxDecoration(
      borderRadius: borderRadius,
      color: theme.colorScheme.surface,
      boxShadow: [
        BoxShadow(
          offset: enabled ? const Offset(0.0, 1.0) : Offset.zero,
          color: theme.colorScheme.shadow,
          blurRadius: enabled ? 2.0 : 1.0,
        ),
      ],
    );
  }

}