import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kgino/extensions/theme_data_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/filmix_api_provider.dart';
import '../api/rezka_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/images/online_service_logo.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

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

  // bool get hasItem => state.valueOrNull != null;
}

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final theme = Theme.of(context);

    final searchController = useTextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TvUi.hPadding,
            vertical: TvUi.vPadding,
          ),
          child: Focus(
            skipTraversal: true,
            onKey: (node, event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                FocusScope.of(context).previousFocus();
                return KeyEventResult.handled;
              }

              if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                FocusScope.of(context).nextFocus();
                return KeyEventResult.handled;
              }

              return KeyEventResult.ignored;
            },
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
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
            ),
          ),
        ),
        Expanded(
          child: HookBuilder(
            builder: (context) {
              useValueListenable(searchController);

              if (searchController.value.text.isEmpty) {
                return const SizedBox();
              }

              final controller =
                  ref.watch(searchProvider(searchController.value.text));

              /// если результаты загружаются
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = controller.valueOrNull ?? [];

              if (categories.isEmpty) {
                return const Center(
                  child: Text('По Вашему запросу ничего не найдено'),
                );
              }

              return VerticalListView(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                            KrsTheme.safeArea.horizontal,
                            0.0,
                            KrsTheme.safeArea.horizontal,
                            20.0,
                          ),
                          child: Row(
                            children: [
                              if (category.onlineService.logo.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: OnlineServiceLogo(
                                      category.onlineService.logo),
                                ),
                              Text(
                                category.title,
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: MediaItemCard.height,
                        child: HorizontalListView<MediaItem>(
                          // key: UniqueKey(),
                          // itemHeight: TvUi.horizontalCardSize.height,
                          // title: Text(category.title),
                          asyncItems: category.itemsFuture,
                          itemBuilder: (context, item) {
                            return MediaItemCard(
                              mediaItem: item,
                              onTap: () {
                                /// переходим на страницу деталей о сериале или фильме
                                context.pushNamed('details', extra: item);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
