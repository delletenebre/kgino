import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/navigation_provider.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final selectedTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);
    return PopScope(
      canPop: selectedTab != 0,
      onPopInvoked: (didPop) {
        if (selectedTab == 0) {
          tabsController.navigateBack();
        }
      },
      child: Scaffold(
        appBar: const KrsNavigationBar(),
        body: PageView(
          controller: tabsController.pageController,
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          // pageSnapping: false,
          children: tabsController.pages,
        ),
      ),
    );
  }
}
