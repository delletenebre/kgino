// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../pages/home_page.dart' as _i2;
import '../pages/iptv/iptv_home_page.dart' as _i4;
import '../pages/layouts/root_layout.dart' as _i1;
import '../pages/ockg/ockg_home_page.dart' as _i6;
import '../pages/search/search_page.dart' as _i3;
import '../pages/settings_page.dart' as _i7;
import '../pages/tskg/tskg_home_page.dart' as _i5;

class KrsRouter extends _i8.RootStackRouter {
  KrsRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    RootLayout.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.RootLayout());
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    SearchRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SearchPage());
    },
    IptvHomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.IptvHomePage());
    },
    TskgHomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.TskgHomePage());
    },
    OckgHomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.OckgHomePage());
    },
    SettingsRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SettingsPage());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(RootLayout.name, path: '/', children: [
          _i8.RouteConfig(HomeRoute.name, path: '', parent: RootLayout.name),
          _i8.RouteConfig(SearchRoute.name,
              path: 'search', parent: RootLayout.name),
          _i8.RouteConfig(IptvHomeRoute.name,
              path: 'iptv', parent: RootLayout.name),
          _i8.RouteConfig(TskgHomeRoute.name,
              path: 'tskg', parent: RootLayout.name),
          _i8.RouteConfig(OckgHomeRoute.name,
              path: 'ockg', parent: RootLayout.name),
          _i8.RouteConfig(SettingsRoute.name,
              path: 'settings', parent: RootLayout.name)
        ])
      ];
}

/// generated route for
/// [_i1.RootLayout]
class RootLayout extends _i8.PageRouteInfo<void> {
  const RootLayout({List<_i8.PageRouteInfo>? children})
      : super(RootLayout.name, path: '/', initialChildren: children);

  static const String name = 'RootLayout';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.SearchPage]
class SearchRoute extends _i8.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: 'search');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i4.IptvHomePage]
class IptvHomeRoute extends _i8.PageRouteInfo<void> {
  const IptvHomeRoute() : super(IptvHomeRoute.name, path: 'iptv');

  static const String name = 'IptvHomeRoute';
}

/// generated route for
/// [_i5.TskgHomePage]
class TskgHomeRoute extends _i8.PageRouteInfo<void> {
  const TskgHomeRoute() : super(TskgHomeRoute.name, path: 'tskg');

  static const String name = 'TskgHomeRoute';
}

/// generated route for
/// [_i6.OckgHomePage]
class OckgHomeRoute extends _i8.PageRouteInfo<void> {
  const OckgHomeRoute() : super(OckgHomeRoute.name, path: 'ockg');

  static const String name = 'OckgHomeRoute';
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings');

  static const String name = 'SettingsRoute';
}
