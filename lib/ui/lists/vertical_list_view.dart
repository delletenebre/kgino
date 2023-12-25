import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class VerticalListView extends StatefulHookWidget {
  final ListObserverController? listObserverController;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final void Function(bool hasFocus)? onFocusChange;

  final EdgeInsets padding;

  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  final double separatorHeight;

  const VerticalListView({
    super.key,
    this.listObserverController,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    this.onFocusChange,
    this.requestItemIndex,
    this.separatorHeight = 24.0,
  });

  @override
  State<VerticalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<VerticalListView> {
  late final ListObserverController observerController;

  List<FocusNode> focusNodes = [];
  int lastFocusedItem = 0;

  @override
  void initState() {
    observerController = widget.listObserverController ??
        ListObserverController(controller: ScrollController());
    focusNodes = List.generate(
      widget.itemCount,
      (index) => FocusNode(),
    );
    super.initState();
  }

  @override
  void dispose() {
    observerController.controller?.dispose();
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
      offset: (offset) => widget.padding.top,
      padding: widget.padding,
    );
    requestFocus(index);
  }

  /// переход к последнему выделенному элементу без анимации
  void jumpToCurrent([int? index]) {
    print('index: $index');
    jumpTo(index ?? lastFocusedItem);
  }

  /// плавный переход к элементу
  void animateTo(int index) {
    observerController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => widget.padding.top,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeIn,
      padding: widget.padding,
    );
    requestFocus(index);
  }

  /// плавный переход к последнему выделенному элементу
  void animateToCurrent() => animateTo(lastFocusedItem);

  void requestFocus(int index) {
    lastFocusedItem = index;
    focusNodeAt(index).children.firstOrNull?.requestFocus();
  }

  FocusNode focusNodeAt(int index) => focusNodes[index];

  @override
  Widget build(context) {
    return Focus(
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
        }
        widget.onFocusChange?.call(hasFocus);
      },
      child: ListViewObserver(
        controller: observerController,
        triggerOnObserveType: ObserverTriggerOnObserveType.directly,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.separated(
            controller: observerController.controller,
            padding: widget.padding,
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) =>
                SizedBox(height: widget.separatorHeight),
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              return Focus(
                focusNode: focusNodeAt(index),
                child: widget.itemBuilder(context, index),
              );
            },
          ),
        ),
      ),
    );
  }
}
