import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../controllers/tabs_cubit.dart';
import '../pages/home_page.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import 'navigation_bar/button_search_field.dart';
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

    final duration = KrsTheme.animationDuration;

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
                vertical: 32.0,
              ),
              child: Opacity(
                opacity: focused.value ? 1.0 : 0.62,
                child: BlocProvider(
                  create: (_) => tabsCubit,
                  child: BlocBuilder<TabsCubit, int>(
                    builder: (context, selectedIndex) => Row(
                      children: [
                        
                        AnimatedOpacity(
                          duration: Duration(milliseconds: tabsCubit.state == 0 ? 150 : 250),
                          opacity: tabsCubit.state == 0 ? 0.0 : 1.0,
                          child: AnimatedContainer(
                            duration: KrsTheme.animationDurationLong,
                            margin: EdgeInsetsDirectional.only(
                              start: tabsCubit.state == 0 ? 0 : 32.0,
                              end: 32.0,
                            ),
                            width: tabsCubit.state == 0 ? 0 : 48.0,
                            
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
                                      color: theme.colorScheme.outline,
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
                                    ButtonSearchField(
                                      focusNode: tabsCubit.focusNodes[0],
                                      selected: tabsCubit.state == 0,
                                      active: focused.value,
                                      onFocusChange: (hasFocus) {
                                        if (hasFocus) {
                                          tabsCubit.updateSelected(0);
                                        }
                                        if (focused.value && hasFocus) {
                                          // _controller?.animateTo(index);
                                          // widget.onTap?.call(index);
                                        }
                                        
                                      },
                                      onPressed: () {
                                        // _controller?.animateTo(index);
                                        // widget.onTap?.call(index);
                                      },
                                    ),
                                    
                                    KrsTabBarButton(
                                      index: 1,
                                      onPressed: () {  },
                                      label: Text(locale.movies),
                                    ),

                                    KrsTabBarButton(
                                      index: 2,
                                      onPressed: () {  },
                                      label: Text(locale.shows),
                                    ),

                                    KrsTabBarButton(
                                      index: 3,
                                      onPressed: () {

                                      },
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
                HomePage(),

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

// class KrsNavigationRailDestination extends NavigationRailDestination {
  
//   KrsNavigationRailDestination({
//     required super.icon,
//     required super.label,
//     super.selectedIcon,
//     super.padding,
//     this.routeName = '',
//   });

//   final String routeName;

// }