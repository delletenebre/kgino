import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../ui/navigation_bar/krs_navigation_bar.dart';
import 'movies_page.dart';
import 'search_page.dart';
import 'shows_page.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context) {
    final pageViewController = usePageController(
      initialPage: 1,
    );

    final selectedPage = useState(1);

    return Scaffold(
      appBar: KrsNavigationBar(
        controller: pageViewController,
        selectedPage: selectedPage.value,
        onPageChanged: (page) {
          pageViewController.jumpToPage(
            page,
          );
        },
      ),
      body: PageView(
        controller: pageViewController,
        clipBehavior: Clip.none,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          selectedPage.value = page;
        },
        pageSnapping: false,
        children: const [
          SearchPage(),
          ShowsPage(),
          MoviesPage(),
        ],
      ),
    );
  }
}
