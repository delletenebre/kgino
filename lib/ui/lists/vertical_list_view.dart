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
  final Clip clipBehavior;

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
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(context, ref) {
    final provider = focusableListProvider(
      key: key,
      itemCount: itemCount,
      keyEventResult: keyEventResult,
      controller: controller,
    );
    final focusableListController = ref.read(provider.notifier);

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
        child: ScrollConfiguration(
          /// убираем scrollbar
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            clipBehavior: clipBehavior,
            padding: const EdgeInsets.only(bottom: TvUi.hPadding),
            controller: focusableListController.scrollController,
            itemCount: itemCount,

            /// основной контент
            itemBuilder: (context, index) {
              return Focus(
                focusNode: focusableListController.focusNodes[index],
                child: itemBuilder(context, index),
              );
            },
          ),
        ),
      ),
    );
  }
}
