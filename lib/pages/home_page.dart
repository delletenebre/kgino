import 'package:flutter/material.dart';

import '../ui/navigation_bar/krs_navigation_bar.dart';
import 'movies_page.dart';
import 'search_page.dart';
import 'shows_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageViewController = PageController(
    initialPage: 1,
  );

  int selectedPage = 1;

  @override
  void initState() {
    pageViewController.addListener(() {
      selectedPage = pageViewController.page!.toInt();
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: KrsNavigationBar(
        controller: pageViewController,
        selectedPage: selectedPage,
        onPageChanged: (page) {
          pageViewController.animateToPage(page,
              duration: kThemeAnimationDuration, curve: Curves.easeInOut);
        },
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
