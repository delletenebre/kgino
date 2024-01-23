import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../models/rezka/rezka_item.dart';
import '../models/tskg/tskg_item.dart';
import '../pages/details_page.dart';
import '../pages/filmix/filmix_movies_page.dart';
import '../pages/filmix/filmix_shows_page.dart';
import '../pages/home_page.dart';
import '../pages/player_page.dart';
import '../pages/playlist_page.dart';
import '../pages/rezka/rezka_movies_page.dart';
import '../pages/rezka/rezka_shows_page.dart';
import '../pages/tskg/tskg_shows_page.dart';

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
          /// страница с сериалами HDrezka
          GoRoute(
            path: 'shows/rezka',
            name: 'rezkaShows',
            builder: (context, state) {
              return const RezkaShowsPage();
            },
          ),

          /// страница с фильмами HDrezka
          GoRoute(
            path: 'movies/rezka',
            name: 'rezkaMovies',
            builder: (context, state) {
              return const RezkaMoviesPage();
            },
          ),

          /// страница с сериалами Filmix
          GoRoute(
            path: 'shows/filmix',
            name: 'filmixShows',
            builder: (context, state) {
              return const FilmixShowsPage();
            },
          ),

          /// страница с фильмами Filmix
          GoRoute(
            path: 'movies/filmix',
            name: 'filmixMovies',
            builder: (context, state) {
              return const FilmixMoviesPage();
            },
          ),

          /// страница с сериалами TS.KG
          GoRoute(
            path: 'shows/tskg',
            name: 'tskgShows',
            builder: (context, state) {
              return const TskgShowsPage();
            },
          ),

          /// страница с подробностями
          GoRoute(
            path: 'details',
            name: 'details',
            builder: (context, state) {
              MediaItem? mediaItem;
              if (state.extra is Map) {
                /// ^ в web, при [Navigator.pop()] extra не сохраняется как [MediaItem]
                /// поэтому необходима проверка на json

                final extra = (state.extra as Map<String, dynamic>);

                print(
                    'zzzzzzzzz extra ${extra.containsKey('onlineService')} ${extra['onlineService']}');
                print(extra);
                if (extra.containsKey('onlineService')) {
                  print(extra['onlineService']);
                  switch (extra['onlineService']) {
                    case 'rezka':
                      mediaItem = RezkaItem.fromJson(extra);
                      break;
                    case 'tskg':
                      mediaItem = TskgItem.fromJson(extra);
                      break;
                    case 'filmix':
                      mediaItem = FilmixItem.fromJson(extra);
                      print('zzzzzzzzz extra1');
                      break;
                  }
                }
              } else if (state.extra is MediaItem) {
                mediaItem = state.extra as MediaItem;
              }

              if (mediaItem != null) {
                return DetailsPage(mediaItem);
              } else {
                return const HomePage();
              }
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
                initialPosition: initialPosition,
                forcePositionUpdate: forcePositionUpdate,
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
