import 'package:go_router/go_router.dart';

import '../models/ockg/ockg_movie.dart';
import '../models/tskg/tskg_show.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/ockg/ockg_catalog_page.dart';
import '../pages/ockg/ockg_movie_details_page.dart';
import '../pages/ockg/ockg_movie_files_page.dart';
import '../pages/ockg/ockg_player_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/tskg/tskg_player_page.dart';
import '../pages/tskg/tskg_show_details_page.dart';
import '../pages/tskg/tskg_show_seasons_page.dart';

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
          GoRoute(
            path: 'ockg/movie/:id',
            name: 'ockgMovieDetails',
            builder: (context, state) {
              final movieId = int.tryParse(state.params['id'] ?? '') ?? 0;
              return OckgMovieDetailsPage(movieId);
            },
            routes: [
              GoRoute(
                path: 'files',
                name: 'ockgMovieFiles',
                builder: (context, state) {
                  final movie = state.extra as OckgMovie;
                  return OckgMovieFilesPage(
                    movie: movie,
                  );
                },
              ),

              GoRoute(
                path: 'player',
                name: 'ockgMoviePlayer',
                builder: (context, state) {
                  final movie = state.extra as OckgMovie;
                  final startTime = int.tryParse(state.queryParams['startTime'] ?? '0');
                  final fileIndex = int.tryParse(state.queryParams['fileIndex'] ?? '0');

                  return OckgPlayerPage(
                    movie: movie,
                    startTime: startTime ?? 0,
                    fileIndex: fileIndex ?? 0,
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
                  final show = state.extra as TskgShow;
                  return TskgShowSeasonsPage(
                    show: show,
                  );
                },
              ),

              GoRoute(
                path: 'player',
                name: 'tskgPlayer',
                builder: (context, state) {
                  final show = state.extra as TskgShow;
                  final startTime = int.tryParse(state.queryParams['startTime'] ?? '0');
                  final episodeIndex = int.tryParse(state.queryParams['episodeIndex'] ?? '0');

                  return TskgPlayerPage(
                    show: show,
                    startTime: startTime ?? 0,
                    episodeIndex: episodeIndex ?? 0,
                  );
                },
              ),
            ]
          ),

          GoRoute(
            path: 'ockg/genre/:id',
            builder: (context, state) {
              final titleText = state.extra! as String;
              final genreId = int.tryParse(state.params['id'] ?? '') ?? 0;
              return OckgCatalogPage(
                titleText: titleText,
                genreId: genreId,
              );
            },
          ),

        ],
      ),

      
      GoRoute(
        path: '/settings',
        builder: (context, state) {
          return const SettingsPage();
        },
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