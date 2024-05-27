import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/active_horizontal_list_provider.dart';
import '../ui/navigation/kika_navigation_rail.dart';
import 'cameras_page.dart';
import 'movies_page.dart';
import 'search_page/search_page.dart';
import 'shows_page.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  createState() => HomeLayoutState();

  // static HomeLayoutState? maybeOf(BuildContext context) {
  //   return context.findAncestorStateOfType<HomeLayoutState>();
  // }
}

class HomeLayoutState extends ConsumerState<HomePage> {
  final navigationRailKey = GlobalKey<KikaNavigationRailState>();

  final pages = const [
    SearchPage(),
    ShowsPage(),
    MoviesPage(),
    CamerasPage(),
  ];

  final pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final drawerFocusNode = useFocusNode();

    ref.listen(activeHorizontalListProvider, (previous, next) {
      if (next == -1) {
        openDrawer();
      } else if (next > 0) {
        hideDrawer();
      } else {
        showDrawer();
      }
    });

    return BackButtonListener(
      onBackButtonPressed: () async {
        if (pageController.page == 0) {
          navigationRailKey.currentState?.openDrawer();
          navigationRailKey.currentState?.animateTo(1);
          return true;
        }

        return false;
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
          ),
          KikaNavigationRail(
            key: navigationRailKey,
            focusNode: drawerFocusNode,
            pageController: pageController,
          ),
        ],
      ),
    );
  }

  void openDrawer() {
    navigationRailKey.currentState?.openDrawer();
    // scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    // scaffoldKey.currentState?.closeDrawer();
    navigationRailKey.currentState?.closeDrawer();
  }

  void showDrawer() {
    navigationRailKey.currentState?.showDrawer();
  }

  void hideDrawer() {
    navigationRailKey.currentState?.hideDrawer();
  }
}
