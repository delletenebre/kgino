import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kgino/controllers/ockg/ockg_catalog_controller.dart';

import '../api/tskg_api_provider.dart';
import '../controllers/seen_items_controller.dart';
import '../models/episode_item.dart';
import '../models/movie_item.dart';
import '../pages/error_page.dart';
import '../pages/flmx/flmx_details_page.dart';
import '../pages/home_page.dart';
import '../pages/ockg/ockg_catalog_page.dart';
import '../pages/ockg/ockg_movie_details_page.dart';
import '../pages/ockg/ockg_movie_files_page.dart';
import '../pages/player_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/tskg/tskg_show_details_page.dart';
import '../pages/tskg/tskg_show_seasons_page.dart';
import '../pages/wcam/wcam_player_page.dart';

class KrsRouter {
  static final routes = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    errorBuilder: (context, state) => const ErrorPage(),

    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          /// страница настроек
          GoRoute(
            path: 'settings',
            builder: (context, state) {
              return const SettingsPage();
            },
          ),

          GoRoute(
            path: 'ockg/movie/:id',
            name: 'ockgMovieDetails',
            builder: (context, state) {
              final movieId = state.params['id'] ?? '';
              return OckgMovieDetailsPage(movieId);
            },
            routes: [
              GoRoute(
                path: 'files',
                name: 'ockgMovieFiles',
                builder: (context, state) {
                  final movie = state.extra as MovieItem;
                  return OckgMovieFilesPage(
                    movie: movie,
                  );
                },
              ),

              GoRoute(
                path: 'player',
                name: 'ockgMoviePlayer',
                builder: (context, state) {
                  final movie = state.extra as MovieItem;
                  final fileId = state.queryParams['episodeId'] ?? '';

                  return PlayerPage(
                    movieItem: movie,
                    episodeId: fileId,
                    getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                      if (initial) {
                        /// находим сохранённый эпизод, если он есть
                        
                        /// контроллер просмотренных эпизодов
                        final seenItemsController = GetIt.instance<SeenItemsController>();

                        /// проверяем был ли эпизод в просмотренных
                        final episode = seenItemsController.findEpisode(
                          storageKey: seenShowStorageKey,
                          episodeId: currentEpisode.id,
                        ) ?? currentEpisode;

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
            ]
          ),

          GoRoute(
            path: 'tskg/show/:id',
            name: 'tskgShowDetails',
            builder: (context, state) {
              final showId = state.params['id'] ?? '';
              return TskgShowDetailsPage(showId);
            },
            routes: [
              GoRoute(
                path: 'seasons',
                name: 'tskgShowSeasons',
                builder: (context, state) {
                  final show = state.extra as TskgMovieItem;
                  return TskgShowSeasonsPage(
                    show: show,
                  );
                },
              ),

              GoRoute(
                path: 'player',
                name: 'tskgPlayer',
                builder: (context, state) {
                  final show = state.extra as TskgMovieItem;
                  final episodeId = state.queryParams['episodeId'] ?? '';

                  return PlayerPage(
                    movieItem: show,
                    episodeId: episodeId,
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
                        /// контроллер просмотренных эпизодов
                        final seenItemsController = GetIt.instance<SeenItemsController>();

                        /// проверяем был ли эпизод в просмотренных
                        final seenEpisode = seenItemsController.findEpisode(
                          storageKey: seenShowStorageKey,
                          episodeId: currentEpisode.id,
                        );

                        /// восстанавливаем время просмотра, если эпизод уже был в просмотренных
                        currentEpisode.position = seenEpisode?.position ?? 0;
                        
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
            ]
          ),

          GoRoute(
            path: 'ockg/genre/:id',
            name: 'ockgCatalogGenre',
            builder: (context, state) {
              final item = state.extra! as MovieItem;
              return OckgCatalogPage(
                type: OckgCatalogType.genre,
                item: item,
              );
            },
          ),

          GoRoute(
            path: 'ockg/selection/:id',
            name: 'ockgCatalogSelection',
            builder: (context, state) {
              final item = state.extra! as MovieItem;
              return OckgCatalogPage(
                type: OckgCatalogType.selection,
                item: item,
              );
            },
          ),

          

          GoRoute(
            path: 'wcam',
            name: 'wcamPlayer',
            builder: (context, state) {
              final item = state.extra as EpisodeItem;

              return WcamPlayerPage(
                item: item,
              );
            },
          ),


          /// filmix
          GoRoute(
            path: 'flmx/:id',
            name: 'flmxDetails',
            builder: (context, state) {
              final id = state.params['id'] ?? '';
              return FlmxDetailsPage(id);
            },
            routes: [
              // GoRoute(
              //   path: 'files',
              //   name: 'ockgMovieFiles',
              //   builder: (context, state) {
              //     final movie = state.extra as MovieItem;
              //     return OckgMovieFilesPage(
              //       movie: movie,
              //     );
              //   },
              // ),

              GoRoute(
                path: 'player',
                name: 'flmxPlayer',
                builder: (context, state) {
                  final movie = state.extra as MovieItem;
                  final fileId = state.queryParams['episodeId'] ?? '';

                  return PlayerPage(
                    movieItem: movie,
                    episodeId: fileId,
                    getPlayableItem: (initial, currentEpisode, seenShowStorageKey) async {
                      if (initial) {
                        /// находим сохранённый эпизод, если он есть
                        
                        /// контроллер просмотренных эпизодов
                        final seenItemsController = GetIt.instance<SeenItemsController>();

                        /// проверяем был ли эпизод в просмотренных
                        final episode = seenItemsController.findEpisode(
                          storageKey: seenShowStorageKey,
                          episodeId: currentEpisode.id,
                        ) ?? currentEpisode;

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
            ]
          ),


        ],
      ),

      
      

      GoRoute(
        path: '/search',
        builder: (context, state) {
          return const SearchPage();
        },
      ),
      
    ],
  );
}