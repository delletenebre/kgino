import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgino/ui/loading_indicator.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class KrsHorizontalListView<T> extends StatefulWidget {
  final ListObserverController? controller;
  final List<T> items;
  final Future<List<T>>? itemsFuture;
  final Widget Function(BuildContext context, FocusNode focusNode, int index, T item) itemBuilder;

  /// при получении фокуса на элемент
  final void Function(T item)? onItemFocused;

  /// функция загрузки следующей порции элементов
  final Future<List<T>> Function(int page, int loadedCount)? onLoadNextPage;
  

  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  /// используется при внешнем управлении (например, сезоны-эпизоды)
  final FocusNode? focusNode;

  /// название списка
  final String titleText;

  final EdgeInsets padding;
  final double spacing;
  
  const KrsHorizontalListView({
    super.key,
    this.controller,
    this.items = const [],
    this.itemsFuture,
    required this.itemBuilder,

    this.onItemFocused,
    this.onLoadNextPage,
    this.requestItemIndex,
    this.focusNode,

    this.titleText = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.spacing = 24.0,
  });

  @override
  State<KrsHorizontalListView<T>> createState() => _KrsHorizontalListViewState<T>();
}

class _KrsHorizontalListViewState<T> extends State<KrsHorizontalListView<T>> {
  /// текущая страница элементов (при динамической загрузке)
  int _currentPage = 0;
  /// была ли достигнута последняя страница
  bool _lastPageReached = false;
  final _items = <T>[];
  final _focusNodes = <FocusNode>[];
  
  /// текущий элемент, на котором фокус
  int _currentFocusableIndex = 0;

  /// контроллер прокрутки списка
  late final ListObserverController _listObserverController;

  late FocusNode _focusNode;

  @override
  void initState() {
    _listObserverController = widget.controller ?? ListObserverController(
      controller: ScrollController(),
    );

    if (widget.items.isEmpty) {
      widget.onLoadNextPage?.call(0, 0).then((items) {
        _updateListItems(items);
      });
      widget.itemsFuture?.then((items) {
        _updateListItems(items);
      });
    } else {
      /// изначальные элементы списка
      _updateListItems(widget.items);
    }
    

    _focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }
  
  @override
  void dispose() {

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  List<FocusNode> _generateFocusNodes(int length) {
    return List.generate(length, (index) => FocusNode());
  }

  void _updateListItems(List<T> items) {
    if (mounted && items.isNotEmpty) {
      /// добавляем новые элементы списка
      _items.addAll(items);
      /// добавляем список [FocusNode] для новых элементов списка
      _focusNodes.addAll(_generateFocusNodes(items.length));

      setState(() {
        
      });
    }
  }

  @override
  Widget build(context) {
    if (_items.isEmpty && widget.itemsFuture != null) {
      return const LoadingIndicator();
    }

    return Focus(
      focusNode: _focusNode,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          // if (_awaitingToLoadMore) {
          //   return KeyEventResult.handled;
          // }
          return goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          // if (_awaitingToLoadMore) {
          //   return KeyEventResult.handled;
          // }
          return goNext();
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          jumpToCurrent(widget.requestItemIndex);
        }
      },
      skipTraversal: true,
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
                itemCount: _items.length,
                
                /// разделитель
                separatorBuilder: (context, index) {
                  return SizedBox(width: widget.spacing);
                },

                /// основной контент
                itemBuilder: (context, index) {
                  return Focus(
                    canRequestFocus: false,
                    skipTraversal: true,

                    onFocusChange: (hasFocus) async {
                      if (hasFocus) {
                        if (!_lastPageReached && index > _items.length - 7) {
                          final items = await widget.onLoadNextPage?.call(_currentPage++, _items.length) ?? [];
                          _updateListItems(items);
                          if (items.isEmpty) {
                            _lastPageReached = true;
                          }
                        }
                        
                        /// при быстрой перемотке, для экономии ресурсов,
                        /// немного тормозим вызов [onItemFocused],
                        /// в котором происходит загрузка дополнительных
                        /// сведений о сериале или фильме
                        Future.delayed(const Duration(milliseconds: 100), () {
                          if (mounted && _currentFocusableIndex == index) {
                            /// ^ если виджет ещё жив
                            
                            /// вызываем пользовательский обработчик
                            widget.onItemFocused?.call(_items[index]);
                            
                          }
                        });
                      }
                    },
                    child: widget.itemBuilder(
                      context, focusNodeAt(index), index, _items[index]),
                    
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }




  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (_currentFocusableIndex > 0) {
      _currentFocusableIndex--;
      animateToCurrent();
    }

    return KeyEventResult.handled;
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    if (_currentFocusableIndex < _items.length - 1) {
      _currentFocusableIndex++;
      animateToCurrent();
    }

    return KeyEventResult.handled;
  }

  /// переход к текущему элементу без анимации
  void jumpToCurrent(int Function()? requestItemIndex) {
    if (requestItemIndex != null) {
      _currentFocusableIndex = requestItemIndex();
    }
    jumpTo(_currentFocusableIndex);
  }

  void jumpTo(int index) {
    _listObserverController.jumpTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => widget.padding.left,
    );
    requestFocus(index);
  }

  void animateTo(int index) {
    _listObserverController.animateTo(
      index: index,
      isFixedHeight: true,
      offset: (offset) => widget.padding.left,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeIn
    );
    requestFocus(index);
  }

  void animateToCurrent() {
    animateTo(_currentFocusableIndex);
  }

  void requestFocus(int index) {
    focusNodeAt(index).requestFocus();
  }

  FocusNode focusNodeAt(int index) {
    return _focusNodes[index];
  }


}
