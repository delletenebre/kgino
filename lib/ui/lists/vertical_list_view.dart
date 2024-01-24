import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class VerticalListView extends StatefulHookWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  final void Function(bool hasFocus)? onFocusChange;

  final EdgeInsets padding;

  final double separatorHeight;

  final double? listOffset;

  final Clip clipBehavior;

  final void Function()? onMoveUp;

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.onFocusChange,
    this.separatorHeight = 20.0,
    this.listOffset,
    this.clipBehavior = Clip.hardEdge,
    this.onMoveUp,
  });

  @override
  State<VerticalListView> createState() => VerticalListViewState();
}

class VerticalListViewState extends State<VerticalListView> {
  final listKey = GlobalKey();
  final observerController =
      ListObserverController(controller: ScrollController());
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
    observerController.controller?.dispose();
    super.dispose();
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (lastFocusedItem > 0) {
      lastFocusedItem--;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      widget.onMoveUp?.call();
      return widget.onMoveUp != null
          ? KeyEventResult.handled
          : KeyEventResult.ignored;
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
    observerController.jumpTo(
      index: index,
      offset: (offset) => widget.padding.top,
      padding: widget.padding,
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
    observerController.animateTo(
      index: index,
      offset: (offset) => widget.padding.top,
      padding: widget.padding,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
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
        child: ListViewObserver(
          key: listKey,
          controller: observerController,
          child: ListView.separated(
            controller: observerController.controller,
            clipBehavior: widget.clipBehavior,
            scrollDirection: Axis.vertical,
            padding: widget.padding,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) => Focus(
              focusNode: focusNodeAt(index),
              child: widget.itemBuilder(context, index),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: widget.separatorHeight),
          ),
        ),
      ),
    );
  }
}
