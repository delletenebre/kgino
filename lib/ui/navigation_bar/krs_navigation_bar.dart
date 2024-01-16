import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/navigation_provider.dart';
import '../../resources/krs_theme.dart';
import 'krs_navigation_button.dart';

class KrsNavigationBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  // final PageController controller;
  // final void Function(int page) onPageChanged;
  // final void Function(bool hasFocus) onFocusChange;
  // final int selectedPage;

  const KrsNavigationBar({
    super.key,
    // required this.controller,
    // required this.onPageChanged,
    // required this.selectedPage,
    // required this.onFocusChange,
  });

  @override
  Widget build(context, ref) {
    final selectedTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);

    final focused = useState(tabsController.focusNode.hasFocus);

    print('selectedTab2: $selectedTab');
    print('focused: ${focused.value}');

    return Focus(
      focusNode: tabsController.focusNode,
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;

        if (hasFocus) {
          tabsController.requestCurrentActiveTabFocus();
        }
      },
      child: SizedBox.fromSize(
        size: preferredSize,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
          child: Row(
            children: [
              KrsNavigationButton(
                //focusNode: focusNodes[0],
                active: focused.value,
                selected: selectedTab == 0,
                onSelected: () {
                  tabsController.changePage(0);

                  // onPageChanged.call(0);
                  // selected.value = 0;
                },
                child: const Text('Поиск'),
              ),
              KrsNavigationButton(
                // focusNode: focusNodes[1],
                active: focused.value,
                selected: selectedTab == 1,
                onSelected: () {
                  tabsController.changePage(1);
                },
                child: const Text('Сериалы'),
              ),
              KrsNavigationButton(
                //focusNode: focusNodes[2],
                active: focused.value,
                selected: selectedTab == 2,
                onSelected: () {
                  tabsController.changePage(2);
                },
                child: const Text('Фильмы'),
              ),
              KrsNavigationButton(
                // focusNode: focusNodes[3],
                active: focused.value,
                selected: selectedTab == 3,
                onSelected: () {
                  tabsController.changePage(3);
                },
                child: const Text('Камеры'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
