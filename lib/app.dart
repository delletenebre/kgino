import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'controllers/controllers.dart';
import 'resources/resources.dart';


class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      
      child: GetMaterialApp(
        title: 'KGino',

        debugShowCheckedModeBanner: false,
        
        locale: Locale(AppLocale.defaultLocale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        // navigatorObservers: [
        //   FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        // ],

        /// исправляем поведение прокручивания списков для desktop-платформ
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          /// позволяем проматывать списки всеми доступными способами
          dragDevices: PointerDeviceKind.values.toSet(),
          /// скрываем системные скроллбары
          scrollbars: false,
        ),
        
        defaultTransition: Transition.native,
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,

        initialRoute: AppRoutes.routes.first.name,
        unknownRoute: AppRoutes.unknownRoute,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
