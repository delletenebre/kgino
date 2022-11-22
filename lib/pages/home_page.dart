import 'package:flutter/material.dart';
import 'package:kgino/pages/search_page.dart';
import 'package:kgino/pages/settings_page.dart';

import '../resources/krs_locale.dart';
import '../ui/forms/krs_text_field.dart';
import '../ui/navigation_bar/krs_tab_bar.dart';
import 'ockg/ockg_home_page.dart';
import 'tskg/tskg_home_page.dart';

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
    _tabController = TabController(
      vsync: this,
      length: 4,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 32.0,
            ),
            child: SizedBox(
              height: 40.0,
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
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: locale.search,
                        ),
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
                  
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              clipBehavior: Clip.none,
              controller: _tabController,
              children: const [
                SearchPage(),
                OckgHomePage(),
                TskgHomePage(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}