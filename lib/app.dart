import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kgino/resources/app_route.dart';
import 'package:kgino/resources/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.dark,

      /// исправляем поведение прокручивания списков для desktop-платформ
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        /// позволяем проматывать списки всеми доступными способами
        dragDevices: PointerDeviceKind.values.toSet(),
        
        /// скрываем системные скроллбары
        scrollbars: false,
      ),

      routeInformationParser: const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return AppRoute.routes;
        }
      ),
    );
  }
}
