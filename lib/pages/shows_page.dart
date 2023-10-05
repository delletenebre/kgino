import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../enums/online_service.dart';
import '../models/category_list_item.dart';
import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../models/tskg/tskg_item.dart';
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

    /// хранилище данных
    final storage = ref.read(storageProvider);

    final bookmarksQuery = storage.db.mediaItems
        .where()
        .typeEqualTo(MediaItemType.show)
        .and()
        .bookmarkedIsNotNull();

    final hasBookmarks = bookmarksQuery.count() > 0;

    final asyncBookmarks = useMemoized(() async {
      final items = await bookmarksQuery.findAllAsync();
      return items.map((item) {
        if (item.onlineService == OnlineService.filmix) {
          return FilmixItem.fromJson(item.toJson());
        }
        if (item.onlineService == OnlineService.tskg) {
          return TskgItem.fromJson(item.toJson());
        }
        throw Exception();
      }).toList();
    });

    final providers = useMemoized(() {
      return [
        MediaItem(
          id: 'filmixShows',
          title: 'Filmix',
          poster: 'assets/images/flmx.svg',
          type: MediaItemType.folder,
        ),
        MediaItem(
          id: 'tskgShows',
          title: 'TS.KG',
          poster: 'assets/images/tskg.svg',
          type: MediaItemType.folder,
        ),
      ];
    });

    final categories = [
      CategoryListItem(
        title: 'Провайдеры',
        items: providers,
      ),
      if (hasBookmarks)
        CategoryListItem(
          title: locale.bookmarks,
          apiResponse: asyncBookmarks,
        ),
    ];

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    return Column(
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
                        if (item.isFolder) {
                          context.goNamed(item.id);
                        } else {
                          /// переходим на страницу деталей о сериале
                          context.goNamed('details', extra: item);
                        }
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
