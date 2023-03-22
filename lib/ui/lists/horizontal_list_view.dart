import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'focusable_list_cubit/focusable_list_cubit.dart';
import 'focusable_list_cubit/focusable_list_state.dart';

class HorizontalListView<T> extends HookWidget {
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

  const HorizontalListView({
    super.key,
    this.itemsFuture,
    required this.itemBuilder,

    this.onLoadNextPage,
    this.requestItemIndex,
    this.focusNode,

    this.titleText = '',
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

    /// контроллер прокрутки списка
    late final ListObserverController _listObserverController;

    final asyncItems = useMemoized(() => itemsFuture);
    final snapshot = useFuture(asyncItems);

    if (!snapshot.hasData && !snapshot.hasError) {
      return LinearProgressIndicator();
    }

    final items = snapshot.data!;
    final itemCount = items.length;

    return SizedBox(
      height: 200,
      child: BlocProvider(
        key: ValueKey(itemCount),
        create: (context) => FocusableListCubit(
          itemCount: itemCount,
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
                    padding: const EdgeInsetsDirectional.only(
                      start: 32.0,
                      end: 32.0,
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.antiAlias,
                        controller: focusableListState.scrollController,
                        itemCount: itemCount,

                        /// основной контент
                        itemBuilder: (context, index) {
                          return Focus(
                            canRequestFocus: false,
                            skipTraversal: true,

                            onFocusChange: (hasFocus) async {
                              print('onFocusChange $index');
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
