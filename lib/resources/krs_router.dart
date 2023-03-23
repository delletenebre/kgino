import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/flmx/flmx_home_page.dart';
import '../pages/home_page.dart';
import '../pages/oc.kg/ockg_home_page.dart';
import '../ui/scaffold_with_navigation_bar.dart';


final rootNavigatorKey = 
    GlobalKey<NavigatorState>(debugLabel: 'root');
final mainNavigatorKey = 
    GlobalKey<NavigatorState>(debugLabel: 'main');

class KrsRouter {
  static final routes = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',

    // refreshListenable: GoRouterRefreshStream(
    //   GetIt.instance<AuthenticationBloc>().stream
    // ),

    // redirect: (context, state) {
    //   final authState = context.read<AuthenticationBloc>().state;

    //   if (authState.isAuthenticated) {
    //     if (state.location == '/signin') {
    //       return '/';
    //     }
    //   } else {
    //     if (state.location != '/signin') {
    //       return '/signin';
    //     }
    //   }

    //   return null;
    // },

    errorBuilder: (context, state) => const ErrorPage(),

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const ScaffoldWithNavigationBar(
            child: HomePage(),
          );
        },

        routes: [
          GoRoute(
            path: 'flmx',
            name: 'flmxHome',
            builder: (context, state) {
              return const FlmxHomePage();
            },
            routes: [
            ],
          ),

          GoRoute(
            path: 'ockg',
            name: 'ockgHome',
            builder: (context, state) {
              return const OckgHomePage();
            },
            routes: [
            ],
          ),
        ]
      ),
      // ShellRoute(
      //   navigatorKey: mainNavigatorKey,
      //   builder: (context, state, child) {
      //     return ScaffoldWithNavigationBar(
      //       child: child
      //     );
      //   },
      //   routes: [
      //     /// стартовая страница
      //     GoRoute(
      //       path: '/',
      //       builder: (context, state) {
      //         return const HomePage();
      //       },

      //       routes: [
      //         GoRoute(
      //           path: 'flmx',
      //           name: 'flmxHome',
      //           builder: (context, state) {
      //             return const FlmxHomePage();
      //           },
      //           routes: [
      //           ],
      //         ),

      //         GoRoute(
      //           path: 'ockg',
      //           name: 'ockgHome',
      //           builder: (context, state) {
      //             return const OckgHomePage();
      //           },
      //           routes: [
      //           ],
      //         ),
      //       ]
      //     ),
          
      //   ],
      // ),
    ],
  );
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

class DialogPage extends CustomTransitionPage {
  
  DialogPage({
    super.key,
    required super.child,
    super.barrierDismissible = true,
    super.fullscreenDialog = true,
    super.opaque = false,
  }) : super(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );

  

}