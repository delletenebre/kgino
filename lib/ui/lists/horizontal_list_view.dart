import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'focusable_list_cubit/focusable_list_cubit.dart';
import 'focusable_list_cubit/focusable_list_state.dart';

class HorizontalListView<T> extends HookWidget {
  final ListObserverController? controller;

  final Future<List<T>>? itemsFuture;
  final Widget Function(BuildContext context, FocusNode focusNode, int index, T item) itemBuilder;

  /// функция загрузки следующей порции элементов
  final Future<List<T>> Function(int page, int loadedCount)? onLoadNextPage;
  
  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  /// используется при внешнем управлении (например, сезоны-эпизоды)
  final FocusNode? focusNode;

  /// название списка
  final String titleText;

  final double spacing;

  /// отступы списка
  final EdgeInsetsGeometry padding;

  final double height;

  const HorizontalListView({
    super.key,
    this.controller,
    this.itemsFuture,
    required this.itemBuilder,

    this.onLoadNextPage,
    this.requestItemIndex,
    this.focusNode,

    this.titleText = '',

    this.spacing = 24.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.height = 230.0,
  });

  @override
  Widget build(context) {
    /// текущая страница элементов (при динамической загрузке)
    final currentPage = useState(0);

    /// была ли достигнута последняя страница
    bool _lastPageReached = false;

    final _focusNodes = <FocusNode>[];
    
    /// текущий элемент, на котором фокус
    final currentFocusableIndex = useState(0);

    final asyncItems = useMemoized(() => itemsFuture);
    final snapshot = useFuture(asyncItems);

    if (!snapshot.hasData && !snapshot.hasError) {
      return const LinearProgressIndicator();
    }

    final items = snapshot.data!;
    final itemCount = items.length;

    return SizedBox(
      height: height,
      child: BlocProvider(
        key: ValueKey(itemCount),
        create: (context) => FocusableListCubit(
          controller: controller,
          itemCount: itemCount,
          offset: padding.horizontal / 2.0,
          /// при окончании списка, при дальнейшем нажатии влево/вправо чтобы
          /// фокус не переходил на следующий список, ставим handled
          keyEventResult: KeyEventResult.handled,
        ),

        child: BlocBuilder<FocusableListCubit, FocusableListState>(
          builder: (context, focusableListState) {
            final listCubit = context.read<FocusableListCubit>();

            return Focus(
              focusNode: focusNode,
              skipTraversal: true,

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
                //onFocusChange?.call(hasFocus);

                if (hasFocus) {
                  listCubit.jumpToCurrent(requestItemIndex);
                }
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleText.isNotEmpty) Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: padding.horizontal / 2.0,
                      end: padding.horizontal / 2.0,
                      bottom: 24.0,
                    ),
                    child: Text(titleText,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  
                  Expanded(
                    child: ListViewObserver(
                      controller: focusableListState.listObserverController,
                      child: ListView.separated(
                        padding: padding,
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        controller: focusableListState.scrollController,
                        itemCount: itemCount,

                        /// разделитель
                        separatorBuilder: (context, index) {
                          return SizedBox(width: spacing);
                        },

                        /// основной контент
                        itemBuilder: (context, index) {
                          return Focus(
                            canRequestFocus: false,
                            skipTraversal: true,

                            onFocusChange: (hasFocus) async {
                              if (hasFocus) {
                                if (!_lastPageReached && index > items.length - 7) {
                                  final items = await onLoadNextPage?.call(currentPage.value++, itemCount) ?? [];
                                  //_updateListItems(items);
                                  if (items.isEmpty) {
                                    _lastPageReached = true;
                                  }
                                }
                                
                                /// при быстрой перемотке, для экономии ресурсов,
                                /// немного тормозим вызов [onItemFocused],
                                /// в котором происходит загрузка дополнительных
                                /// сведений о сериале или фильме
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  if (currentFocusableIndex.value == index) {
                                    /// ^ если виджет ещё жив
                                    
                                    /// вызываем пользовательский обработчик
                                    //onItemFocused?.call(items[index]);
                                    
                                  }
                                });
                              }
                            },
                            
                            child: itemBuilder(
                              context, listCubit.focusNodeAt(index), index, items[index]),
                            
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
      ),
    );
  }
}
