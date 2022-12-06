import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'focusable_list_state.dart';

class FocusableListCubit extends Cubit<FocusableListState> {
  final ListObserverController? controller;
  late FocusableListState _currentState;
  final double offset;
  final KeyEventResult keyEventResult;

  FocusableListCubit({
    this.controller,
    required int itemCount,
    this.offset = 0.0,
    this.keyEventResult = KeyEventResult.ignored,
  }) : super(FocusableListState()) {
    final focusNodes = _generateFocusNodes(itemCount);
    _currentState = FocusableListState(
      controller: controller,
      focusNodes: focusNodes,
    );
    emit(_currentState);
  }

  @override
  Future<void> close() {
    for (final focusNode in _currentState.focusNodes) {
      focusNode.dispose();
    }
    state.scrollController?.dispose();

    return super.close();
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (state.focusableIndex > 0) {
      state.focusableIndex--;
      animateToCurrent();
      
      return KeyEventResult.handled;
    }

    return keyEventResult;
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (state.focusableIndex < state.focusNodes.length - 1) {
      state.focusableIndex++;
      animateToCurrent();

      return KeyEventResult.handled;
    }

    return keyEventResult;
  }


  List<FocusNode> _generateFocusNodes(int length) {
    return List.generate(length, (index) => FocusNode());
  }


  void jumpTo(int index) {
    state.listObserverController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => this.offset,
    );
    requestFocus(index);
  }

  /// переход к текущему элементу без анимации
  void jumpToCurrent(int Function()? requestItemIndex) {
    if (requestItemIndex != null) {
      state.focusableIndex = requestItemIndex();
    }
    jumpTo(state.focusableIndex);
  }

  void animateTo(int index) {
    state.listObserverController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => this.offset,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeIn
    );
    requestFocus(index);
  }

  void animateToCurrent() {
    animateTo(state.focusableIndex);
  }

  void requestFocus(int index) {
    state.focusNodes[index].requestFocus();
  }

  FocusNode focusNodeAt(int index) {
    return state.focusNodes[index];
  }

}