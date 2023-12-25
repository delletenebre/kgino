import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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

  final bool autofocus;
  final FocusNode? focusNode;
  final double? listOffset;

  const VerticalListView({
    super.key,
    this.listObserverController,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    this.onFocusChange,
    this.requestItemIndex,
    this.separatorHeight = 24.0,
    this.autofocus = false,
    this.focusNode,
    this.listOffset,
  });

  @override
  State<VerticalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<VerticalListView> {
  //final itemScrollController = GroupedItemScrollController();
  late final ListObserverController observerController;

  final itemScrollController = ItemScrollController();
  final scrollOffsetController = ScrollOffsetController();
  final itemPositionsListener = ItemPositionsListener.create();
  final scrollOffsetListener = ScrollOffsetListener.create();

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
    itemScrollController.jumpTo(
      index: index,
      // isFixedHeight: false,
      // offset: (offset) => widget.listOffset ?? widget.padding.top,
      // padding: widget.padding,
    );
    requestFocus(index);
  }

  /// переход к последнему выделенному элементу без анимации
  void jumpToCurrent([int? index]) {
    jumpTo(index ?? lastFocusedItem);
  }

  /// плавный переход к элементу
  void animateTo(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
      alignment: 0,
      //alignment: widget.listOffset ?? widget.padding.top,
      // automaticAlignment: false,
    );
    // scrollOffsetController.animateScroll(
    //   offset: widget.listOffset ?? widget.padding.top,
    //   duration: kThemeAnimationDuration,
    // );
    // observerController.animateTo(
    //   index: index,
    //   isFixedHeight: false,
    //   offset: (offset) => widget.listOffset ?? widget.padding.top,
    //   duration: const Duration(milliseconds: 180),
    //   curve: Curves.easeIn,
    //   padding: widget.padding,
    // );
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
    useEffect(() {
      if (widget.autofocus) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          jumpToCurrent();
        });
      }
      return () {};
    }, []);

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
        }
        widget.onFocusChange?.call(hasFocus);
      },
      child: ScrollablePositionedList.builder(
        padding: widget.padding,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) => Focus(
          focusNode: focusNodeAt(index),
          child: widget.itemBuilder(context, index),
        ),
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
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
