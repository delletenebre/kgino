import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/cameras_page.dart';
import '../pages/movies_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/shows_page.dart';

part 'navigation_provider.g.dart';

@riverpod
class Navigation extends _$Navigation {
  late final FocusNode focusNode;
  late final PageController pageController;
  final pages = const [
    SearchPage(),
    ShowsPage(),
    MoviesPage(),
    CamerasPage(),
    SettingsPage(),
  ];

  @override
  int build() {
    focusNode = FocusNode();
    pageController = PageController(initialPage: 1);

    ref.onDispose(() {
      focusNode.dispose();
      pageController.dispose();
    });

    return pageController.initialPage;
  }

  void changePage(int pageIndex) {
    if (0 <= pageIndex && pageIndex < pages.length) {
      state = pageIndex;
      pageController.animateToPage(
        pageIndex,
        duration: kThemeAnimationDuration,
        curve: Curves.easeOut,
      );
      requestCurrentActiveTabFocus();
    }
  }

  void navigateBack() {
    state = 1;
    requestCurrentActiveTabFocus();
  }

  void requestCurrentActiveTabFocus() {
    if (focusNode.hasFocus) {
      focusNode.children
          .where((element) => element.canRequestFocus)
          .elementAtOrNull(state)
          ?.requestFocus();
    }
  }

  bool get isSearchSelected => state == 0;
}
