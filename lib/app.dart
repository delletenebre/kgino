import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'resources/krs_theme.dart';
import 'resources/krs_router.gr.dart';


class App extends StatelessWidget {
  App({ Key? key }) : super(key: key);

  final _appRouter = KrsRouter(
    //authGuard: AuthGuard(),
  );

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,

        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),

        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(localeController.locale),

        theme: KrsTheme.light,
        darkTheme: KrsTheme.dark,
        themeMode: themeController.themeMode,
      );
    });
  }
}