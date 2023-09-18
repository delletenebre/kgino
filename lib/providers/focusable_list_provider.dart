import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

part 'focusable_list_provider.g.dart';

@riverpod
class FocusableList extends _$FocusableList {
  final FocusNode generalFocusNode = FocusNode();
  final ListObserverController listObserverController = ListObserverController(
    controller: ScrollController(),
  );
  List<FocusNode> focusNodes = [];

  @override
  int build({
    Key? key,
    int itemCount = 0,
    double offset = 0.0,
    KeyEventResult keyEventResult = KeyEventResult.ignored,
  }) {
    List.generate(itemCount, (index) => focusNodes.add(FocusNode()));

    ref.onCancel(() {
      for (final focusNode in focusNodes) {
        focusNode.dispose();
      }

      generalFocusNode.dispose();
      listObserverController.controller?.dispose();

      debugPrint('FocusableList disposed');
    });

    return 0;
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (state > 0) {
      state--;
      animateToCurrent();
      return KeyEventResult.handled;
    }

    return keyEventResult;
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (state < focusNodes.length - 1) {
      state++;
      print('current state $state / ${focusNodes.length}');
      animateToCurrent();

      return KeyEventResult.handled;
    }

    return keyEventResult;
  }

  /// переход к текущему элементу без анимации
  void jumpToCurrent([int Function()? requestItemIndex]) {
    if (requestItemIndex != null) {
      state = requestItemIndex();
    }
    jumpTo(state);
  }

  void jumpTo(int index) {
    listObserverController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => this.offset,
    );
    requestFocus(index);
  }

  void megaJumpTo(int index) {
    listObserverController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => this.offset,
    );
    state = index;
    requestFocus(index);
  }

  void animateTo(int index) {
    listObserverController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => this.offset,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
      padding: EdgeInsets.all(offset),
    );
    requestFocus(index);
  }

  void animateToCurrent() {
    animateTo(state);
  }

  void requestFocus(int index) {
    focusNodeAt(index)?.children.firstOrNull?.requestFocus();
  }

  ScrollController? get scrollController => listObserverController.controller;

  FocusNode? focusNodeAt(int index) {
    return focusNodes.elementAtOrNull(state);
  }
}
