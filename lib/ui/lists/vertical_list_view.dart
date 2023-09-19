import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../providers/focusable_list_provider.dart';
import '../../resources/constants.dart';

class VerticalListView extends ConsumerWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(bool hasFocus)? onFocusChange;
  final KeyEventResult keyEventResult;
  final ListObserverController? controller;

  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onFocusChange,
    this.keyEventResult = KeyEventResult.ignored,
    this.controller,
    this.requestItemIndex,
  });

  @override
  Widget build(context, ref) {
    final focusableListController = ref.read(focusableListProvider(
      key: key,
      itemCount: itemCount,
      keyEventResult: keyEventResult,
      controller: controller,
    ).notifier);

    ref.watch(focusableListProvider(
      key: key,
      itemCount: itemCount,
      keyEventResult: keyEventResult,
      controller: controller,
    ));

    return Focus(
      focusNode: focusableListController.generalFocusNode,
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          return focusableListController.goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          return focusableListController.goNext();
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          focusableListController.jumpToCurrent(requestItemIndex);
        }

        onFocusChange?.call(hasFocus);
      },
      child: ListViewObserver(
        controller: focusableListController.listObserverController,
        child: ListView.builder(
          clipBehavior: Clip.antiAlias,
          controller: focusableListController.scrollController,
          itemCount: itemCount,

          /// основной контент
          itemBuilder: (context, index) {
            return Focus(
              focusNode: focusableListController.focusNodes[index],
              child: Padding(
                padding: const EdgeInsets.only(bottom: TvUi.vPadding),
                child: itemBuilder(context, index),
              ),
            );
          },
        ),
      ),
    );
  }
}
