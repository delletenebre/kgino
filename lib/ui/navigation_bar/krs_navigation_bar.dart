import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/navigation_provider.dart';
import '../pages/krs_app_bar.dart';
import 'krs_navigation_button.dart';

class KrsNavigationBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  final void Function()? onKeyDown;

  const KrsNavigationBar({
    super.key,
    this.onKeyDown,
  });

  @override
  Widget build(context, ref) {
    final selectedTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);

    final focused = useState(tabsController.focusNode.hasFocus);

    return Focus(
      focusNode: tabsController.focusNode,
      autofocus: true,
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

          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            onKeyDown?.call();
            return onKeyDown != null
                ? KeyEventResult.handled
                : KeyEventResult.ignored;
          }
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;

        if (hasFocus) {
          tabsController.requestCurrentActiveTabFocus();
        }
      },
      child: KrsAppBar(
        backButtonEnabled: false,
        children: [
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 0,
            onSelected: () {
              tabsController.changePage(0);
            },
            child: const Text('Поиск'),
          ),
          const SizedBox(width: 4.0),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 1,
            onSelected: () {
              tabsController.changePage(1);
            },
            child: const Text('Сериалы'),
          ),
          const SizedBox(width: 4.0),
          KrsNavigationButton(
            active: focused.value,
            selected: selectedTab == 2,
            onSelected: () {
              tabsController.changePage(2);
            },
            child: const Text('Фильмы'),
          ),
          const SizedBox(width: 4.0),
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
