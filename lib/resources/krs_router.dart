import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/home_page.dart';
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

    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: mainNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavigationBar(
            child: child
          );
        },
        routes: <RouteBase>[
          /// стартовая страница
          GoRoute(
            path: '/',
            builder: (context, state) {
              // final authState = context.read<AuthenticationBloc>().state;

              // /// страница сводной информации для агента
              // if (authState.isAgent) {
              //   return const AgentDashboardPage();
              // }

              return const HomePage();
            },
          ),
          
        ],
      ),
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