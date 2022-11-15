import 'package:flutter/material.dart';
import 'package:kgino/pages/settings_page.dart';

import '../resources/krs_locale.dart';
import '../ui/navigation_bar/krs_tab_bar.dart';
import 'ockg/ockg_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            title: KrsTabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: locale.movies,
                ),
                Tab(
                  text: locale.tvshows,
                ),
                Tab(
                  text: locale.settings,
                )
              ]
            ),
          ),
          // SliverToBoxAdapter(
          //   child: KrsTabBar(
          //     controller: _tabController,
          //     tabs: [
          //       Tab(
          //         text: locale.movies,
          //       ),
          //       Tab(
          //         text: locale.tvshows,
          //       ),
          //       Tab(
          //         text: locale.settings,
          //       )
          //     ]
          //   ),
          // ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OckgHomePage(),
                OckgHomePage(),
                SettingsPage(),
              ],
            )
          ),
        ],
      ),
      // NestedScrollView(
      //   headerSliverBuilder: (context, value) {
      //     return [
      //       SliverToBoxAdapter(
      //         child: KrsTabBar(
      //           controller: _tabController,
      //           tabs: [
      //             Tab(
      //               text: locale.movies,
      //             ),
      //             Tab(
      //               text: locale.tvshows,
      //             ),
      //             Tab(
      //               text: locale.settings,
      //             )
      //           ]
      //         ),
      //       ),
      //     ];
      //   },
      //   body: TabBarView(
      //     controller: _tabController,
      //     children: const [
      //       OckgHomePage(),
      //       OckgHomePage(),
      //       SettingsPage(),
      //     ],
      //   ),
      // ),



      // appBar: KrsTabBar(
      //   controller: _tabController,
      //   tabs: [
      //     Tab(
      //       text: locale.movies,
      //     ),
      //     Tab(
      //       text: locale.tvshows,
      //     ),
      //     Tab(
      //       text: locale.settings,
      //     )
      //   ]
      // ),
      // body: TabBarView(
      //   controller: _tabController,
      //   children: const [
      //     OckgHomePage(),
      //     OckgHomePage(),
      //     SettingsPage(),
      //   ],
      // ),
    );
  }
}