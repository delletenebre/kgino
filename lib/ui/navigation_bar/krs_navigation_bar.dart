import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/navigation_provider.dart';
import '../pages/krs_app_bar.dart';
import 'krs_navigation_button.dart';

class KrsNavigationBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const KrsNavigationBar({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final selectedTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);

    final focused = useState(tabsController.focusNode.hasFocus);

    print('selectedTab: $selectedTab');

    return Focus(
      focusNode: tabsController.focusNode,
      canRequestFocus: false,
      onKey: (node, event) {
        if (focused.value) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            tabsController.changePage(selectedTab - 1);
            return KeyEventResult.handled;
          }

          if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            tabsController.changePage(selectedTab + 1);
            return KeyEventResult.handled;
          }

          // if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          //   return KeyEventResult.handled;
          // }
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;

        print('FOCUS CHANGED $hasFocus');
        if (hasFocus) {
          //tabsController.requestCurrentActiveTabFocus();
        }
      },
      child: KrsAppBar(
        spacing: 4.0,
        children: [
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 0,
            onSelected: () {
              tabsController.changePage(0);
            },
            child: const Text('Поиск'),
          ),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 1,
            onSelected: () {
              tabsController.changePage(1);
            },
            child: const Text('Сериалы'),
          ),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 2,
            onSelected: () {
              tabsController.changePage(2);
            },
            child: const Text('Фильмы'),
          ),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 3,
            onSelected: () {
              tabsController.changePage(3);
            },
            child: const Text('Камеры'),
          ),
          const Spacer(),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 4,
            onSelected: () {
              tabsController.changePage(4);
            },
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const KrsAppBar().preferredSize;
}
