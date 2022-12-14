import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/ockg/ockg_search_controller.dart';
import '../controllers/tskg/tskg_search_controller.dart';
import '../resources/krs_locale.dart';
import '../ui/navigation_bar/krs_tab_bar.dart';
import 'ockg/ockg_home_page.dart';
import 'search_page.dart';
import 'settings_page.dart';
import 'tskg/tskg_home_page.dart';
import 'wcam/wcam_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _tabBarHasFocus = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OckgSearchController>(
            create: (context) => OckgSearchController(),
          ),
          BlocProvider<TskgSearchController>(
            create: (context) => TskgSearchController(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    left: 32.0,
                  ),
                  child: Row(
                    children: [
                      Text('KG',
                        style: TextStyle(
                          color: theme.colorScheme.outline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text('ino',
                        style: TextStyle(
                          color: theme.colorScheme.outline,
                        ),
                      ),

                      const SizedBox(
                        width: 40.0,
                      ),

                      Expanded(
                        child: KrsTabBar(
                          onFocusChanged: (hasFocus) {
                            setState(() {
                              _tabBarHasFocus = hasFocus;
                            });
                          },
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: locale.search,
                            ),
                            Tab(
                              text: locale.movies,
                            ),
                            Tab(
                              text: locale.shows,
                            ),
                            Tab(
                              text: locale.cameras,
                            ),
                            Tab(
                              text: locale.settings,
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Stack(
                    children: [
                      TabBarView(
                        clipBehavior: Clip.none,
                        controller: _tabController,
                        children: const [
                          SearchPage(),
                          OckgHomePage(),
                          TskgHomePage(),
                          WcamHomePage(),
                          SettingsPage(),
                        ],
                      ),

                      Visibility(
                        visible: _tabBarHasFocus,
                        child: Positioned.fill(
                          child: ColoredBox(
                            color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}