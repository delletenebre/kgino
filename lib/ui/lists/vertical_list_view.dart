import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerticalListView extends StatefulWidget {
  final double itemHeight;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function()? onMoveUp;

  const VerticalListView({
    super.key,
    required this.itemHeight,
    required this.itemCount,
    required this.itemBuilder,
    this.onMoveUp,
  });

  @override
  State<VerticalListView> createState() => VerticalListViewState();
}

class VerticalListViewState extends State<VerticalListView> {
  static const separatorHeight = 12.0;

  final _scrollController = ScrollController();
  int _selectedItemIndex = 0;
  bool _animationComplete = true;

  List<FocusNode> _focusNodes = [];

  void requestCurrentFocus() {
    _focusNodes[_selectedItemIndex].children.firstOrNull?.requestFocus();
  }

  double get calculatedScrollPosition {
    return _selectedItemIndex * (widget.itemHeight + separatorHeight);
  }

  void animateToCurrent() {
    final position = calculatedScrollPosition;
    _animationComplete = false;

    _scrollController.position
        .moveTo(
      position,
      duration: kThemeAnimationDuration,
      curve: Curves.fastOutSlowIn,
    )
        .then((value) {
      _animationComplete = true;
    });

    requestCurrentFocus();
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (_selectedItemIndex > 0) {
      _selectedItemIndex--;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      widget.onMoveUp?.call();
      return widget.onMoveUp != null
          ? KeyEventResult.handled
          : KeyEventResult.skipRemainingHandlers;
    }
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (_selectedItemIndex < widget.itemCount - 1) {
      _selectedItemIndex++;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.skipRemainingHandlers;
    }
  }

  @override
  void initState() {
    _focusNodes = List.generate(widget.itemCount, (index) => FocusNode());

    super.initState();
  }

  @override
  void dispose() {
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          requestLastFocused();
        }
      },
      onKeyEvent: (node, event) {
        if (!_animationComplete) {
          /// запрещаем действия, если анимация не выполнена
          return KeyEventResult.handled;
        }

        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.arrowUp)) {
          /// переходим к предыдущему элементу в списке
          return goPrevious();
        }

        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.arrowDown)) {
          /// переходим к следующему элементу в списке
          return goNext();
        }

        return KeyEventResult.ignored;
      },
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0.0, bottom: widget.itemHeight),
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemExtent: widget.itemHeight + separatorHeight,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return Focus(
            key: ValueKey(index),
            canRequestFocus: false,
            focusNode: _focusNodes[index],
            child: Padding(
              padding: const EdgeInsets.only(bottom: separatorHeight),
              child: widget.itemBuilder(context, index),
            ),
          );
        },
      ),
    );
  }

  void requestLastFocused() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNodes[_selectedItemIndex].children.firstOrNull?.requestFocus();
    });
  }
}
