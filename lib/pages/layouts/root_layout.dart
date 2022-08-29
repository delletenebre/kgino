import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/krs_navigation_destination.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_router.gr.dart';

class RootLayout extends StatefulWidget {
  const RootLayout({Key? key}) : super(key: key);

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {

  @override
  void initState() {
    context.router.addListener(() {
      setState(() {
        
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final destinations = [
      KrsNavigationRailDestination(
        icon: Icons.search_outlined,
        selectedIcon: Icons.search,
        label: locale.search,
        route: const SearchRoute(),
      ),

      KrsNavigationRailDestination(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: locale.home,
        route: const HomeRoute(),
      ),

      KrsNavigationRailDestination(
        icon: Icons.live_tv_outlined,
        selectedIcon: Icons.live_tv,
        label: locale.tv,
        route: const IptvHomeRoute(),
      ),

      KrsNavigationRailDestination(
        icon: Icons.ondemand_video_outlined,
        selectedIcon: Icons.ondemand_video,
        label: locale.tvshows,
        route: const TskgHomeRoute(),
      ),

      KrsNavigationRailDestination(
        icon: Icons.movie_outlined,
        selectedIcon: Icons.movie,
        label: locale.movies,
        route: const OckgHomeRoute(),
      ),
    ];

    final index = destinations.indexWhere((destination) {
      return AutoRouter.of(context).isRouteActive(destination.route.routeName);
    });
    
    final selectedDestinationIndex = (index > -1) ? index : 0;

    return Scaffold(
      // body: Row(
      //   children: [
      //     NavigationRail(
      //       extended: false,
      //       selectedIndex: selectedDestinationIndex,
      //       labelType: NavigationRailLabelType.all,
      //       selectedLabelTextStyle: TextStyle(
      //         color: theme.colorScheme.secondary
      //       ),
      //       onDestinationSelected: (index) {
      //         AutoRouter.of(context).navigate(destinations[index].route);
      //       },
      //       destinations: destinations,
      //     ),

      //     const Expanded(
      //       child: AutoRouter(),
      //     )
      //   ],
      // ),

      body: Stack(
        children: [
          
          const AutoRouter(),

          SizedBox(
            width: 80.0,
            child: NavigationRail(
              backgroundColor: theme.colorScheme.surface,
              extended: false,
              selectedIndex: selectedDestinationIndex,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (index) {
                AutoRouter.of(context).navigate(destinations[index].route);
              },
              destinations: destinations,
            ),
          ),
        ],
      ),
    );
  }
}