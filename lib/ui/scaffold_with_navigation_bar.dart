import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../controllers/tabs_cubit.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import 'app_logo.dart';
import 'navigation_bar/krs_tab_bar_search_button.dart';
import 'navigation_bar/krs_tab_bar_button.dart';
import 'navigation_bar/krs_tab_bar_settings_button.dart';

class ScaffoldWithNavigationBar extends HookWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    final locale = KrsLocale.of(context);

    final focused = useState(false);
    
    final tabsCubit = GetIt.instance<TabsCubit>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 148.0 + 24.0),
        child: Focus(
          canRequestFocus: false,
          skipTraversal: true,
          onFocusChange: (hasFocus) {
            focused.value = hasFocus;

            if (hasFocus) {
              tabsCubit.requestFocus();
            }
          },
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
                        
                        child: const AppLogo(),

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

                                const SizedBox(width: 4.0),
                                
                                KrsTabBarButton(
                                  index: 1,
                                  onPressed: () {},
                                  label: Text(locale.movies),
                                ),

                                const SizedBox(width: 4.0),

                                KrsTabBarButton(
                                  index: 2,
                                  onPressed: () {},
                                  label: Text(locale.shows),
                                ),

                                const SizedBox(width: 4.0),

                                KrsTabBarButton(
                                  index: 3,
                                  onPressed: () {},
                                  label: Text(locale.cameras),
                                ),
                              ],
                            ),
                          ),

                          /// кнопка входа в настройки
                          const KrsTabBarSettingsButton(),
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
      body: child,
    );
  }
}
