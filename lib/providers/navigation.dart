import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/movies_page.dart';
import '../pages/search_page.dart';
import '../pages/shows_page.dart';

part 'navigation.g.dart';

@riverpod
class Navigation extends _$Navigation {
  late final FocusNode focusNode;
  late final PageController pageController;
  final pages = const [
    SearchPage(),
    ShowsPage(),
    MoviesPage(),
  ];

  @override
  int build() {
    focusNode = FocusNode();
    pageController = PageController(initialPage: 1);

    ref.onDispose(() {
      focusNode.dispose();
      pageController.dispose();

      debugPrint('navigationProvider disposed');
    });

    return pageController.initialPage;
  }

  void changePage(int pageIndex) {
    state = pageIndex;
    pageController.animateToPage(
      pageIndex,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
    );
  }

  void requestCurrentActiveTabFocus() {
    focusNode.children
        .where((element) => element.canRequestFocus)
        .elementAtOrNull(state)
        ?.requestFocus();
  }

  bool get isSearchSelected => state == 0;
}
