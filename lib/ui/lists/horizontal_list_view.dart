import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../cards/media_item_card.dart';

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
  const HorizontalListView({
    super.key,
    required this.itemCount,
  });

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final scrollController = ScrollController();
  late final ListObserverController observerController;

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
  KeyEventResult goPrevious() {
    if (lastFocusedItem > 0) {
      lastFocusedItem--;
      animateToCurrent();
    }

    return KeyEventResult.handled;
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (lastFocusedItem < widget.itemCount - 1) {
      lastFocusedItem++;
      animateToCurrent();
    }

    return KeyEventResult.handled;
  }

  /// переход к текущему элементу без анимации
  void jumpToCurrent([int Function()? requestItemIndex]) {
    if (requestItemIndex != null) {
      lastFocusedItem = requestItemIndex();
    }
    jumpTo(lastFocusedItem);
  }

  void jumpTo(int index) {
    observerController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => 24.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
    );
    requestFocus(index);
  }

  void animateTo(int index) {
    observerController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => 24.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
    );
    requestFocus(index);
  }

  void animateToCurrent() {
    animateTo(lastFocusedItem);
  }

  void requestFocus(int index) {
    focusNodeAt(index).requestFocus();
  }

  FocusNode focusNodeAt(int index) => focusNodes[index];

  @override
  Widget build(context) {
    return Focus(
      // canRequestFocus: false,
      onKey: (node, event) {
        // if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
        //   FocusScope.of(context).previousFocus();
        // }
        // if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
        //   FocusScope.of(context).nextFocus();
        // }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          return goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          return goNext();
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
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemExtent: 240.0,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return MediaItemCard(
              focusNode: focusNodeAt(index),
              child: Text('index $index'),
            );
            return Focus.withExternalFocusNode(
              focusNode: focusNodeAt(index),
              // onFocusChange: (hasFocus) {
              //   // if (hasFocus) {
              //   //   lastFocusedItem = index;
              //   // }
              // },
              onFocusChange: (has) {
                print('hasFOPCCCCCC $has');
              },
              child: MediaItemCard(
                child: Text('index $index'),
              ),
            );
          },
        ),
      ),
    );
  }
}
