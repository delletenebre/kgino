import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/ockg/ockg_catalog_page.dart';
import '../pages/ockg/ockg_movie_details_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/player_page.dart';

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
            builder: (context, state) {
              final movieId = int.tryParse(state.params['id'] ?? '') ?? 0;
              return OckgMovieDetailsPage(movieId);
            },
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

          GoRoute(
            path: 'player',
            builder: (context, state) {
              
              final videoUrl = state.extra as String;
              return PlayerPage(
                videoUrl: videoUrl,
              );
            },
          ),

        ]
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