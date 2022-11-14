import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _extended = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final destinations = [
      KrsNavigationRailDestination(
        icon: const Icon(Icons.movie_outlined),
        selectedIcon: const Icon(Icons.movie),
        label: Text(locale.movies),
        routeName: '/',
        focusNode: FocusNode(),
      ),
      KrsNavigationRailDestination(
        icon: const Icon(Icons.tv),
        selectedIcon: const Icon(Icons.tv),
        label: Text(locale.tvshows),
        routeName: '/tskg',
        focusNode: FocusNode(),
      ),
      KrsNavigationRailDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        label: Text(locale.settings),
        routeName: '/settings',
        focusNode: FocusNode(),
      ),
    ];

    return Scaffold(
      body: FocusTraversalGroup(
        policy:  OrderedTraversalPolicy(),
        child: Stack(
          children: [

            FocusTraversalOrder(
              order: NumericFocusOrder(1.0),
              child: Positioned(
                left: 0.0,
                top: 0.0,
                bottom: 0.0,
                child: Focus(
                  skipTraversal: true,
                  canRequestFocus: false,
                  onKeyEvent: (node, event) {
                    // if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
                    //   //FocusScope.of(context).focusInDirection(TraversalDirection.down);
                    //   //FocusScope.of(context).children.first.nextFocus();
                    //   print(FocusScope.of(context).traversalChildren.first.context?.widget);
                    //   return KeyEventResult.handled;
                    // }

                    return KeyEventResult.ignored;
                  },
                  onFocusChange: (hasFocus) {
                    setState(() {
                      _extended = hasFocus;
                    });
                  },
                  child: NavigationRail(
                    // labelType: NavigationRailLabelType.all,
                    backgroundColor: theme.colorScheme.shadow.withOpacity(0.12),
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
            ),
            

            /// основной контент
            FocusTraversalOrder(
              order: NumericFocusOrder(2.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
      // body: Row(
      //   children: [

      //     Column(
      //       children: [

      //         Expanded(
      //           child: IntrinsicWidth(
      //             child: Focus(
      //               skipTraversal: true,
      //               onFocusChange: (hasFocus) {
      //                 setState(() {
      //                   _extended = hasFocus;
      //                 });
      //               },
      //               child: NavigationRail(
      //                 labelType: NavigationRailLabelType.all,
      //                 selectedIndex: ScaffoldWithNavigationBar._calculateSelectedIndex(context),
                      
      //                 onDestinationSelected: (index) {
      //                   /// переходим на страницу, выбранную пользователем
      //                   GoRouter.of(context).go(destinations[index].routeName);
      //                 },
      //                 destinations: destinations,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),

      //     const VerticalDivider(thickness: 1, width: 1),
          
      //     /// основной контент
      //     Expanded(
      //       child: widget.child,
      //     ),
      //   ],
      // ),
    );
  }
}

class KrsNavigationRailDestination extends NavigationRailDestination {
  
  KrsNavigationRailDestination({
    required super.icon,
    required Widget label,
    required FocusNode focusNode,
    super.selectedIcon,
    super.padding,
    this.routeName = '',
  }) : super(
    label: Focus(
      skipTraversal: true,
      canRequestFocus: true,
      focusNode: focusNode,
      child: label,
    )
  );

  final focusNode = FocusNode();
  final String routeName;

  void requestFocus() {
    focusNode.requestFocus();
  }

}