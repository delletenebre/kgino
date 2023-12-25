import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'krs_navigation_button.dart';

class KrsNavigationBar extends HookWidget implements PreferredSizeWidget {
  final PageController controller;
  final void Function(int page) onPageChanged;
  final int selectedPage;

  const KrsNavigationBar({
    super.key,
    required this.controller,
    required this.onPageChanged,
    required this.selectedPage,
  });

  @override
  Widget build(context) {
    final focused = useState(false);

    return Focus(
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;
      },
      child: SizedBox.fromSize(
        size: preferredSize,
        child: Row(
          children: [
            KrsNavigationButton(
              active: focused.value,
              selected: selectedPage == 0,
              onSelected: () {
                onPageChanged.call(0);
              },
              child: const Text('Поиск'),
            ),
            KrsNavigationButton(
              active: focused.value,
              selected: selectedPage == 1,
              onSelected: () {
                onPageChanged.call(1);
              },
              child: const Text('Сериалы'),
            ),
            KrsNavigationButton(
              active: focused.value,
              selected: selectedPage == 2,
              onSelected: () {
                onPageChanged.call(2);
              },
              child: const Text('Фильмы'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
