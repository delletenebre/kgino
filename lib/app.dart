import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'pages/error_page.dart';
import 'pages/ockg/ockg_home_page.dart';
import 'pages/settings_page.dart';
import 'resources/krs_theme.dart';
import 'ui/scaffold_with_navigation_bar.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(context) {
  
    return MultiBlocProvider(
      providers: [
        /// контроллер темы оформления
        BlocProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),

        /// контроллер языка приложения
        BlocProvider<LocaleController>(
          create: (_) => LocaleController(),
        ),

      ],
      child: Builder(
        builder: (context) {
          /// текущая тема оформления
          final themeMode = context.watch<ThemeController>().state;

          /// текущий язык приложения
          final locale = context.watch<LocaleController>().state;

          final router = GoRouter(
            initialLocation: '/',

            errorBuilder: (context, state) => const ErrorPage(),

            routes: <RouteBase>[

              GoRoute(
                path: '/',
                builder: (context, state) {
                  return const OckgHomePage();
                },
              ),

              // GoRoute(
              //   path: '/',
              //   builder: (context, state) {
              //     return const OckgHomePage();
              //   },
              // ),

              GoRoute(
                path: '/settings',
                builder: (context, state) {
                  return const SettingsPage();
                },
                routes: <RouteBase>[
                  /// The details screen to display stacked on the inner Navigator.
                  // GoRoute(
                  //   path: 'song/:songId',
                  //   builder: (context, state) {
                  //     return const SettingsPage();
                  //   },
                  // ),
                ],
              ),
              
            ],
          );

          return MaterialApp.router(
            routerConfig: router,

            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(locale),

            theme: KrsTheme.light,
            darkTheme: KrsTheme.dark,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
