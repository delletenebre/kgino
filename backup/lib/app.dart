import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'resources/krs_router.dart';
import 'resources/krs_theme.dart';

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

          return Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            
            child: MaterialApp.router(
              routerConfig: KrsRouter.routes,

              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),

              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(locale),

              theme: KrsTheme.light,
              darkTheme: KrsTheme.dark,
              themeMode: themeMode,
            ),
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