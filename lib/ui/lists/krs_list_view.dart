import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KrsListView extends StatefulWidget {
  final bool autofocus;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? selectedItemBuilder;
  final AutoScrollController? autoScrollController;

  final List<FocusNode>? itemFocusNodes;

  /// при получении фокуса на элемент
  final void Function(int index)? onItemFocused;
  
  /// при получении фокуса на элемент с другого элемента приложения
  final void Function(int index)? onItemFocusedFirstTime;

  final void Function() onScrollEnd;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final String titleText;
  final bool scrollToLastPosition;


  const KrsListView({
    super.key,
    this.autofocus = false,
    this.itemFocusNodes,
    this.autoScrollController,
    required this.itemCount,
    required this.itemBuilder,
    this.selectedItemBuilder,
    this.onItemFocused,
    this.onItemFocusedFirstTime,
    required this.onScrollEnd,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.spacing = 32.0,
    this.titleText = '',
    this.scrollToLastPosition = true,

  });

  @override
  State<KrsListView> createState() => _KrsListViewState();
}

class _KrsListViewState extends State<KrsListView> {
  late final AutoScrollController _autoScrollController;

  bool _needToLoadMore = false;
  int _lastFocusedIndex = 0;
  bool _listHasFocus = false;

  final _listFocusNode = FocusNode();

  bool _focusRequestedByUser = true;

  @override
  void initState() {
    _autoScrollController = widget.autoScrollController ?? AutoScrollController(
      axis: Axis.horizontal,
      viewportBoundaryGetter: () => Rect.fromLTRB(
        widget.padding.horizontal / 2, 0.0, widget.padding.horizontal / 2, 0.0
      ),
    );

    _autoScrollController.addListener(() {
      if (!_autoScrollController.isAutoScrolling) {
        double maxScroll = _autoScrollController.position.maxScrollExtent;
        double currentScroll = _autoScrollController.position.pixels;
        double delta = 200.0;

        if (maxScroll - currentScroll <= delta) {
          if (!_needToLoadMore) {
            _needToLoadMore = true;
            widget.onScrollEnd();
          }
        } else {
          _needToLoadMore = false;
        }
      }
      
    });
    super.initState();
  }
  
  @override
  void dispose() {
    if (widget.autoScrollController == null) {
      /// ^ если контроллер прокрутки был создан этим виджетом, а не
      /// родительским
      
      /// освобождаем память
      _autoScrollController.dispose();
    }

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
        // if (hasFocus) {
        //   _scrollToLastIndex = true;
        // }
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
              child: ListView.separated(
                clipBehavior: Clip.none,
                controller: _autoScrollController,
                padding: widget.padding,
                scrollDirection: Axis.horizontal,
                itemCount: widget.itemCount,
                
                /// разделитель
                separatorBuilder: (context, index) {
                  return SizedBox(width: widget.spacing);
                },

                /// основной контент
                itemBuilder: (context, index) {
                  late Widget child;
                  if (index == _lastFocusedIndex && widget.selectedItemBuilder != null) {
                    child = widget.selectedItemBuilder!(context, index);
                  } else {
                    child = widget.itemBuilder(context, index);
                  }

                  return AutoScrollTag(
                    key: ValueKey(index), 
                    controller: _autoScrollController,
                    index: index,
                    child: Focus(
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
                          if (_focusRequestedByUser) {
                            /// ^ при получении фокуса
                            // _focusNodes[index].children.first.requestFocus();
                            int currentIndex = index;
                            
                            final firstTimeFocus = !_listHasFocus;

                            if (widget.scrollToLastPosition && firstTimeFocus) {
                              /// ^ если фокус был только что перемещён на список
                              
                              /// нужно прокрутить к последнему элементу, который
                              /// был в фокусе (на котором остановился
                              /// пользователь)
                              currentIndex = _lastFocusedIndex;

                              _focusRequestedByUser = false;
                              
                              /// обновляем индекс последнего элемента, на котором
                              /// был фокус
                              widget.itemFocusNodes?[currentIndex].requestFocus();
                            }
                            
                            /// небольшая задержка, когда происходит быстрая
                            /// прокрутка
                            Future.delayed(const Duration(milliseconds: 100), () {
                              if (mounted) {
                                /// ^ если виджет ещё жив
                                
                                /// прокручиваем контент к текущему элементу
                                _autoScrollController.scrollToIndex(currentIndex,
                                  preferPosition: AutoScrollPosition.begin,
                                  duration: const Duration(milliseconds: 50),
                                );

                                if (firstTimeFocus && widget.onItemFocusedFirstTime != null) {
                                  widget.onItemFocusedFirstTime?.call(currentIndex);
                                } else {
                                  /// вызываем пользовательский обработчик
                                  widget.onItemFocused?.call(currentIndex);
                                }

                                setState(() {
                                  _lastFocusedIndex = currentIndex;
                                });
                              }
                            });
                          } else {
                            _focusRequestedByUser = true;
                          }
                          
                        }
                        //print('item $index hasFocus: $hasFocus');
                      },
                      child: child,
                    ),
                  );
                },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
