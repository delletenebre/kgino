import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/media_item.dart';
import '../pages/details_page.dart';
import '../pages/home_page.dart';
import '../pages/player_page.dart';
import '../pages/playlist_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'main');

/// провайдер хранилища
final routerProvider = Provider<GoRouter>((ref) {
  /// контроллер авторизации
  // final authController = ref.watch(authProvider.notifier);

  // ///
  // final listenable = RouteRefreshListenable();

  // ref.listen(authProvider, (previous, next) {
  //   listenable.notify();
  // });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    // refreshListenable: listenable,
    // redirect: (context, state) {
    //   final location = state.uri.path.toString();

    //   if (authController.isAuthenticated) {
    //     if (location == '/signin') {
    //       return '/';
    //     }
    //   } else {
    //     if (location != '/signin') {
    //       return '/signin';
    //     }
    //   }

    //   return null;
    // },
    // errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          /// страница с подробностями
          GoRoute(
            path: 'details',
            name: 'details',
            builder: (context, state) {
              final mediaItem = state.extra as MediaItem;
              return DetailsPage(mediaItem);
            },
          ),

          /// страница плейлиста
          GoRoute(
            path: 'playlist',
            name: 'playlist',
            builder: (context, state) {
              final mediaItem = state.extra as MediaItem;
              return PlaylistPage(mediaItem);
            },
          ),

          /// страница плеера
          GoRoute(
            path: 'player',
            name: 'player',
            builder: (context, state) {
              final mediaItem = state.extra as MediaItem;
              final episodeIndex = int.tryParse(
                      state.uri.queryParameters['episodeIndex'] ?? '') ??
                  0;
              final initialPosition = int.tryParse(
                      state.uri.queryParameters['initialPosition'] ?? '') ??
                  0;

              final forcePositionUpdate = bool.tryParse(
                      state.uri.queryParameters['forcePositionUpdate'] ?? '') ??
                  false;

              return PlayerPage(
                mediaItem: mediaItem,
                episodeIndex: episodeIndex,
                // initialPosition: initialPosition,
                // forcePositionUpdate: forcePositionUpdate,
              );
            },
          ),
        ],
      ),
    ],
  );
});

class RouteRefreshListenable extends Listenable {
  VoidCallback? _listener;
  @override
  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _listener = null;
  }

  void notify() {
    _listener?.call();
  }
}
