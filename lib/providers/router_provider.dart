import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../models/rezka/rezka_item.dart';
import '../models/tskg/tskg_item.dart';
import '../pages/details_page/details_page.dart';
import '../pages/home_page.dart';
import '../pages/main_layout.dart';
import '../pages/player_page/player_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final mainNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'main');
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');

/// провайдер маршрутов
final routerProvider = Provider<GoRouter>((ref) {
  /// контроллер авторизации
  //final authState = ref.watch(authProvider);

  ///
  final listenable = RouteRefreshListenable();

  // ref.listen(authProvider, (previous, next) {
  //   if (previous?.hasError != next.hasError) {
  //     listenable.notify();
  //   }
  // });

  // final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) async {
      // final authState = ref.read(authProvider);
      // if (authState.isLoading) {
      //   return null;
      // }

      // final authController = ref.read(authProvider.notifier);

      // final location = state.uri.path.toString();

      // if (authController.isAuthenticated) {
      //   /// ^ если пользователь авторизован
      //   if (location.startsWith('/signin')) {
      //     return '/';
      //   }
      // } else {
      //   /// ^ если пользователь НЕ авторизован

      //   if (!location.startsWith('/signin') &&
      //       !location.startsWith('/signup')) {
      //     return '/signin';
      //   }
      // }

      return null;
    },
    // errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      ShellRoute(
        navigatorKey: mainNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          /// стартовая страница
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),

          /// страница с подробностями
          GoRoute(
            path: '/details',
            name: 'details',
            builder: (context, state) {
              final mediaItem = extraToMediaItem(state.extra);

              if (mediaItem != null) {
                return DetailsPage(mediaItem);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          /// страница плеера
          GoRoute(
            path: '/player',
            name: 'player',
            builder: (context, state) {
              final mediaItem = extraToMediaItem(state.extra);

              final episodeIndex = int.tryParse(
                      state.uri.queryParameters['episodeIndex'] ?? '') ??
                  0;
              final initialPosition = int.tryParse(
                      state.uri.queryParameters['initialPosition'] ?? '') ??
                  0;

              final forcePositionUpdate = bool.tryParse(
                      state.uri.queryParameters['forcePositionUpdate'] ?? '') ??
                  false;

              if (mediaItem != null) {
                return PlayerPage(
                  mediaItem: mediaItem,
                  episodeIndex: episodeIndex,
                  initialPosition: initialPosition,
                  forcePositionUpdate: forcePositionUpdate,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    ],
  );
});

MediaItem? extraToMediaItem(Object? extra) {
  MediaItem? mediaItem;
  if (extra is Map) {
    /// ^ в web, при [Navigator.pop()] extra не сохраняется как [MediaItem]
    /// поэтому необходима проверка на json

    final extraJson = (extra as Map<String, dynamic>);

    if (extraJson.containsKey('onlineService')) {
      switch (extraJson['onlineService']) {
        case 'rezka':
          mediaItem = RezkaItem.fromJson(extraJson);
          break;
        case 'tskg':
          mediaItem = TskgItem.fromJson(extraJson);
          break;
        case 'filmix':
          mediaItem = FilmixItem.fromJson(extraJson);
          break;
      }
    }
  } else if (extra is MediaItem) {
    mediaItem = extra;
  }

  return mediaItem;
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

class RouteRefreshListenable extends Listenable {
  VoidCallback? _listener;
  @override
  void addListener(listener) {
    _listener = listener;
  }

  @override
  void removeListener(listener) {
    _listener = null;
  }

  void notify() {
    _listener?.call();
  }
}
