import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../resources/constants.dart';
import '../../providers/focusable_list_provider.dart';

class HorizontalListView<T> extends HookConsumerWidget {
  final ListObserverController? controller;
  final Future<List<T>>? asyncItems;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  /// функция загрузки следующей порции элементов
  final Future<List<T>> Function(int page, int loadedCount)? onLoadNextPage;

  /// запрос индекса для смены фокуса
  /// (при внешнем управлении, например, сезоны-эпизоды)
  final int Function()? requestItemIndex;

  /// используется при внешнем управлении (например, сезоны-эпизоды)
  // final FocusNode? focusNode;

  /// название списка
  final Widget? title;

  final double spacing;

  /// отступы списка
  final EdgeInsetsGeometry padding;

  final double itemHeight;

  final void Function(bool)? onFocusChange;

  const HorizontalListView({
    super.key,
    this.controller,
    this.asyncItems,
    required this.itemBuilder,
    this.onLoadNextPage,
    this.requestItemIndex,
    // this.focusNode,
    this.title,
    this.spacing = TvUi.columnSpacing,
    this.padding = const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
    required this.itemHeight,
    this.onFocusChange,
  });

  @override
  Widget build(context, ref) {
    /// текущая страница элементов (при динамической загрузке)
    final currentPage = useState(1);

    /// была ли достигнута последняя страница
    bool lastPageReached = false;

    final asyncItemsReader = useMemoized(() => asyncItems);
    final snapshot = useFuture(asyncItemsReader);

    if (!snapshot.hasData && !snapshot.hasError) {
      return const LinearProgressIndicator();
    }

    List<T> items = snapshot.data!;
    final itemCount = useState(items.length);

    final pageLoading = useState(false);
    final currentItemIndex = useState(0);
    final needUpdateFocus = useState(false);

    if (items.isEmpty) {
      return const SizedBox();
    }

    final provider = focusableListProvider(
      key: key,
      itemCount: itemCount.value,
      offset: TvUi.hPadding,

      /// при окончании списка, при дальнейшем нажатии влево/вправо чтобы
      /// фокус не переходил на следующий список, ставим handled
      keyEventResult: KeyEventResult.handled,
    );
    final activeIndex = ref.watch(provider);
    final focusableListController = ref.read(provider.notifier);

    if (needUpdateFocus.value) {
      Future.microtask(() {
        //focusableListController.megaJumpTo(currentItemIndex.value);
        needUpdateFocus.value = false;
      });
    }

    final focused = useState(false);

    return Focus(
      focusNode: focusableListController.focusNode,
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          return focusableListController.goPrevious();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          return focusableListController.goNext();
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;

        if (hasFocus) {
          focusableListController.animateToCurrent();
        }

        onFocusChange?.call(hasFocus);
      },
      child: AnimatedOpacity(
        duration: kThemeAnimationDuration,
        opacity: focused.value ? 1.0 : 0.36,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 16.0,
              ),
              child: Container(
                height: TvUi.cardListTitleHeight,
                padding: EdgeInsetsDirectional.only(
                  start: padding.horizontal / 2,
                  end: padding.horizontal / 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: title,
                ),
              ),
            ),
            SizedBox(
              height: itemHeight,
              child: ListViewObserver(
                controller: focusableListController.listObserverController,
                child: ListView.separated(
                  padding: padding,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  controller: focusableListController.scrollController,
                  itemCount: itemCount.value,

                  /// разделитель
                  separatorBuilder: (context, index) {
                    return SizedBox(width: spacing);
                  },

                  /// основной контент
                  itemBuilder: (context, index) {
                    return Focus(
                      focusNode: focusableListController.focusNodes[index],
                      canRequestFocus: true,
                      onFocusChange: (hasFocus) async {
                        if (hasFocus) {
                          if (!pageLoading.value &&
                              !lastPageReached &&
                              index > itemCount.value - 7) {
                            pageLoading.value = true;
                            currentPage.value++;
                            final newItems = await onLoadNextPage?.call(
                                    currentPage.value, itemCount.value) ??
                                [];
                            if (newItems.isEmpty) {
                              lastPageReached = true;
                            } else {
                              items.addAll(newItems);
                              currentItemIndex.value = activeIndex;
                              //itemCount = items.length;
                              needUpdateFocus.value = true;
                            }
                            pageLoading.value = false;
                          }

                          /// при быстрой перемотке, для экономии ресурсов,
                          /// немного тормозим вызов [onItemFocused],
                          /// в котором происходит загрузка дополнительных
                          /// сведений о сериале или фильме
                          // Future.delayed(const Duration(milliseconds: 100), () {
                          //   if (currentFocusableIndex.value == index) {
                          //     /// ^ если виджет ещё жив

                          //     /// вызываем пользовательский обработчик
                          //     //onItemFocused?.call(items[index]);
                          //   }
                          // });
                        }
                      },
                      child: itemBuilder(
                        context,
                        index,
                        items[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
