import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/navigation.dart';
import '../../resources/constants.dart';
import '../../resources/krs_locale.dart';
import '../app_logo.dart';
import 'krs_navigation_button.dart';
import 'krs_navigation_search_button.dart';
import 'krs_navigation_bar_settings_button.dart';

class KrsNavigationBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const KrsNavigationBar({super.key});

  @override
  Widget build(context, ref) {
    final locale = KrsLocale.of(context);

    final activeTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);

    final focused = useState(tabsController.focusNode.hasFocus);

    return Align(
      alignment: Alignment.centerLeft,
      child: Focus(
        focusNode: tabsController.focusNode,
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (hasFocus) {
          focused.value = hasFocus;

          if (hasFocus) {
            tabsController.requestCurrentActiveTabFocus();
          }
        },
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: focused.value ? 1.0 : 0.62,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              AnimatedPositioned(
                duration: kThemeAnimationDuration,
                left: tabsController.isSearchSelected
                    ? -appLogoWidth
                    : TvUi.hPadding,
                child: AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: tabsController.isSearchSelected ? 0.0 : 1.0,
                  child: const AppLogo(),
                ),
              ),
              AnimatedPositioned(
                duration: kThemeAnimationDuration,
                left: tabsController.isSearchSelected
                    ? TvUi.hPadding
                    : TvUi.hPadding + appLogoWidth + 4.0,
                right: TvUi.hPadding,
                child: Row(
                  children: [
                    KrsNavigationSearchButton(
                      selected: activeTab == 0,
                      onFocusChange: (hasFocus) {
                        if (focused.value && hasFocus) {
                          tabsController.changePage(0);
                        }
                      },
                      label: locale.search,
                      icon: Icons.search,
                    ),
                    const SizedBox(width: 6.0),
                    KrsNavigationButton(
                      selected: activeTab == 1,
                      onFocusChange: (hasFocus) {
                        if (focused.value && hasFocus) {
                          tabsController.changePage(1);
                        }
                      },
                      label: locale.shows,
                    ),
                    const SizedBox(width: 6.0),
                    KrsNavigationButton(
                      selected: activeTab == 2,
                      onFocusChange: (hasFocus) {
                        if (focused.value && hasFocus) {
                          tabsController.changePage(2);
                        }
                      },
                      label: locale.movies,
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    // KrsNavigationButton(
                    //   selected: activeTab == 2,
                    //   onFocusChange: (hasFocus) {
                    //     if (hasFocus) {
                    //       tabsController.changePage(2);
                    //     }
                    //   },
                    //   icon: Icons.settings_outlined,
                    // ),
                    const KrsNavigationBarSettingsButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => TvUi.navigationBarSize;
}
