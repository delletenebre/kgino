import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class KrsListView extends StatefulWidget {
  final ListObserverController? controller;
  // final bool autofocus;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? selectedItemBuilder;

  final List<FocusNode>? itemFocusNodes;

  /// при получении фокуса на элемент
  final void Function(int index)? onItemFocused;
  
  /// при получении фокуса на элемент с другого элемента приложения
  final void Function(int index)? onItemFocusedFirstTime;

  final void Function()? onLoadNextPage;
  final EdgeInsets padding;
  final double spacing;
  final String titleText;
  final bool scrollToLastPosition;
  final int Function()? requestItemIndex;

  const KrsListView({
    super.key,
    this.controller,
    // this.autofocus = false,
    this.itemFocusNodes,
    required this.itemCount,
    required this.itemBuilder,
    this.selectedItemBuilder,
    this.onItemFocused,
    this.onItemFocusedFirstTime,
    this.onLoadNextPage,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.spacing = 32.0,
    this.titleText = '',
    this.scrollToLastPosition = true,
    this.requestItemIndex,

  });

  @override
  State<KrsListView> createState() => _KrsListViewState();
}

class _KrsListViewState extends State<KrsListView> {
  late final ListObserverController _listObserverController;

  bool _needToLoadMore = false;
  int _lastFocusedIndex = 0;
  bool _listHasFocus = false;

  final _listFocusNode = FocusNode();

  @override
  void initState() {
    _listObserverController = widget.controller ?? ListObserverController(
      controller: ScrollController(),
    );
    super.initState();
  }
  
  @override
  void dispose() {
    _listFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      focusNode: _listFocusNode,
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        _listHasFocus = hasFocus;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText.isNotEmpty) Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              bottom: 24.0,
            ),
            child: Text(widget.titleText,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          
          Expanded(
            // child: RawScrollbar(
            //   thumbColor: theme.colorScheme.primary.withOpacity(0.5),
            //   controller: _autoScrollController,
            //   thickness: 2.0,
            //   radius: const Radius.circular(2.0),
            //   thumbVisibility: true,
            child: ListViewObserver(
              controller: _listObserverController,
              child: ListView.separated(
                clipBehavior: Clip.none,
                controller: _listObserverController.controller,
                padding: widget.padding,
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemCount,
                
                /// разделитель
                separatorBuilder: (context, index) {
                  return SizedBox(width: widget.spacing);
                },

                /// основной контент
                itemBuilder: (context, index) {
                  return Focus(
                    skipTraversal: true,
                    onKey: (node, event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)
                          && index == 0) {
                        /// ^ если нажата клавиша влево на первом элементе
                        
                        /// предотвращаем смещение фокуса на другие списки
                        return KeyEventResult.handled;
                      }

                      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)
                          && index == widget.itemCount - 1) {
                        /// ^ если нажата клавиша вправо на последнем элементе
                        
                        /// предотвращаем смещение фокуса на другие списки
                        return KeyEventResult.handled;
                      }

                      return KeyEventResult.ignored;
                    },
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        
                        int currentIndex = index;
                        
                        final firstTimeFocus = !_listHasFocus;

                        if (widget.scrollToLastPosition && firstTimeFocus) {
                          /// ^ если фокус был только что перемещён на список
                          
                          if (widget.requestItemIndex != null) {
                            _lastFocusedIndex = widget.requestItemIndex!();
                          }
                          
                          /// нужно прокрутить к последнему элементу, который
                          /// был в фокусе (на котором остановился
                          /// пользователь)
                          currentIndex = _lastFocusedIndex;

                          /// обновляем индекс последнего элемента, на котором
                          /// был фокус
                          widget.itemFocusNodes?[currentIndex].requestFocus();
                        }
                        
                        if (mounted) {
                          /// ^ если виджет ещё жив
                          
                          /// прокручиваем контент к текущему элементу
                          _listObserverController.animateTo(
                            index: currentIndex,
                            isFixedHeight: true,
                            offset: (offset) => 48.0,
                            duration: const Duration(milliseconds: 50),
                            curve: Curves.easeIn
                          );

                          if (firstTimeFocus
                              && widget.onItemFocusedFirstTime != null) {
                            widget.onItemFocusedFirstTime?.call(currentIndex);
                          } else {
                            /// вызываем пользовательский обработчик
                            widget.onItemFocused?.call(currentIndex);
                          }

                          if (currentIndex > widget.itemCount - 7) {
                            if (!_needToLoadMore) {
                              _needToLoadMore = true;
                              widget.onLoadNextPage?.call();
                            }
                          } else {
                            _needToLoadMore = false;
                          }
                          
                          setState(() {
                            _lastFocusedIndex = currentIndex;
                          });
                        }
                      }
                    },
                    child: widget.itemBuilder(context, index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
