import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'movies_page.dart';
import 'search_page.dart';
import 'shows_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final pageViewController = usePageController(
      initialPage: 1,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 48.0 + 24.0),
        child: Row(
          children: [
            FilledButton(
              onFocusChange: (hasFocus) {
                pageViewController.animateToPage(0,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              onPressed: () {
                pageViewController.animateToPage(0,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              child: const Text('Поиск'),
            ),
            FilledButton(
              onFocusChange: (hasFocus) {
                pageViewController.animateToPage(1,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              onPressed: () {
                pageViewController.animateToPage(1,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              child: const Text('Сериалы'),
            ),
            FilledButton(
              onFocusChange: (hasFocus) {
                pageViewController.animateToPage(2,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              onPressed: () {
                pageViewController.animateToPage(2,
                    duration: kThemeAnimationDuration, curve: Curves.easeInOut);
              },
              child: const Text('Фильмы'),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageViewController,
        clipBehavior: Clip.none,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SearchPage(),
          ShowsPage(),
          MoviesPage(),
        ],
      ),
    );
  }
}
