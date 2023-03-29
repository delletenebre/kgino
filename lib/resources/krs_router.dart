import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../api/tskg_api_provider.dart';
import '../models/kgino_item.dart';
import '../pages/error_page.dart';
import '../pages/episodes_page.dart';
import '../pages/flmx/flmx_details_page.dart';
import '../pages/flmx/flmx_movies_page.dart';
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

              /// страница информации о сериале
              GoRoute(
                path: ':id',
                name: 'flmxShowDetails',
                builder: (context, state) {
                  final id = state.params['id'] ?? '';
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
                    routes: [

                    ],
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

              /// страница информации о фильме
              GoRoute(
                path: ':id',
                name: 'flmxMovieDetails',
                builder: (context, state) {
                  final id = state.params['id'] ?? '';
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
                  final id = state.params['id'] ?? '';
                  return OckgMovieDetailsPage(id);
                },
                routes: [

                  /// страница плеера
                  GoRoute(
                    path: 'player',
                    name: 'ockgPlayer',
                    builder: (context, state) {
                      final kginoItem = state.extra as KginoItem;
                      final fileId = state.queryParams['episodeId'] ?? '';

                      return PlayerPage(
                        kginoItem: kginoItem,
                        episodeId: fileId,
                        getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                          if (initial) {
                            /// находим сохранённый эпизод, если он есть
                            
                            /// контроллер просмотренных эпизодов
                            // final seenItemsController = GetIt.instance<SeenItemsController>();

                            /// проверяем был ли эпизод в просмотренных
                            // final episode = seenItemsController.findEpisode(
                            //   storageKey: seenShowStorageKey,
                            //   episodeId: currentEpisode.id,
                            // ) ?? currentEpisode;
                            final episode = currentEpisode;

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
                  final id = state.params['id'] ?? '';
                  return TskgDetailsPage(id);
                },
                routes: [

                  /// страница плеера
                  GoRoute(
                    path: 'player',
                    name: 'tskgPlayer',
                    builder: (context, state) {
                      final kginoItem = state.extra as KginoItem;
                      final fileId = state.queryParams['episodeId'] ?? '';

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
                            // /// контроллер просмотренных эпизодов
                            // final seenItemsController = GetIt.instance<SeenItemsController>();

                            // /// проверяем был ли эпизод в просмотренных
                            // final seenEpisode = seenItemsController.findEpisode(
                            //   storageKey: seenShowStorageKey,
                            //   episodeId: currentEpisode.id,
                            // );

                            // /// восстанавливаем время просмотра, если эпизод уже был в просмотренных
                            // currentEpisode.position = seenEpisode?.position ?? 0;
                            currentEpisode.position = 0;
                            
                          } else {
                            /// сбрасываем время просмотра у текущего эпизода, чтобы при переключении
                            /// не запрашивал продолжить просмотр или нет
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