import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class KrsHorizontalListView2 extends StatefulWidget {
  final ListObserverController? controller;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

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

  const KrsHorizontalListView2({
    super.key,
    this.controller,
    this.itemFocusNodes,
    required this.itemCount,
    required this.itemBuilder,
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
  State<KrsHorizontalListView2> createState() => _KrsHorizontalListView2State();
}

class _KrsHorizontalListView2State extends State<KrsHorizontalListView2> {
  late final ListObserverController _listObserverController;

  bool _needToLoadMore = false;
  int _lastFocusedIndex = 0;
  bool _listHasFocus = false;

  late List<FocusNode> _itemFocusNodes;

  @override
  void initState() {
    _listObserverController = widget.controller ?? ListObserverController(
      controller: ScrollController(),
    );

    _itemFocusNodes = List.generate(widget.itemCount, (index) {
      return FocusNode();
    });

    super.initState();
  }
  
  @override
  void dispose() {
    for (final focusNode in _itemFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant KrsHorizontalListView2 oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      for (final focusNode in _itemFocusNodes) {
        focusNode.dispose();
      }

      _itemFocusNodes = List.generate(widget.itemCount, (index) {
        return FocusNode();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(context) {

    return Focus(
      canRequestFocus: false,
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
            //   //thumbColor: theme.colorScheme.primary.withOpacity(0.5),
            //   controller: _listObserverController.controller,
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
                    focusNode: _itemFocusNodes[index],
                    canRequestFocus: false,
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

                          try {
                            /// обновляем индекс последнего элемента, на котором
                            /// был фокус
                            for (final focusNode in _itemFocusNodes[currentIndex].descendants) {
                              if (focusNode.canRequestFocus) {
                                focusNode.requestFocus();
                              }
                            }
                          } catch (exception) {

                          }
                          
                          // _itemFocusNodes[currentIndex].descendants.first.requestFocus();
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

                          /// при быстрой перемотке, для экономии ресурсов,
                          /// немного тормозим вызов [onItemFocused], в котором
                          /// происходит загрузка дополнительных сведений
                          /// о сериале или фильме
                          Future.delayed(const Duration(milliseconds: 250), () {
                            if (currentIndex > widget.itemCount) {
                              currentIndex = widget.itemCount - 1;
                            }
                            if (mounted && _itemFocusNodes[currentIndex].hasFocus) {
                              if (firstTimeFocus
                                  && widget.onItemFocusedFirstTime != null) {
                                widget.onItemFocusedFirstTime?.call(currentIndex);
                              } else {
                                /// вызываем пользовательский обработчик
                                widget.onItemFocused?.call(currentIndex);
                              }
                            }
                          });
                          
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
