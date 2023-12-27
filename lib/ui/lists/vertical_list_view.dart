import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class VerticalListView extends StatefulHookWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final void Function(bool hasFocus)? onFocusChange;

  final EdgeInsets padding;

  final double separatorHeight;

  final double? listOffset;

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.onFocusChange,
    this.separatorHeight = 20.0,
    this.listOffset,
  });

  @override
  State<VerticalListView> createState() => VerticalListViewState();
}

class VerticalListViewState extends State<VerticalListView> {
  final listKey = GlobalKey();
  final itemScrollController = ItemScrollController();
  List<FocusNode> focusNodes = [];
  int lastFocusedItem = 0;

  @override
  void initState() {
    focusNodes = List.generate(
      widget.itemCount,
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
  KeyEventResult goNext() {
    if (lastFocusedItem < widget.itemCount - 1) {
      lastFocusedItem++;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
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
  void jumpToCurrent() {
    jumpTo(lastFocusedItem);
  }

  /// плавный переход к элементу
  void animateTo(int index) {
    requestFocus(index);
    scrollTo(index);
  }

  /// плавный переход к элементу
  void scrollTo(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
      alignment: pixelToAlignment,
    );
    lastFocusedItem = index;
  }

  /// плавный переход к последнему выделенному элементу
  void animateToCurrent() => animateTo(lastFocusedItem);

  void requestFocus(int index) {
    lastFocusedItem = index;
    focusNodeAt(index).children.firstOrNull?.requestFocus();
  }

  FocusNode focusNodeAt(int index) => focusNodes[index];

  double get pixelToAlignment =>
      (widget.padding.top * 100 / listKey.currentContext!.size!.width) / 100;

  @override
  Widget build(context) {
    return Focus(
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          return goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          return goNext();
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          jumpToCurrent();
        }
        widget.onFocusChange?.call(hasFocus);
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ScrollablePositionedList.separated(
          key: listKey,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: widget.padding,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) => Focus(
            focusNode: focusNodeAt(index),
            child: widget.itemBuilder(context, index),
          ),
          separatorBuilder: (context, index) =>
              SizedBox(height: widget.separatorHeight),
          itemScrollController: itemScrollController,
        ),
      ),
    );
    //   child: StickyGroupedListView<dynamic, String>(
    //     elements: List.generate(
    //         widget.itemCount,
    //         (index) => {
    //               'group': 'zzzz',
    //               'index': index,
    //             }),
    //     groupBy: (element) => element['group'],
    //     groupSeparatorBuilder: (dynamic element) => SizedBox(),
    //     itemBuilder: (context, element) {
    //       return Focus(
    //         focusNode: focusNodeAt(element['index']),
    //         child: widget.itemBuilder(context, element['index']),
    //       );
    //     },
    //     // itemComparator: (e1, e2) =>
    //     //     e1['name'].compareTo(e2['name']),
    //     //elementIdentifier: (element) => element.name,
    //     itemScrollController: itemScrollController,
    //     order: StickyGroupedListOrder.ASC,
    //   ),
    // );
  }
}
