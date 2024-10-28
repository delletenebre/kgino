import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/media_item.dart';
import '../../providers/active_horizontal_list_provider.dart';
import '../../resources/kika_theme.dart';
import '../loading.dart';
import '../navigation/kika_navigation_rail.dart';

class HorizontalListView<T> extends StatefulHookConsumerWidget {
  final double itemWidth;
  final double itemHeight;
  final Widget? title;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final void Function()? onMoveLeft;
  final void Function()? onMoveEnd;
  final void Function(int index)? onStartMoveTo;
  final FutureOr<List<T>>? asyncItems;
  final bool hasNavigationBar;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<bool>? onFocusChange;

  const HorizontalListView({
    super.key,
    this.itemWidth = 196.0,
    this.itemHeight = kCardMaxHeight,
    required this.itemBuilder,
    this.onMoveLeft,
    this.onMoveEnd,
    this.onStartMoveTo,
    this.asyncItems,
    this.title,
    this.hasNavigationBar = true,
    this.padding,
    this.onFocusChange,
  });

  @override
  createState() => HorizontalListViewState<T>();
}

class HorizontalListViewState<T> extends ConsumerState<HorizontalListView<T>> {
  final _scrollController = ScrollController();
  int _selectedItemIndex = 0;
  bool _animationComplete = true;
  bool _focused = false;

  List<FocusNode> _focusNodes = [];

  int _itemCount = 0;

  double get calculatedScrollPosition {
    final position = max(0.0, _selectedItemIndex * (widget.itemWidth + 20.0));

    return min(position, _scrollController.position.maxScrollExtent);
  }

  void requestCurrentFocus() {
    _focusNodes[_selectedItemIndex].children.firstOrNull?.requestFocus();
  }

  void animateToCurrent({bool requestFocus = true}) {
    widget.onStartMoveTo?.call(_selectedItemIndex);

    if (widget.hasNavigationBar) {
      ref
          .read(activeHorizontalListProvider.notifier)
          .updateIndex(_selectedItemIndex);
    }

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

      if (requestFocus) {
        requestCurrentFocus();
      }
    });
  }

  void scrollTo(int index, {bool requestFocus = true}) {
    _selectedItemIndex = index;
    animateToCurrent(requestFocus: requestFocus);
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (_selectedItemIndex > 0) {
      _selectedItemIndex--;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      if (widget.hasNavigationBar) {
        ref.read(activeHorizontalListProvider.notifier).onMoveLeft();
      }
      widget.onMoveLeft?.call();
      return widget.onMoveLeft != null
          ? KeyEventResult.handled
          : KeyEventResult.skipRemainingHandlers;
    }
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (_selectedItemIndex < _itemCount - 1) {
      _selectedItemIndex++;
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      widget.onMoveEnd?.call();
      return widget.onMoveEnd != null
          ? KeyEventResult.handled
          : KeyEventResult.skipRemainingHandlers;
    }
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
    final theme = Theme.of(context);

    final horizontalPadding = widget.padding ??
        const EdgeInsets.only(
            left: KikaNavigationRailState.minWidth + 48.0, right: 48.0);

    final asyncItemsReader = useMemoized(() async => widget.asyncItems);
    final snapshot = useFuture(asyncItemsReader);

    return BackButtonListener(
      onBackButtonPressed: () async {
        if (_focused && _selectedItemIndex > 0) {
          _selectedItemIndex = 0;
          animateToCurrent();
          return true;
        }

        return false;
      },
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            animateToCurrent();
          }

          setState(() {
            _focused = hasFocus;
          });

          widget.onFocusChange?.call(hasFocus);
        },
        onKeyEvent: (node, event) {
          if (!_animationComplete) {
            /// запрещаем действия, если анимация не выполнена
            return KeyEventResult.handled;
          }

          if (HardwareKeyboard.instance
              .isLogicalKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            /// переходим к предыдущему элементу в списке
            goPrevious();
            return KeyEventResult.handled;
          }

          if (HardwareKeyboard.instance
              .isLogicalKeyPressed(LogicalKeyboardKey.arrowRight)) {
            /// переходим к следующему элементу в списке
            goNext();
            return KeyEventResult.handled;
          }

          return KeyEventResult.ignored;
        },
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: _focused ? 1.0 : 0.36,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null)
                SizedBox(
                  height: kListTitleHeight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: horizontalPadding,
                      child: AnimatedDefaultTextStyle(
                        duration: kThemeAnimationDuration,
                        style: TextStyle(
                          fontSize: _focused ? 24.0 : 18.0,
                          color: theme.colorScheme.onSurface,
                        ),
                        child: widget.title!,
                      ),
                    ),
                  ),
                ),
              Builder(
                builder: (context) {
                  if (!snapshot.hasData && !snapshot.hasError) {
                    return SizedBox(
                      height: widget.itemHeight,
                      child: ListView(
                        padding: horizontalPadding,
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        children: const [
                          Loading(),
                        ],
                      ),
                    );
                  }

                  List<T> items = snapshot.data ?? [];

                  // if (items.isEmpty) {
                  //   items = [MediaItem(type: MediaItemType.error) as T];
                  // }

                  _itemCount = items.length;
                  _focusNodes =
                      List.generate(_itemCount, (index) => FocusNode());

                  return SizedBox(
                    height: widget.itemHeight,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: horizontalPadding,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _itemCount,
                      itemBuilder: (context, index) {
                        return Focus(
                          key: ValueKey(index),
                          canRequestFocus: false,
                          focusNode: _focusNodes[index],
                          child:
                              widget.itemBuilder(context, index, items[index]),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20.0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
