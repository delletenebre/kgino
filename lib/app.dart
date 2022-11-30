import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiffy/jiffy.dart';

import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/tskg/tskg_favorites_cubit.dart';
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
          WidgetsBinding.instance.addPostFrameCallback((timestamp) {
            Jiffy.locale(locale);
          });

          return Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            
            child: MaterialApp.router(
              routerConfig: KrsRouter.routes,

              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(locale),

              theme: KrsTheme.light,
              darkTheme: KrsTheme.dark,
              themeMode: ThemeMode.dark//themeMode,
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
