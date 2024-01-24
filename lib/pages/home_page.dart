import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/navigation_provider.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final selectedTab = ref.watch(navigationProvider);
    final tabsController = ref.read(navigationProvider.notifier);

    final focusNode = useFocusNode();

    return PopScope(
      canPop: selectedTab != 0,
      onPopInvoked: (didPop) {
        if (selectedTab == 0) {
          tabsController.navigateBack();
        }
      },
      child: Scaffold(
        appBar: KrsNavigationBar(
          onKeyDown: () {
            FocusNode lastElement = tabsController.focusNode.descendants.last;
            lastElement.requestFocus();
            lastElement
              ..nextFocus()
              ..nextFocus();
          },
        ),
        body: Focus(
          focusNode: focusNode,
          child: PageView(
            controller: tabsController.pageController,
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            // pageSnapping: false,
            children: tabsController.pages,
          ),
        ),
      ),
    );
  }
}
