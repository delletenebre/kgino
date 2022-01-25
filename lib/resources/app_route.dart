import 'package:flutter/material.dart';
import 'package:kgino/pages/home_page.dart';
import 'package:kgino/pages/test_page.dart';
import 'package:kgino/pages/show_page.dart';
import 'package:kgino/pages/unknown_route_page.dart';
import 'package:routemaster/routemaster.dart';

class AppRoute {

  static const initial = '/';

  static const unknown = '/404';

  /// карта маршрутов
  static final routes = RouteMap(
    onUnknownRoute: (route) => const Redirect(AppRoute.unknown),
    routes: {
      AppRoute.unknown: (route) => const MaterialPage(
        child: UnknownRoutePage(),
      ),

      AppRoute.initial: (route) => const MaterialPage(
        child: HomePage(),
      ),

      /// страница сериала
      '/tskg/show/:id': (route) => MaterialPage(
        child: ShowPage(
          id: route.pathParameters['id'] ?? '',
        ),
        
      ),

      '/test/:id': (route) => MaterialPage(
        child: TestPage(
          id: route.pathParameters['id'] ?? '',
        ),
      ),
    },
  );

}
