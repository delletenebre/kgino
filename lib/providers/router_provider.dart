import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/media_item.dart';
import '../pages/details_page.dart';
import '../pages/error_page.dart';
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
    errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },

        routes: [
          GoRoute(
            path: 'details',
            name: 'details',
            builder: (context, state) {
              final mediaItem = state.extra as MediaItem;
              return DetailsPage(mediaItem);
            },
          ),
          GoRoute(
            path: 'playlist',
            name: 'playlist',
            builder: (context, state) {
              final mediaItem = state.extra as MediaItem;
              return PlaylistPage(mediaItem);
            },
          ),
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

        // routes: [
        //   /// filmix сериалы
        //   GoRoute(
        //     path: 'flmx/shows',
        //     name: 'flmxShows',
        //     builder: (context, state) {
        //       return const FlmxShowsPage();
        //     },
        //     routes: [
        //       /// страница категории фильмов
        //       GoRoute(
        //         path: 'category',
        //         name: 'flmxShowsCategory',
        //         builder: (context, state) {
        //           final id = state.uri.queryParameters['id'] ?? '';
        //           final name = state.uri.queryParameters['name'] ?? '';
        //           return FlmxShowsCategoryPage(
        //             categoryId: id,
        //             categoryName: name,
        //           );
        //         },
        //       ),

        //       /// страница информации о сериале
        //       GoRoute(
        //         path: ':id',
        //         name: 'flmxShowDetails',
        //         builder: (context, state) {
        //           final id = state.pathParameters['id'] ?? '';
        //           return FlmxDetailsPage(id);
        //         },
        //         routes: [
        //           /// страница эпизодов сериала
        //           GoRoute(
        //             path: 'episodes',
        //             name: 'flmxShowEpisodes',
        //             builder: (context, state) {
        //               final kginoItem = state.extra;
        //               if (kginoItem != null) {
        //                 return EpisodesPage(kginoItem as KginoItem);
        //               }

        //               return TryAgainMessage(
        //                 onRetry: () {},
        //               );
        //             },
        //           ),

        //           /// страница плеера
        //           GoRoute(
        //             path: 'player',
        //             name: 'flmxShowPlayer',
        //             builder: (context, state) {
        //               final kginoItem = state.extra as KginoItem;
        //               final fileId =
        //                   state.uri.queryParameters['episodeId'] ?? '';

        //               return PlayerPage(
        //                 kginoItem: kginoItem,
        //                 episodeId: fileId,
        //                 getPlayableItem: (initial, currentEpisode,
        //                     seenShowStorageKey) async {
        //                   if (initial) {
        //                     /// проверяем был ли эпизод в просмотренных
        //                     final seenEpisode =
        //                         kginoItem.seenEpisodes.firstWhere((element) {
        //                       return element.id == currentEpisode.id;
        //                     }, orElse: () => currentEpisode);

        //                     /// восстанавливаем время просмотра, если эпизод
        //                     /// уже был в просмотренных
        //                     currentEpisode.position = seenEpisode.position;
        //                   } else {
        //                     /// сбрасываем время просмотра у текущего эпизода,
        //                     /// чтобы при переключении не запрашивал продолжить
        //                     /// просмотр или нет
        //                     currentEpisode.position = 0;
        //                   }

        //                   int playableQuality = kginoItem.playableQuality;
        //                   if (!currentEpisode.playableQualities
        //                       .contains(kginoItem.playableQuality)) {
        //                     currentEpisode.playableQualities
        //                         .sort((a, b) => a.compareTo(b));
        //                     playableQuality =
        //                         currentEpisode.playableQualities.first;
        //                   }

        //                   currentEpisode.quality = playableQuality;
        //                   currentEpisode.videoFileUrl = currentEpisode
        //                       .videoFileUrl
        //                       .replaceFirst('%s', '$playableQuality');
        //                   currentEpisode.videoFileUrl = currentEpisode
        //                       .videoFileUrl
        //                       .replaceAllMapped(RegExp(r'_(\d+?).mp4'),
        //                           (match) {
        //                     return match.group(0)!.replaceAll(
        //                         '${match.group(1)}', '$playableQuality');
        //                   });

        //                   return currentEpisode;
        //                 },
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),

        //   /// filmix фильмы
        //   GoRoute(
        //     path: 'flmx/movies',
        //     name: 'flmxMovies',
        //     builder: (context, state) {
        //       return const FlmxMoviesPage();
        //     },
        //     routes: [
        //       /// страница категории фильмов
        //       GoRoute(
        //         path: 'category',
        //         name: 'flmxMoviesCategory',
        //         builder: (context, state) {
        //           final id = state.uri.queryParameters['id'] ?? '';
        //           final name = state.uri.queryParameters['name'] ?? '';
        //           return FlmxMoviesCategoryPage(
        //             categoryId: id,
        //             categoryName: name,
        //           );
        //         },
        //       ),

        //       /// страница информации о фильме
        //       GoRoute(
        //         path: ':id',
        //         name: 'flmxMovieDetails',
        //         builder: (context, state) {
        //           final id = state.pathParameters['id'] ?? '';
        //           return FlmxDetailsPage(id);
        //         },
        //         routes: [
        //           /// страница эпизодов
        //           GoRoute(
        //             path: 'episodes',
        //             name: 'flmxMovieEpisodes',
        //             builder: (context, state) {
        //               final kginoItem = state.extra;
        //               if (kginoItem != null) {
        //                 return EpisodesPage(kginoItem as KginoItem);
        //               }

        //               return TryAgainMessage(
        //                 onRetry: () {},
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),

        //   /// online cinema
        //   GoRoute(
        //     path: 'ockg',
        //     name: 'ockgHome',
        //     builder: (context, state) {
        //       return const OckgHomePage();
        //     },
        //     routes: [
        //       /// страница информации о фильме
        //       GoRoute(
        //         path: 'details/:id',
        //         name: 'ockgDetails',
        //         builder: (context, state) {
        //           final id = state.pathParameters['id'] ?? '';
        //           return OckgMovieDetailsPage(id);
        //         },
        //         routes: [
        //           /// страница плеера
        //           GoRoute(
        //             path: 'player',
        //             name: 'ockgPlayer',
        //             builder: (context, state) {
        //               final kginoItem = state.extra as KginoItem;
        //               final fileId =
        //                   state.uri.queryParameters['episodeId'] ?? '';

        //               return PlayerPage(
        //                 kginoItem: kginoItem,
        //                 episodeId: fileId,
        //                 getPlayableItem: (initial, currentEpisode,
        //                     seenShowStorageKey) async {
        //                   if (initial) {
        //                     /// проверяем был ли эпизод в просмотренных
        //                     final episode =
        //                         kginoItem.seenEpisodes.firstWhere((element) {
        //                       return element.id == currentEpisode.id;
        //                     }, orElse: () => currentEpisode);

        //                     /// обновляем ссылку на видео файл
        //                     episode.videoFileUrl = currentEpisode.videoFileUrl;

        //                     return episode;
        //                   } else {
        //                     /// сбрасываем время просмотра у текущего эпизода, чтобы при переключении
        //                     /// не запрашивал продолжить просмотр или нет
        //                     currentEpisode.position = 0;
        //                     return currentEpisode;
        //                   }
        //                 },
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),

        //   /// ts.kg
        //   GoRoute(
        //     path: 'tskg',
        //     name: 'tskgHome',
        //     builder: (context, state) {
        //       return const TskgHomePage();
        //     },
        //     routes: [
        //       /// страница информации о сериале
        //       GoRoute(
        //         path: 'show/:id',
        //         name: 'tskgDetails',
        //         builder: (context, state) {
        //           final id = state.pathParameters['id'] ?? '';
        //           return TskgDetailsPage(id);
        //         },
        //         routes: [
        //           /// страница плеера
        //           GoRoute(
        //             path: 'player',
        //             name: 'tskgPlayer',
        //             builder: (context, state) {
        //               final kginoItem = state.extra as KginoItem;
        //               final fileId =
        //                   state.uri.queryParameters['episodeId'] ?? '';

        //               return PlayerPage(
        //                 kginoItem: kginoItem,
        //                 episodeId: fileId,
        //                 getPlayableItem: (initial, currentEpisode,
        //                     seenShowStorageKey) async {
        //                   /// провайдер запросов к API
        //                   final api = ref.read(tskgApiProvider);

        //                   /// получаем данные эпизода
        //                   final episodeDetails =
        //                       await api.getEpisodeDetails(currentEpisode.id);

        //                   /// задаём качество видео в HD или в SD
        //                   String videoUrl = episodeDetails?.video.url ?? '';

        //                   /// субтитры
        //                   String subtitlesUrl =
        //                       episodeDetails?.video.subtitles ?? '';

        //                   /// обновляем ссылку на видео файл
        //                   currentEpisode.videoFileUrl = videoUrl;

        //                   /// обновляем ссылку на файл субтитров
        //                   currentEpisode.subtitlesFileUrl = subtitlesUrl;

        //                   if (initial) {
        //                     /// проверяем был ли эпизод в просмотренных
        //                     final seenEpisode =
        //                         kginoItem.seenEpisodes.firstWhere((element) {
        //                       return element.id == currentEpisode.id;
        //                     }, orElse: () => currentEpisode);

        //                     /// восстанавливаем время просмотра, если эпизод
        //                     /// уже был в просмотренных
        //                     currentEpisode.position = seenEpisode.position;
        //                   } else {
        //                     /// сбрасываем время просмотра у текущего эпизода,
        //                     /// чтобы при переключении не запрашивал продолжить
        //                     /// просмотр или нет
        //                     currentEpisode.position = 0;
        //                   }

        //                   return currentEpisode;
        //                 },
        //               );
        //             },
        //           ),

        //           /// страница эпизодов сериала
        //           GoRoute(
        //             path: 'episodes',
        //             name: 'tskgEpisodes',
        //             builder: (context, state) {
        //               final kginoItem = state.extra;
        //               if (kginoItem != null) {
        //                 return EpisodesPage(kginoItem as KginoItem);
        //               }

        //               return TryAgainMessage(
        //                 onRetry: () {},
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),

        //   GoRoute(
        //     path: 'webCameraPlayer',
        //     name: 'wcamPlayer',
        //     builder: (context, state) {
        //       final kginoItem = state.extra as KginoItem;
        //       final fileId = state.uri.queryParameters['episodeId'] ?? '';

        //       return PlayerPage(
        //         kginoItem: kginoItem,
        //         episodeId: fileId,
        //         saveProgress: false,
        //         getPlayableItem:
        //             (initial, currentEpisode, seenShowStorageKey) async {
        //           return currentEpisode;
        //         },
        //       );
        //     },
        //   ),

        //   /// hdrezka фильмы
        //   GoRoute(
        //     path: 'hdrz/movies',
        //     name: 'hdrzMovies',
        //     builder: (context, state) {
        //       return const HdrzMoviesPage();
        //     },
        //     routes: [
        //       // /// страница категории фильмов
        //       // GoRoute(
        //       //   path: 'category',
        //       //   name: 'flmxMoviesCategory',
        //       //   builder: (context, state) {
        //       //     final id = state.queryParameters['id'] ?? '';
        //       //     final name = state.queryParameters['name'] ?? '';
        //       //     return FlmxMoviesCategoryPage(
        //       //       categoryId: id,
        //       //       categoryName: name,
        //       //     );
        //       //   },
        //       // ),

        //       /// страница информации о фильме
        //       GoRoute(
        //         path: ':id',
        //         name: 'hdrzMovieDetails',
        //         builder: (context, state) {
        //           final id = state.pathParameters['id'] ?? '';
        //           return HdrzDetailsPage(id);
        //         },
        //         routes: [
        //           // /// страница эпизодов
        //           // GoRoute(
        //           //   path: 'episodes',
        //           //   name: 'flmxMovieEpisodes',
        //           //   builder: (context, state) {
        //           //     final kginoItem = state.extra;
        //           //     if (kginoItem != null) {
        //           //       return EpisodesPage(kginoItem as KginoItem);
        //           //     }

        //           //     return TryAgainMessage(
        //           //       onRetry: () {

        //           //       },
        //           //     );
        //           //   },
        //           // ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ],
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
