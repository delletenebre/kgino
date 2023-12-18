import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/home_page.dart';

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
          // /// фильмы Filmix
          // GoRoute(
          //   path: 'filmix/movies',
          //   name: 'filmixMovies',
          //   builder: (context, state) {
          //     return const FilmixMoviesPage();
          //   },
          // ),
          //
          // /// сериалы Filmix
          // GoRoute(
          //   path: 'filmix/shows',
          //   name: 'filmixShows',
          //   builder: (context, state) {
          //     return const FilmixShowsPage();
          //   },
          // ),
          //
          // /// сериалы TS.KG
          // GoRoute(
          //   path: 'tskg/shows',
          //   name: 'tskgShows',
          //   builder: (context, state) {
          //     return const TskgShowsPage();
          //   },
          // ),
          //
          // /// фильмы Rezka
          // GoRoute(
          //   path: 'rezka/movies',
          //   name: 'rezkaMovies',
          //   builder: (context, state) {
          //     return const RezkaMoviesPage();
          //   },
          // ),
          //
          // /// сериалы Rezka
          // GoRoute(
          //   path: 'rezka/shows',
          //   name: 'rezkaShows',
          //   builder: (context, state) {
          //     return const RezkaShowsPage();
          //   },
          // ),
          //
          // /// страница с подробностями
          // GoRoute(
          //   path: 'details',
          //   name: 'details',
          //   builder: (context, state) {
          //     final mediaItem = state.extra as MediaItem;
          //     return DetailsPage(mediaItem);
          //   },
          // ),
          //
          // /// страница плейлиста
          // GoRoute(
          //   path: 'playlist',
          //   name: 'playlist',
          //   builder: (context, state) {
          //     final mediaItem = state.extra as MediaItem;
          //     return PlaylistPage(mediaItem);
          //   },
          // ),
          //
          // /// страница плеера
          // GoRoute(
          //   path: 'player',
          //   name: 'player',
          //   builder: (context, state) {
          //     final mediaItem = state.extra as MediaItem;
          //     final episodeIndex = int.tryParse(
          //             state.uri.queryParameters['episodeIndex'] ?? '') ??
          //         0;
          //     final initialPosition = int.tryParse(
          //             state.uri.queryParameters['initialPosition'] ?? '') ??
          //         0;
          //
          //     final forcePositionUpdate = bool.tryParse(
          //             state.uri.queryParameters['forcePositionUpdate'] ?? '') ??
          //         false;
          //
          //     return PlayerPage(
          //       mediaItem: mediaItem,
          //       episodeIndex: episodeIndex,
          //       initialPosition: initialPosition,
          //       forcePositionUpdate: forcePositionUpdate,
          //     );
          //   },
          // ),
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
