import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/navigation.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final tabsController = ref.read(navigationProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        if (tabsController.isSearchSelected) {
          tabsController.changePage(1);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: const KrsNavigationBar(),
        body: PageView(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          controller: tabsController.pageController,
          children: tabsController.pages,
        ),
      ),
    );
  }
}
