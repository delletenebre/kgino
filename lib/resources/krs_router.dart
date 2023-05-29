import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../api/tskg_api_provider.dart';
import '../models/kgino_item.dart';
import '../pages/error_page.dart';
import '../pages/episodes_page.dart';
import '../pages/flmx/flmx_movies_category_page.dart';
import '../pages/flmx/flmx_details_page.dart';
import '../pages/flmx/flmx_movies_page.dart';
import '../pages/flmx/flmx_shows_category_page.dart';
import '../pages/flmx/flmx_shows_page.dart';
import '../pages/home_page.dart';
import '../pages/oc.kg/ockg_home_page.dart';
import '../pages/oc.kg/ockg_movie_details_page.dart';
import '../pages/player_page.dart';
import '../pages/tskg/tskg_details_page.dart';
import '../pages/tskg/tskg_home_page.dart';
import '../ui/scaffold_with_navigation_bar.dart';
import '../ui/try_again_message.dart';


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
          /// filmix сериалы
          GoRoute(
            path: 'flmx/shows',
            name: 'flmxShows',
            builder: (context, state) {
              return const FlmxShowsPage();
            },
            routes: [

              /// страница категории фильмов
              GoRoute(
                path: 'category',
                name: 'flmxShowsCategory',
                builder: (context, state) {
                  final id = state.queryParameters['id'] ?? '';
                  final name = state.queryParameters['name'] ?? '';
                  return FlmxShowsCategoryPage(
                    categoryId: id,
                    categoryName: name,
                  );
                },
              ),

              /// страница информации о сериале
              GoRoute(
                path: ':id',
                name: 'flmxShowDetails',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return FlmxDetailsPage(id);
                },
                routes: [

                  /// страница эпизодов сериала
                  GoRoute(
                    path: 'episodes',
                    name: 'flmxShowEpisodes',
                    builder: (context, state) {
                      final kginoItem = state.extra;
                      if (kginoItem != null) {
                        return EpisodesPage(kginoItem as KginoItem);
                      }
                      
                      return TryAgainMessage(
                        onRetry: () {
                          
                        },
                      );
                    },
                  ),

                  /// страница плеера
                  GoRoute(
                    path: 'player',
                    name: 'flmxShowPlayer',
                    builder: (context, state) {
                      final kginoItem = state.extra as KginoItem;
                      final fileId = state.queryParameters['episodeId'] ?? '';

                      return PlayerPage(
                        kginoItem: kginoItem,
                        episodeId: fileId,
                        getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                          if (initial) {

                            /// проверяем был ли эпизод в просмотренных
                            final seenEpisode = kginoItem.seenEpisodes.firstWhere((element) {
                              return element.id == currentEpisode.id;
                            }, orElse: () => currentEpisode);

                            /// восстанавливаем время просмотра, если эпизод
                            /// уже был в просмотренных
                            currentEpisode.position = seenEpisode.position;
                            
                          } else {
                            /// сбрасываем время просмотра у текущего эпизода,
                            /// чтобы при переключении не запрашивал продолжить
                            /// просмотр или нет
                            currentEpisode.position = 0;
                          }

                          int playableQuality = kginoItem.playableQuality;
                          if (!currentEpisode.playableQualities.contains(kginoItem.playableQuality)) {
                            currentEpisode.playableQualities.sort((a, b) => a.compareTo(b));
                            playableQuality = currentEpisode.playableQualities.first;
                          }

                          currentEpisode.quality = playableQuality;
                          currentEpisode.videoFileUrl = currentEpisode.videoFileUrl.replaceFirst('%s', '$playableQuality');
                          currentEpisode.videoFileUrl = currentEpisode.videoFileUrl.replaceAllMapped(RegExp(r'_(\d+?).mp4'), (match) {
                            return match.group(0)!.replaceAll('${match.group(1)}', '$playableQuality');
                          });
                          
                          return currentEpisode;
                        },
                      );
                    },
                  ),

                ],
              ),

            ],
          ),

          /// filmix фильмы
          GoRoute(
            path: 'flmx/movies',
            name: 'flmxMovies',
            builder: (context, state) {
              return const FlmxMoviesPage();
            },
            routes: [

              /// страница категории фильмов
              GoRoute(
                path: 'category',
                name: 'flmxMoviesCategory',
                builder: (context, state) {
                  final id = state.queryParameters['id'] ?? '';
                  final name = state.queryParameters['name'] ?? '';
                  return FlmxMoviesCategoryPage(
                    categoryId: id,
                    categoryName: name,
                  );
                },
              ),

              /// страница информации о фильме
              GoRoute(
                path: ':id',
                name: 'flmxMovieDetails',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return FlmxDetailsPage(id);
                },
                routes: [

                  /// страница эпизодов
                  GoRoute(
                    path: 'episodes',
                    name: 'flmxMovieEpisodes',
                    builder: (context, state) {
                      final kginoItem = state.extra;
                      if (kginoItem != null) {
                        return EpisodesPage(kginoItem as KginoItem);
                      }
                      
                      return TryAgainMessage(
                        onRetry: () {
                          
                        },
                      );
                    },
                    routes: [

                    ],
                  ),

                ],
              ),

            ],
          ),

          /// online cinema
          GoRoute(
            path: 'ockg',
            name: 'ockgHome',
            builder: (context, state) {
              return const OckgHomePage();
            },
            routes: [

              /// страница информации о фильме
              GoRoute(
                path: 'details/:id',
                name: 'ockgDetails',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return OckgMovieDetailsPage(id);
                },
                routes: [

                  /// страница плеера
                  GoRoute(
                    path: 'player',
                    name: 'ockgPlayer',
                    builder: (context, state) {
                      final kginoItem = state.extra as KginoItem;
                      final fileId = state.queryParameters['episodeId'] ?? '';

                      return PlayerPage(
                        kginoItem: kginoItem,
                        episodeId: fileId,
                        getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                          if (initial) {
                            /// проверяем был ли эпизод в просмотренных
                            final episode = kginoItem.seenEpisodes.firstWhere((element) {
                              return element.id == currentEpisode.id;
                            }, orElse: () => currentEpisode);

                            /// обновляем ссылку на видео файл
                            episode.videoFileUrl = currentEpisode.videoFileUrl;

                            return episode;

                          } else {
                            /// сбрасываем время просмотра у текущего эпизода, чтобы при переключении
                            /// не запрашивал продолжить просмотр или нет
                            currentEpisode.position = 0;
                            return currentEpisode;
                          }
                        },
                      );
                    },
                  ),
                  
                ],
              ),

            ],
          ),

          /// ts.kg
          GoRoute(
            path: 'tskg',
            name: 'tskgHome',
            builder: (context, state) {
              return const TskgHomePage();
            },
            routes: [

              /// страница информации о сериале
              GoRoute(
                path: 'show/:id',
                name: 'tskgDetails',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return TskgDetailsPage(id);
                },
                routes: [

                  /// страница плеера
                  GoRoute(
                    path: 'player',
                    name: 'tskgPlayer',
                    builder: (context, state) {
                      final kginoItem = state.extra as KginoItem;
                      final fileId = state.queryParameters['episodeId'] ?? '';

                      return PlayerPage(
                        kginoItem: kginoItem,
                        episodeId: fileId,
                        getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                          /// провайдер запросов к API
                          final api = GetIt.instance<TskgApiProvider>();
                          
                          /// получаем данные эпизода
                          final episodeDetails = await api.getEpisodeDetails(currentEpisode.id);

                          /// задаём качество видео в HD или в SD
                          String videoUrl = episodeDetails?.video.files.hd.url
                              ?? episodeDetails?.video.files.sd.url ?? '';

                          /// субтитры
                          String subtitlesUrl = episodeDetails?.video.subtitles ?? '';

                          /// обновляем ссылку на видео файл
                          currentEpisode.videoFileUrl = videoUrl;

                          /// обновляем ссылку на файл субтитров
                          currentEpisode.subtitlesFileUrl = subtitlesUrl;

                          if (initial) {

                            /// проверяем был ли эпизод в просмотренных
                            final seenEpisode = kginoItem.seenEpisodes.firstWhere((element) {
                              return element.id == currentEpisode.id;
                            }, orElse: () => currentEpisode);

                            /// восстанавливаем время просмотра, если эпизод
                            /// уже был в просмотренных
                            currentEpisode.position = seenEpisode.position;
                            
                          } else {
                            /// сбрасываем время просмотра у текущего эпизода,
                            /// чтобы при переключении не запрашивал продолжить
                            /// просмотр или нет
                            currentEpisode.position = 0;
                          }

                          return currentEpisode;
                        },
                      );
                    },
                  ),

                  /// страница эпизодов сериала
                  GoRoute(
                    path: 'episodes',
                    name: 'tskgEpisodes',
                    builder: (context, state) {
                      final kginoItem = state.extra;
                      if (kginoItem != null) {
                        return EpisodesPage(kginoItem as KginoItem);
                      }
                      
                      return TryAgainMessage(
                        onRetry: () {
                          
                        },
                      );
                    },
                    routes: [

                    ],
                  ),

                ],
              ),

            ],
          ),

          GoRoute(
            path: 'webCameraPlayer',
            name: 'wcamPlayer',
            builder: (context, state) {
              final kginoItem = state.extra as KginoItem;
              final fileId = state.queryParameters['episodeId'] ?? '';

              return PlayerPage(
                kginoItem: kginoItem,
                episodeId: fileId,
                saveProgress: false,
                getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                  return currentEpisode;
                },
              );
            },
          ),

        ]
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