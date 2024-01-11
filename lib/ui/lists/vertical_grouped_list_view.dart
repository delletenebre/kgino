import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class VerticalGroupedListView extends StatefulHookWidget {
  final List<GroupedListViewItem> elements;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final void Function(bool hasFocus)? onFocusChange;

  final EdgeInsets padding;

  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  final double separatorHeight;

  final FocusNode? focusNode;

  const VerticalGroupedListView({
    super.key,
    required this.elements,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    this.onFocusChange,
    this.requestItemIndex,
    this.separatorHeight = 24.0,
    this.focusNode,
  });

  @override
  State<VerticalGroupedListView> createState() =>
      VerticalGroupedListViewState();
}

class VerticalGroupedListViewState extends State<VerticalGroupedListView> {
  final listKey = GlobalKey();
  final itemScrollController = GroupedItemScrollController();
  List<FocusNode> focusNodes = [];
  int lastFocusedItem = 0;

  @override
  void initState() {
    focusNodes = List.generate(
      widget.elements.length,
      (index) => FocusNode(),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (final focusNode in focusNodes) {
      focusNode
        ..unfocus()
        ..dispose();
    }
    super.dispose();
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (lastFocusedItem > 0) {
      lastFocusedItem--;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  }

  /// переходим к следующему элементу
  void goNext() {
    if (lastFocusedItem < widget.elements.length - 1) {
      lastFocusedItem++;
      animateToCurrent();
    }
  }

  /// переход к элементу без анимации
  void jumpTo(int index) {
    requestFocus(index);
    itemScrollController.jumpTo(
      index: index,
      alignment: pixelToAlignment,
    );
  }

  /// переход к последнему выделенному элементу без анимации
  void jumpToCurrent([int? index]) {
    jumpTo(index ?? lastFocusedItem);
  }

  /// плавный переход к элементу
  void animateTo(int index) {
    requestFocus(index);
    scrollTo(index);
  }

  void scrollTo(int index) {
    print('scroll TO $index');
    itemScrollController.scrollTo(
      index: index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
      alignment: pixelToAlignment,
    );
  }

  /// плавный переход к последнему выделенному элементу
  void animateToCurrent() => animateTo(lastFocusedItem);

  void requestFocus(int index) {
    lastFocusedItem = index;
    focusNodeAt(index).children.firstOrNull?.requestFocus();
  }

  FocusNode focusNodeAt(int index) => focusNodes[index];

  double get pixelToAlignment =>
      (widget.padding.top * 100 / listKey.currentContext!.size!.height) / 100;

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Focus(
      focusNode: widget.focusNode,
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          return goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          goNext();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          // jumpToCurrent();
          jumpToCurrent(widget.requestItemIndex?.call());
          //animateTo(widget.requestItemIndex?.call() ?? lastFocusedItem);
          // requestFocus(widget.requestItemIndex?.call() ?? lastFocusedItem);
        }
        widget.onFocusChange?.call(hasFocus);
      },
      child: ScrollConfiguration(
        key: listKey,
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: StickyGroupedListView<GroupedListViewItem, int>(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: widget.padding,
          elements: widget.elements,
          groupBy: (item) => item.groupIndex,
          groupSeparatorBuilder: (item) => SizedBox(),
          //     Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12.0),
          //   child: Text(
          //     item.group,
          //     style: const TextStyle(
          //       fontSize: 20.0,
          //     ),
          //   ),
          // ),
          indexedItemBuilder: (context, item, index) => Focus(
            focusNode: focusNodeAt(index),
            child: widget.itemBuilder(context, index),
          ),
          itemScrollController: itemScrollController,
          groupComparator: (e1, e2) => e1.compareTo(e2),
          elementIdentifier: (item) => item.index,
          stickyHeaderBackgroundColor: theme.colorScheme.surface,
          separator: SizedBox(height: widget.separatorHeight),
        ),
      ),
    );
  }
}

class GroupedListViewItem {
  final String group;
  final int groupIndex;

  final int index;

  GroupedListViewItem({
    required this.group,
    required this.groupIndex,
    required this.index,
  });
}
