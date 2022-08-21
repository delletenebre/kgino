
import 'package:auto_route/annotations.dart';

import '../pages/home_page.dart';
import '../pages/iptv/iptv_home_page.dart';
import '../pages/layouts/root_layout.dart';
import '../pages/ockg/ockg_home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/tskg/tskg_home_page.dart';
import 'auth_guard.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: RootLayout,
      initial: true,
      // guards: [
      //   AuthGuard,
      // ],
      children: [
        /// домашняя страница
        AutoRoute(
          path: '',
          page: HomePage,
        ),

        /// страница поиска
        AutoRoute(
          path: 'search',
          page: SearchPage,
        ),

        /// домашняя страница iptv
        AutoRoute(
          path: 'iptv',
          page: IptvHomePage,
        ),

        /// домашняя страница ts.kg
        AutoRoute(
          path: 'tskg',
          page: TskgHomePage,
        ),

        /// домашняя страница oc.kg
        AutoRoute(
          path: 'ockg',
          page: OckgHomePage,
        ),

        /// страница настроек
        AutoRoute(
          path: 'settings',
          page: SettingsPage,
        ),

      ],
    ),

    

  ],
)

class $KrsRouter {}