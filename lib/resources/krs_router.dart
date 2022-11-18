import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/ockg/ockg_movie.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/ockg/ockg_movie_details_page.dart';
import '../pages/settings_page.dart';

class KrsRouter {
  static final routes = GoRouter(
    initialLocation: '/',

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
              final id = state.params['id'] ?? '';
              return OckgMovieDetailsPage(id);
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
      
    ],
  );
}