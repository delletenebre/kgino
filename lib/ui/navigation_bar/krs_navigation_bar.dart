import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../resources/krs_theme.dart';
import 'krs_navigation_button.dart';

class KrsNavigationBar extends HookWidget implements PreferredSizeWidget {
  final PageController controller;
  final void Function(int page) onPageChanged;
  final void Function(bool hasFocus) onFocusChange;
  final int selectedPage;

  const KrsNavigationBar({
    super.key,
    required this.controller,
    required this.onPageChanged,
    required this.selectedPage,
    required this.onFocusChange,
  });

  @override
  Widget build(context) {
    final focusNodes = [useFocusNode(), useFocusNode(), useFocusNode()];

    final focused = useState(false);

    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          focusNodes[controller.page?.toInt() ?? controller.initialPage]
              .requestFocus();
        }
        focused.value = hasFocus;
      },
      child: SizedBox.fromSize(
        size: preferredSize,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
          child: Row(
            children: [
              KrsNavigationButton(
                focusNode: focusNodes[0],
                active: focused.value,
                selected: selectedPage == 0,
                onSelected: () {
                  onPageChanged.call(0);
                },
                child: const Text('Поиск'),
              ),
              KrsNavigationButton(
                focusNode: focusNodes[1],
                active: focused.value,
                selected: selectedPage == 1,
                onSelected: () {
                  onPageChanged.call(1);
                },
                child: const Text('Сериалы'),
              ),
              KrsNavigationButton(
                focusNode: focusNodes[2],
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
