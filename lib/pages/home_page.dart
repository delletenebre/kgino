import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/ockg/ockg_search_controller.dart';
import '../controllers/tskg/tskg_search_controller.dart';
import '../resources/krs_locale.dart';
import '../ui/navigation_bar/krs_tab_bar.dart';
import 'ockg/ockg_home_page.dart';
import 'search_page.dart';
import 'tskg/tskg_home_page.dart';
import 'wcam/wcam_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _tabBarHasFocus = false;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final settingsBox = Hive.box('settings');

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
        child: ValueListenableBuilder(
          valueListenable: settingsBox.listenable(
            keys: ['enableCategoryCameras']
          ),
          builder: (context, box, child) {
            final camerasEnabled = settingsBox.get('enableCategoryCameras',
              defaultValue: true
            );

            final tabs = [
              Tab(
                text: locale.search,
              ),
              Tab(
                text: locale.movies,
              ),
              Tab(
                text: locale.shows,
              ),
              if (camerasEnabled) Tab(
                text: locale.cameras,
              ),
            ];

            if (_tabController?.length != tabs.length) {
              _tabController?.dispose();
              _tabController = TabController(
                vsync: this,
                length: tabs.length,
                initialIndex: _tabController == null ? 1 : tabs.length - 1,
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    left: 32.0,
                    right: 32.0,
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
                          tabs: tabs,
                        ),
                      ),

                      /// кнопка входа в настройки
                      IconButton(
                        tooltip: locale.settings,
                        onPressed: () {
                          /// переходим на страницу настроек
                          context.go('/settings');
                        },
                        icon: const Icon(Icons.settings),
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
                        children: [
                          /// страница поиска
                          const SearchPage(),

                          /// страница фильмов
                          const OckgHomePage(),

                          /// страница сериалов
                          const TskgHomePage(),

                          /// страница веб-камер
                          if (camerasEnabled) const WcamHomePage(),
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