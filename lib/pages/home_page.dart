import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import '../controllers/tabs_cubit.dart';
import '../resources/krs_theme.dart';
import 'cameras_page.dart';
import 'movies_page.dart';
import 'search_page.dart';
import 'shows_page.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabsCubit = GetIt.instance<TabsCubit>();

    final pageController = usePageController(initialPage: tabsCubit.state);

    return BlocProvider(
      create: (_) => tabsCubit,
      child: BlocListener<TabsCubit, int>(
        listener: (context, selectedIndex) {
          pageController.animateToPage(selectedIndex,
            duration: KrsTheme.animationDuration,
            curve: Curves.easeIn,
          );

          // pageController.position = selectedIndex;
        },
        child: PageView(
          onPageChanged: (index) {
            tabsCubit.updateSelected(index);
          },
          controller: pageController,
          
          children: const [
            SearchPage(),
            MoviesPage(),
            ShowsPage(),
            CamerasPage(),
          ],
        ),
      ),
    );
  }
}