import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/tabs_cubit.dart';
import '../pages/cameras_page.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/movies_page.dart';
import '../pages/search_page.dart';
import '../pages/shows_page.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import 'navigation_bar/krs_tab_bar_search_button.dart';
import 'navigation_bar/krs_tab_bar_button.dart';

class ScaffoldWithNavigationBar extends HookWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final focused = useState(false);
    
    final tabsCubit = GetIt.instance<TabsCubit>();

    // final destinations = [
    //   NavigationTitle(
    //     label: Text(locale.users),
    //   ),

    //   NavigationLink(
    //     icon: const Icon(Icons.business),
    //     selectedIcon: const Icon(Icons.business),
    //     label: Text(locale.insuranceCompanies),
    //     route: '/insuranceCompanies',
    //   ),

    //   NavigationLink(
    //     icon: const Icon(Icons.people_outline),
    //     selectedIcon: const Icon(Icons.people),
    //     label: Text(locale.listOfUsers),
    //     route: '/users',
    //   ),
    // ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Focus(
            canRequestFocus: false,
            skipTraversal: true,
            onFocusChange: (hasFocus) {
              focused.value = hasFocus;

              if (hasFocus) {
                tabsCubit.requestFocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
              ),
              child: Opacity(
                opacity: focused.value ? 1.0 : 0.62,
                child: BlocProvider(
                  create: (_) => tabsCubit,
                  child: BlocBuilder<TabsCubit, int>(
                    builder: (context, selectedIndex) => Row(
                      children: [
                        
                        AnimatedOpacity(
                          duration: KrsTheme.animationDuration,
                          opacity: tabsCubit.state == 0 ? 0.0 : 1.0,
                          child: AnimatedContainer(
                            duration: KrsTheme.animationDuration,
                            margin: EdgeInsetsDirectional.only(
                              start: tabsCubit.state == 0 ? 0 : 24.0,
                              end: 32.0,
                            ),
                            width: tabsCubit.state == 0 ? 0 : 58.0,
                            
                            child: RichText(
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              text: TextSpan(
                                text: 'KG',
                                style: TextStyle(
                                  color: theme.colorScheme.outline,
                                  fontWeight: FontWeight.bold,
                                ),

                                children: [
                                  TextSpan(
                                    text: 'ino',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),

                                  TextSpan(
                                    text: '    4.1.2',
                                    style: TextStyle(
                                      fontSize: 6.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),

                        ),

                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    KrsTabBarSearchButton(
                                      index: 0,
                                      onPressed: () {}, 
                                    ),
                                    
                                    KrsTabBarButton(
                                      index: 1,
                                      onPressed: () {},
                                      label: Text(locale.movies),
                                    ),

                                    KrsTabBarButton(
                                      index: 2,
                                      onPressed: () {},
                                      label: Text(locale.shows),
                                    ),

                                    KrsTabBarButton(
                                      index: 3,
                                      onPressed: () {},
                                      label: Text(locale.cameras),
                                    ),
                                  ],
                                ),
                              ),

                              // /// кнопка входа в настройки
                              // IconButton(
                              //   tooltip: locale.settings,
                              //   onPressed: () {
                              //     /// переходим на страницу настроек
                              //     context.go('/settings');
                              //   },
                              //   icon: const Icon(Icons.settings),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ),
          
          Expanded(
            child: Stack(
              children: [

                BlocProvider(
                  create: (_) => tabsCubit,
                  child: BlocBuilder<TabsCubit, int>(
                    builder: (context, selectedIndex) {
                      switch (selectedIndex) {
                        case 0:
                          return const SearchPage();
                        case 1:
                          return const MoviesPage();
                        case 2:
                          return const ShowsPage();
                        case 3:
                          return const CamerasPage();
                          
                        default:
                          return const ErrorPage();
                      }
                    },
                  ),
                ),
                      

                // Visibility(
                //   visible: _tabBarHasFocus,
                //   child: Positioned.fill(
                //     child: ColoredBox(
                //       color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
