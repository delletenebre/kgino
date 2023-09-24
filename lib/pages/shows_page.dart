import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../api/filmix_api_provider.dart';
import '../enums/online_service.dart';
import '../models/category_list_item.dart';
import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../providers/providers.dart';
import '../resources/constants.dart';
import '../resources/krs_locale.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookConsumerWidget {
  const ShowsPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final locale = KrsLocale.of(context);

    final api = ref.read(filmixApiProvider);

    /// список последний добавлений
    final asyncLatest = useMemoized(() => api.getLatestShows());

    /// популярные
    final asyncPopular = useMemoized(() => api.getPopularShows());

    /// хранилище данных
    final storage = ref.read(storageProvider);

    final asyncBookmarks = useMemoized(() => storage.db.mediaItems
        .where()
        .typeEqualTo(MediaItemType.show)
        .bookmarkedIsNotNull()
        .findAllAsync());

    final categories = [
      CategoryListItem(
        title: locale.bookmarks,
        apiResponse: asyncBookmarks,
      ),
      CategoryListItem(
        title: '[ Filmix ] ${locale.latest}',
        apiResponse: asyncLatest,
      ),
      CategoryListItem(
        title: '[ Filmix ] ${locale.popular}',
        apiResponse: asyncPopular,
      ),
    ];

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    return Column(
      children: [
        ValueListenableBuilder<MediaItem?>(
          valueListenable: focusedMediaItem,
          builder: (context, value, _) {
            return FeaturedCard(value);
          },
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
                        var mediaItem;
                        print(item.onlineService);
                        if (item.onlineService == OnlineService.filmix) {
                          mediaItem = FilmixItem.fromJson(item.toJson());
                        }

                        /// переходим на страницу деталей о сериале
                        context.goNamed('details', extra: mediaItem);
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
    );
  }
}
