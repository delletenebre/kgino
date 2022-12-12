import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../controllers/list_cubit/focusable_list_cubit.dart';
import '../../controllers/list_cubit/focusable_list_state.dart';

class KrsHorizontalListView extends StatefulWidget {
  final ListObserverController? controller;
  final int itemCount;
  final Widget Function(BuildContext context, FocusNode focusNode, int index) itemBuilder;

  final List<FocusNode>? itemFocusNodes;

  /// при получении фокуса на элемент
  final void Function(int index)? onItemFocused;

  final void Function()? onLoadNextPage;
  final EdgeInsets padding;
  final double spacing;
  final String titleText;
  final bool scrollToLastPosition;
  final int Function()? requestItemIndex;
  final FocusNode? focusNode;

  const KrsHorizontalListView({
    super.key,
    this.controller,
    this.itemFocusNodes,
    required this.itemCount,
    required this.itemBuilder,
    this.onItemFocused,
    this.onLoadNextPage,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.spacing = 24.0,
    this.titleText = '',
    this.scrollToLastPosition = true,
    this.requestItemIndex,
    this.focusNode,

  });

  @override
  State<KrsHorizontalListView> createState() => _KrsHorizontalListViewState();
}

class _KrsHorizontalListViewState extends State<KrsHorizontalListView> {
  bool _needToLoadMore = false;
  int _lastFocusedIndex = 0;

  late FocusNode _focusNode;

  @override
  void initState() {

    _focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }
  
  @override
  void dispose() {

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(context) {
    if (widget.itemCount == 0) {
      return const SizedBox();
    }

    return BlocProvider(
      key: ValueKey(widget.itemCount),
      create: (context) {
        return FocusableListCubit(
          controller: widget.controller,
          itemCount: widget.itemCount,
          offset: widget.padding.left,
          keyEventResult: KeyEventResult.handled,
        );
      },
      child: BlocBuilder<FocusableListCubit, FocusableListState>(
        builder: (context, focusableListState) {
          final listCubit = context.read<FocusableListCubit>();

          if (_lastFocusedIndex != focusableListState.focusableIndex) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(const Duration(milliseconds: 5), () {
                if (mounted) {
                  listCubit.jumpTo(_lastFocusedIndex);
                }
              });
            });
          }

          return Focus(
            focusNode: _focusNode,
            onKey: (node, event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                return listCubit.goPrevious();
              }

              if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                return listCubit.goNext();
              }

              return KeyEventResult.ignored;
            },
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                listCubit.jumpToCurrent(widget.requestItemIndex);
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
                    controller: focusableListState.listObserverController,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      controller: focusableListState.scrollController,
                      padding: widget.padding,
                      scrollDirection: Axis.horizontal,
                      itemCount: focusableListState.focusNodes.length,
                      
                      /// разделитель
                      separatorBuilder: (context, index) {
                        return SizedBox(width: widget.spacing);
                      },

                      /// основной контент
                      itemBuilder: (context, index) {
                        return Focus(
                          canRequestFocus: false,
                          skipTraversal: true,

                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              _lastFocusedIndex = index;

                              if (_lastFocusedIndex > widget.itemCount - 7) {
                                if (!_needToLoadMore) {
                                  _needToLoadMore = true;
                                  widget.onLoadNextPage?.call();
                                }
                              } else {
                                _needToLoadMore = false;
                              }

                              /// при быстрой перемотке, для экономии ресурсов,
                              /// немного тормозим вызов [onItemFocused],
                              /// в котором происходит загрузка дополнительных
                              /// сведений о сериале или фильме
                              Future.delayed(const Duration(milliseconds: 250), () {
                                if (mounted && focusableListState.focusableIndex == index) {
                                  /// ^ если виджет ещё жив
                                  
                                  /// вызываем пользовательский обработчик
                                  widget.onItemFocused?.call(index);

                                  
                                }
                              });
                            }
                          },
                          child: widget.itemBuilder(
                            context, listCubit.focusNodeAt(index), index),
                          
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
