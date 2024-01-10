import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    /// провайдер запросов к API filmix
    final filmixApi = ref.read(filmixApiProvider);

    /// провайдер запросов к API tskg
    final tskgApi = ref.read(tskgApiProvider);

    final searchController = useTextEditingController();
    useValueListenable(searchController);

    final categoriesFuture = useFuture(useMemoized(() async {
      final filmixResult = await filmixApi.search(
        searchQuery: searchController.text,
        cancelToken: filmixApi.getCancelToken(),
      );
      final tskgResult = await tskgApi.search(
        searchQuery: searchController.text,
        cancelToken: tskgApi.getCancelToken(),
      );

      /// формируем список найденного
      return [
        if (filmixResult.isNotEmpty)
          CategoryListItem(
            title: 'Filmix',
            items: filmixResult,
          ),
        if (tskgResult.isNotEmpty)
          CategoryListItem(
            title: 'TS.KG',
            items: tskgResult,
          ),
      ];
    }, [searchController.text]));

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
                  borderSide: BorderSide(
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (categoriesFuture.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = categoriesFuture.data ?? [];

              if (categories.isEmpty) {
                if (searchController.text.isEmpty) {
                  return const SizedBox();
                } else {
                  return Center(
                    child: Text('По Вашему запросу ничего не найдено'),
                  );
                }
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
                                  child: SvgPicture.asset(
                                    category.onlineService.logo,
                                    height: 20.0,

                                    fit: BoxFit.scaleDown,
                                    // colorFilter: ColorFilter.mode(
                                    //     Colors.grey, BlendMode.srcIn),
                                    excludeFromSemantics: true,
                                  ),
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
