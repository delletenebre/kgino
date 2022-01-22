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

      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => AppRoute.routes
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}