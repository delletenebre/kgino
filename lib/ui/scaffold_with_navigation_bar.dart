import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../resources/krs_locale.dart';

class ScaffoldWithNavigationBar extends StatefulWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScaffoldWithNavigationBar> createState() => _ScaffoldWithNavigationBarState();

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location == '/') {
      return 0;
    }
    if (location.startsWith('/settings')) {
      return 1;
    }
    if (location.startsWith('/c')) {
      return 2;
    }
    return 0;
  }
}

class _ScaffoldWithNavigationBarState extends State<ScaffoldWithNavigationBar> {
  bool _extended = true;

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    final destinations = [
      KrsNavigationRailDestination(
        icon: const Icon(Icons.movie_outlined),
        selectedIcon: const Icon(Icons.movie),
        label: Text(locale.movies),
        routeName: '/',
      ),
      KrsNavigationRailDestination(
        icon: const Icon(Icons.tv),
        selectedIcon: const Icon(Icons.tv),
        label: Text(locale.tvshows),
        routeName: '/tskg',
      ),
      KrsNavigationRailDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        label: Text(locale.settings),
        routeName: '/settings',
      ),
    ];

    return Scaffold(
      body: Row(
        children: [

          Column(
            children: [

              Expanded(
                child: Focus(
                  skipTraversal: true,
                  onFocusChange: (hasFocus) {
                    setState(() {
                      _extended = hasFocus;
                    });
                  },
                  child: NavigationRail(
                    selectedIndex: ScaffoldWithNavigationBar._calculateSelectedIndex(context),
                    extended: _extended,
                    
                    onDestinationSelected: (index) {
                      /// переходим на страницу, выбранную пользователем
                      GoRouter.of(context).go(destinations[index].routeName);
                    },
                    destinations: destinations,
                  ),
                ),
              ),
            ],
          ),

          const VerticalDivider(thickness: 1, width: 1),
          
          /// основной контент
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class KrsNavigationRailDestination extends NavigationRailDestination {
  
  KrsNavigationRailDestination({
    required super.icon,
    required super.label,
    super.selectedIcon,
    super.padding,
    this.routeName = '',
  });

  final String routeName;

}