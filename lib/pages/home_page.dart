import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/navigation.dart';
import '../resources/krs_locale.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final tabsController = ref.read(navigationProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        if (tabsController.isSearchSelected) {
          tabsController.changePage(1);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: const KrsNavigationBar(),
        body: PageView(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          controller: tabsController.pageController,
          children: tabsController.pages,
        ),
      ),
    );

    // TabBar(
    //   indicatorWeight: 0.0,
    //   controller: tabController,
    //   tabAlignment: TabAlignment.center,
    //   indicator: BoxDecoration(
    //     borderRadius: BorderRadius.circular(32.0),
    //     color: Colors.green,
    //   ),
    //   indicatorSize: TabBarIndicatorSize.tab,
    //   unselectedLabelColor: Colors.grey,
    //   splashBorderRadius: BorderRadius.circular(32),
    //   tabs: [
    //     TextButton(
    //       style: ButtonStyle(
    //         overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
    //           return Colors.transparent;
    //         }),
    //       ),
    //       onFocusChange: (focused) {
    //         print('search focus: $focused');
    //         if (focused) {
    //           tabController.animateTo(0);
    //         }
    //       },
    //       onPressed: () {},
    //       child: Text('Ыуфкс'),
    //     ),
    //     TextButton(
    //       style: ButtonStyle(
    //         overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
    //           return Colors.transparent;
    //         }),
    //       ),
    //       onFocusChange: (focused) {
    //         if (focused) {
    //           tabController.animateTo(1);
    //         }
    //       },
    //       onPressed: () {},
    //       child: Text('Shows'),
    //     ),
    //     TextButton(
    //       style: ButtonStyle(
    //         overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
    //           return Colors.transparent;
    //         }),
    //       ),
    //       onFocusChange: (focused) {
    //         if (focused) {
    //           tabController.animateTo(2);
    //         }
    //       },
    //       onPressed: () {},
    //       child: Text('Movies'),
    //     ),
    //   ],
    // ),

    // final screenSize = MediaQuery.of(context).size;

    // final focused = useState(false);

    // //final activeTab = ref.watch(tabsProvider);
    // final tabsController = ref.read(tabsProvider.notifier);

    // return Scaffold(
    //   // endDrawer: SizedBox(
    //   //   width: 320.0, //showOverlay.value ? 320.0 : 0,
    //   //   height: screenSize.height - 32.0,
    //   //   child: Card(
    //   //     elevation: 8.0,
    //   //     shape: RoundedRectangleBorder(
    //   //       borderRadius: BorderRadius.circular(28.0),
    //   //     ),
    //   //     child: Padding(
    //   //       padding: const EdgeInsets.all(24.0),
    //   //       child: ListView(
    //   //         children: [
    //   //           ListTile(
    //   //             onTap: () {
    //   //               // Utils.showModal(
    //   //               //   context: context,
    //   //               //   titleText: 'Аккаунт Filmix',
    //   //               //   child: const FlmxAccountDialog(),
    //   //               // );
    //   //             },
    //   //             title: const Text('Аккаунт Filmix'),
    //   //           ),
    //   //         ],
    //   //       ),
    //   //     ),
    //   //   ),
    //   // ),
    //   appBar: PreferredSize(
    //     preferredSize: const Size(double.maxFinite, 32.0 + (paddingSize * 2)),
    //     child: Focus(
    //       canRequestFocus: false,
    //       skipTraversal: true,
    //       onFocusChange: (hasFocus) {
    //         focused.value = hasFocus;

    //         if (hasFocus) {
    //           tabsController.requestFocus();
    //         }
    //       },
    //       child: Opacity(
    //         opacity: focused.value ? 1.0 : 0.62,
    //         child: Stack(
    //           alignment: AlignmentDirectional.centerStart,
    //           children: [
    //             AnimatedPositioned(
    //               duration: kThemeAnimationDuration,
    //               left: tabsController.isSearchSelected
    //                   ? -appLogoWidth
    //                   : TvUi.hPadding,
    //               child: AnimatedOpacity(
    //                 duration: KrsTheme.animationDuration,
    //                 opacity: tabsController.isSearchSelected ? 0.0 : 1.0,
    //                 child: const AppLogo(),
    //               ),
    //             ),
    //             AnimatedPositioned(
    //               duration: kThemeAnimationDuration,
    //               left: tabsController.isSearchSelected
    //                   ? TvUi.hPadding
    //                   : TvUi.hPadding + appLogoWidth + 4.0,
    //               right: paddingSize,
    //               child: Row(
    //                 children: [
    //                   KrsTabBarSearchButton(
    //                     index: 0,
    //                     onPressed: () {},
    //                   ),
    //                   const SizedBox(width: 4.0),
    //                   KrsTabBarButton(
    //                     index: 1,
    //                     onPressed: () {},
    //                     label: Text(locale.shows),
    //                   ),
    //                   const SizedBox(width: 4.0),
    //                   KrsTabBarButton(
    //                     index: 2,
    //                     onPressed: () {},
    //                     label: Text(locale.movies),
    //                   ),
    //                   // const SizedBox(width: 4.0),
    //                   // KrsTabBarButton(
    //                   //   index: 2,
    //                   //   onPressed: () {},
    //                   //   label: Text(locale.cameras),
    //                   // ),
    //                   // const KrsTabBarSettingsButton(),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: PageView(
    //     physics: const NeverScrollableScrollPhysics(),
    //     onPageChanged: (index) {
    //       tabsController.updateSelected(index);
    //     },
    //     controller: pageController,
    //     children: const [
    //       SearchPage(),
    //       ShowsPage(),
    //       MoviesPage(),
    //     ],
    //   ),
    // );
  }
}

// class KrsTab {
//   final Widget page;
//   final Widget tab;
// }
