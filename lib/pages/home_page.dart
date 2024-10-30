import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../providers/active_horizontal_list_provider.dart';
import '../providers/locale_provider.dart';
import '../ui/navigation/kika_navigation_rail.dart';
import 'bookmarks_page.dart';
import 'cameras_page.dart';
import 'movies_page.dart';
import 'search_page/search_page.dart';
import 'shows_page.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  createState() => HomeLayoutState();

  static HomeLayoutState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<HomeLayoutState>();
  }
}

class HomeLayoutState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final navigationRailKey = GlobalKey<KikaNavigationRailState>();

  final pages = const [
    SearchPage(),
    BookmarksPage(),
    ShowsPage(),
    MoviesPage(),
    CamerasPage(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 2);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);
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

    final listState = ref.watch(activeHorizontalListProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Focus(
          //   canRequestFocus: false,
          //   child: TransformerPageView(
          //     pageController: _pageController,
          //     scrollDirection: Axis.vertical,
          //     transformer: ScaleAndFadeTransformer(),
          //     itemCount: _pageController.itemCount!,
          //     itemBuilder: (context, index) {
          //       return pages[index];
          //     },
          //   ),
          // ),

          Focus(
            canRequestFocus: false,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),

          KikaNavigationRail(
            key: navigationRailKey,
            focusNode: drawerFocusNode,
            pageController: _pageController,
            // goToPage: goToPage,
          ),
        ],
      ),
      floatingActionButton: listState > 0
          ? Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: theme.colorScheme.outline.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.back_square,
                    size: 16.0,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    locale.menu,
                    style: TextStyle(
                      color: theme.colorScheme.outline,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void animateTo(int index) {
    navigationRailKey.currentState?.animateTo(index);
    setState(() {});
  }

  void openDrawer() {
    navigationRailKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    navigationRailKey.currentState?.closeDrawer();
  }

  void showDrawer() {
    navigationRailKey.currentState?.showDrawer();
  }

  void hideDrawer() {
    navigationRailKey.currentState?.hideDrawer();
  }
}

// class ScaleAndFadeTransformer extends PageTransformer {
//   final double _scale;
//   final double _fade;

//   ScaleAndFadeTransformer({double fade = 0.0, double scale = 0.8})
//       : _fade = fade,
//         _scale = scale;

//   @override
//   Widget transform(Widget child, TransformInfo info) {
//     final position = info.position!;
//     final scaleFactor = (1 - position.abs()) * (1 - _scale);
//     final fadeFactor = (1 - position.abs()) * (1 - _fade);
//     final opacity = _fade + fadeFactor;
//     final scale = _scale + scaleFactor;
//     print('opacityopacity: $position');

//     return Opacity(
//       opacity: opacity,
//       child: Transform.translate(
//         offset: Offset(0.0, info.height! * -position),
//         child: child,
//       ),
//     );
//   }
// }
