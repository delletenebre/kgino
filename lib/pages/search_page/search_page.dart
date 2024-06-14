import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api/filmix_api_provider.dart';
import '../../api/rezka_api_provider.dart';
import '../../api/tskg_api_provider.dart';
import '../../extensions/theme_data_extensions.dart';
import '../../models/category_list_item.dart';
import '../../models/media_item.dart';
import '../../providers/active_horizontal_list_provider.dart';
import '../../resources/kika_theme.dart';
import '../../ui/animated_loading.dart';
import '../../ui/cards/media_item_card.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/online_service_list_title.dart';
import '../../ui/lists/vertical_list_view.dart';

part 'search_page.g.dart';

@riverpod
class Search extends _$Search {
  @override
  Future<List<CategoryListItem>> build(String searchQuery) async {
    return fetch();
  }

  Future<List<CategoryListItem>> fetch() async {
    /// провайдер запросов к API hdrezka
    final rezkaApi = ref.read(rezkaApiProvider);
    final rezkaCancelToken = rezkaApi.getCancelToken();

    /// провайдер запросов к API filmix
    final filmixApi = ref.read(filmixApiProvider);
    final filmixCancelToken = filmixApi.getCancelToken();

    /// провайдер запросов к API tskg
    final tskgApi = ref.read(tskgApiProvider);
    final tskgCancelToken = tskgApi.getCancelToken();

    /// отменяем выполнение запроса, если страница закрыта
    ref.onDispose(() {
      rezkaCancelToken.cancel();
      filmixCancelToken.cancel();
      tskgCancelToken.cancel();
    });

    final rezkaResult = await rezkaApi.search(
      searchQuery: searchQuery,
      cancelToken: rezkaCancelToken,
    );

    /// результаты поиска filmix
    final filmixResult = await filmixApi.search(
      searchQuery: searchQuery,
      cancelToken: filmixCancelToken,
    );

    /// результаты поиска ts.kg
    final tskgResult = await tskgApi.search(
      searchQuery: searchQuery,
      cancelToken: tskgCancelToken,
    );

    /// формируем список найденного
    return [
      if (filmixResult.isNotEmpty)
        CategoryListItem(
          onlineService: OnlineService.filmix,
          title: 'Filmix',
          items: filmixResult,
        ),
      if (rezkaResult.isNotEmpty)
        CategoryListItem(
          onlineService: OnlineService.rezka,
          title: 'HDrezka',
          items: rezkaResult,
        ),
      if (tskgResult.isNotEmpty)
        CategoryListItem(
          onlineService: OnlineService.tskg,
          title: 'TS.KG',
          items: tskgResult,
        ),
    ];
  }

  bool get hasResults => (state.valueOrNull ?? []).isNotEmpty;
}

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final theme = Theme.of(context);

    final searchController = useTextEditingController();

    /// [FocusNode] для поля поиска
    final searchFieldFocusNode = useFocusNode();

    /// включено ли поле поиска для редактирования
    final canEdit = useState(false);

    /// включить поле поиска для редактирования
    bool enableEditing() {
      if (!canEdit.value) {
        canEdit.value = true;
      }

      return canEdit.value;
    }

    /// отключить поле поиска для редактирования
    bool disableEditing() {
      if (canEdit.value) {
        canEdit.value = false;
      }

      return !canEdit.value;
    }

    print('build');
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 56.0, left: 80.0 + 48.0, right: 48.0),
          child: Focus(
            canRequestFocus: false,
            skipTraversal: true,
            onKeyEvent: (node, event) {
              print('key event: $event');
              // if (HardwareKeyboard.instance
              //     .isLogicalKeyPressed(LogicalKeyboardKey.arrowUp)) {
              //   /// отключаем редактирование
              //   disableEditing();

              //   /// перемещаем фокус к предыдущему элементу
              //   FocusScope.of(context).previousFocus();
              //   return KeyEventResult.handled;
              // }
              if (HardwareKeyboard.instance
                  .isLogicalKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                if (!canEdit.value) {
                  ref.read(activeHorizontalListProvider.notifier).onMoveLeft();
                }

                return KeyEventResult.handled;
              } else if (HardwareKeyboard.instance
                  .isLogicalKeyPressed(LogicalKeyboardKey.arrowDown)) {
                /// отключаем редактирование
                disableEditing();

                if (ref
                    .read(searchProvider(searchController.value.text).notifier)
                    .hasResults) {
                  /// ^ если есть результаты поиска

                  /// перемещаем фокус к следующему элементу
                  searchFieldFocusNode
                      .focusInDirection(TraversalDirection.down);
                }

                return KeyEventResult.handled;
              } else if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.select ||
                  HardwareKeyboard.instance
                      .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
                // } else if (HardwareKeyboard.instance
                //         .isLogicalKeyPressed(LogicalKeyboardKey.select) ||
                //     HardwareKeyboard.instance
                //         .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {

                /// включаем редактирование
                if (enableEditing()) {
                  return KeyEventResult.handled;
                }
              } else if (HardwareKeyboard.instance
                  .isLogicalKeyPressed(LogicalKeyboardKey.escape)) {
                /// отключаем редактирование
                if (disableEditing()) {
                  return KeyEventResult.handled;
                }
              }

              return KeyEventResult.ignored;
            },
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                ref.read(activeHorizontalListProvider.notifier).updateIndex(0);
              } else if (!hasFocus && canEdit.value) {
                /// отключаем редактирование
                disableEditing();

                /// возвращаем фокус на поле поиска
                searchFieldFocusNode.requestFocus();
              }
            },
            child: TextField(
              focusNode: searchFieldFocusNode,
              readOnly: !canEdit.value,
              controller: searchController,
              textInputAction: TextInputAction.search,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Название фильма или сериала...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                  ),
                ),
                filled: true,
                fillColor: theme.surfaceContainerHighest,
              ),
              onChanged: (value) {},
              onSubmitted: (value) {
                /// отключаем редактирование
                disableEditing();

                /// возвращаем фокус на поле поиска
                ref
                    .read(searchProvider(searchController.value.text).notifier)
                    .fetch();
                // searchFieldFocusNode.focusInDirection(TraversalDirection.down);
              },
            ),
          ),
        ),
        const SizedBox(height: 24.0),

        /// результаты поиска
        HookBuilder(
          builder: (context) {
            useValueListenable(searchController);

            if (searchController.value.text.isEmpty) {
              return const SizedBox();
            }

            final controller =
                ref.watch(searchProvider(searchController.value.text));

            /// если результаты загружаются
            if (controller.isLoading) {
              return const AnimatedLoading(size: 96.0);
            }

            final categories = controller.valueOrNull ?? [];

            /// если по запросу нет результатов
            if (categories.isEmpty) {
              return const Center(
                child: Text('По Вашему запросу ничего не найдено'),
              );
            }

            return Expanded(
              child: VerticalListView(
                onMoveUp: () => searchFieldFocusNode.requestFocus(),
                itemHeight: kCardMaxHeight + kListTitleHeight,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return HorizontalListView<MediaItem>(
                    title: OnlineServiceListTitle(category),
                    asyncItems: category.itemsFuture,
                    itemBuilder: (context, index, item) {
                      return MediaItemCard(
                        mediaItem: item,
                        onPressed: () {
                          if (item.isFolder) {
                            /// переходим на страницу выбранного провайдера
                            context.pushNamed(item.id);
                          } else {
                            /// переходим на страницу деталей о фильме
                            context.pushNamed('details', extra: item);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
