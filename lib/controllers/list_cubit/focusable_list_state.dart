import 'package:flutter/widgets.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class FocusableListState {
  // TODO dispose it somehow
  final List<FocusNode> focusNodes;
  late final ListObserverController listObserverController;
  ScrollController? get scrollController => listObserverController.controller;

  int focusableIndex;

  FocusableListState({
    this.focusNodes = const [],
    this.focusableIndex = 0,
  }) {
    listObserverController = ListObserverController(
      controller: ScrollController(),
    );
  }

}