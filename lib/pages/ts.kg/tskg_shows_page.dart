import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/category_list_item.dart';
import '../../models/media_item.dart';
import '../../resources/constants.dart';
import '../../resources/krs_locale.dart';
import '../../ui/cards/featured_card.dart';
import '../../ui/cards/media_card.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/vertical_list_view.dart';

class TskgShowsPage extends HookConsumerWidget {
  const TskgShowsPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// tskg провайдер запросов к API
    final tskgApi = ref.read(tskgApiProvider);

    /// tskg список последний добавлений
    final asyncLatest = useMemoized(() => tskgApi.getLatestShows());

    /// tskg популярные
    final asyncPopular = useMemoized(() => tskgApi.getPopularShows());

    final categories = [
      CategoryListItem(
        title: locale.latest,
        apiResponse: asyncLatest,
      ),
      CategoryListItem(
        title: locale.popular,
        apiResponse: asyncPopular,
      ),
    ];

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: TvUi.navigationBarSize,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
          height: TvUi.navigationBarSize.height,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.smart_display_outlined,
                size: 16.0,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(width: 4.0),
              Text(
                'TS.KG',
                style: TextStyle(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          ValueListenableBuilder<MediaItem?>(
            valueListenable: focusedMediaItem,
            builder: (context, mediaItem, _) => FeaturedCard(mediaItem),
          ),
          Expanded(
            child: VerticalListView(
              key: UniqueKey(),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  focusedMediaItem.value = null;
                }
              },
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: TvUi.vPadding),
                  child: HorizontalListView<MediaItem>(
                    key: UniqueKey(),
                    itemHeight: TvUi.horizontalCardSize.height,
                    title: Text(category.title),
                    asyncItems: category.itemsFuture,
                    itemBuilder: (context, index, item) {
                      return MediaCard(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            focusedMediaItem.value = item;
                          }
                        },
                        onTap: () {
                          /// переходим на страницу деталей о сериале
                          context.goNamed('details', extra: item);
                        },
                        title: item.title,
                        imageUrl: item.poster,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
