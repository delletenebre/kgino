import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../resources/krs_theme.dart';

// @riverpod
// Object? focusNodes(ExampleRef ref) async {
//   // Wait for a user to be available, and listen to only the "firstName" property
//   final firstName = await ref.watch(
//     userProvider.selectAsync((it) => it.firstName),
//   );
//
//   // TODO use "firstName" to fetch something else
// }

class HorizontalListView extends StatefulHookWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final scrollController = ScrollController();
  late final ListObserverController observerController;

  final padding =
      EdgeInsets.symmetric(horizontal: KrsTheme.safeArea.horizontal);

  List<FocusNode> focusNodes = [];
  int lastFocusedItem = 0;

  @override
  void initState() {
    observerController = ListObserverController(controller: scrollController);
    focusNodes = List.generate(
      widget.itemCount,
      (index) => FocusNode(),
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// переходим к предыдущему элементу
  void goPrevious() {
    if (lastFocusedItem > 0) {
      lastFocusedItem--;
      animateToCurrent();
    }
  }

  /// переходим к следующему элементу
  void goNext() {
    if (lastFocusedItem < widget.itemCount - 1) {
      lastFocusedItem++;
      animateToCurrent();
    }
  }

  /// переход к элементу без анимации
  void jumpTo(int index) {
    observerController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => padding.left,
      padding: padding,
    );
    requestFocus(index);
  }

  /// переход к последнему выделенному элементу без анимации
  void jumpToCurrent() => jumpTo(lastFocusedItem);

  /// плавный переход к элементу
  void animateTo(int index) {
    requestFocus(index);
    observerController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => padding.left,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeIn,
      padding: padding,
    );
  }

  /// плавный переход к последнему выделенному элементу
  void animateToCurrent() => animateTo(lastFocusedItem);

  void requestFocus(int index) {
    focusNodeAt(index).children.firstOrNull?.requestFocus();
  }

  FocusNode focusNodeAt(int index) => focusNodes[index];

  @override
  Widget build(context) {
    return Focus(
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          goPrevious();
          return KeyEventResult.handled;
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          goNext();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          jumpToCurrent();
        }
      },
      child: ListViewObserver(
        controller: observerController,
        triggerOnObserveType: ObserverTriggerOnObserveType.directly,
        child: ListView.separated(
          controller: scrollController,
          padding: padding,
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 20.0),
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return Focus(
              focusNode: focusNodeAt(index),
              child: widget.itemBuilder(context, index),
            );
          },
        ),
      ),
    );
  }
}
