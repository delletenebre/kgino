import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../providers/locale_provider.dart';
import '../providers/storage_provider.dart';
import '../resources/kika_theme.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/online_service_list_title.dart';
import '../ui/lists/vertical_list_view.dart';

class BookmarksPage extends HookConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final locale = Locale.of(context);

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    useStream(storage.db?.mediaItems.watchLazy());

    /// запрос избранных
    final showBookmarksQuery = storage.db?.mediaItems
        .where()
        .typeEqualTo(MediaItemType.show)
        .bookmarkedIsNotNull()
        .sortByBookmarkedDesc();

    /// есть ли в списке избранных элементы
    final showBookmarkCount = showBookmarksQuery?.count() ?? 0;
    final hasShowBookmarks = showBookmarkCount > 0;

    final asyncShowBookmarks = useMemoized(() async {
      final items = await showBookmarksQuery?.findAllAsync() ?? [];
      return items.map((item) => item.fromDatabase()).toList();
    }, [showBookmarkCount]);

    /// запрос избранных фильмов
    final movieBookmarksQuery = storage.db?.mediaItems
        .where()
        .typeEqualTo(MediaItemType.movie)
        .and()
        .bookmarkedIsNotNull();

    /// есть ли в списке избранных элементы
    final movieBookmarkCount = movieBookmarksQuery?.count() ?? 0;
    final hasMovieBookmarks = movieBookmarkCount > 0;

    final asyncMovieBookmarks = useMemoized(() async {
      final items = await movieBookmarksQuery?.findAllAsync() ?? [];
      return items.map((item) => item.fromDatabase()).toList();
    }, [movieBookmarkCount]);

    /// запрос истории
    final hystoryQuery = storage.db?.mediaItems
        .where()
        .historiedIsNotNull()
        .sortByHistoriedDesc();

    final historyCount = hystoryQuery?.count() ?? 0;
    final hasHystory = historyCount > 0;

    final asyncHystory = useMemoized(() async {
      final items = await hystoryQuery?.findAllAsync() ?? [];
      return items.map((item) => item.fromDatabase()).toList();
    }, [historyCount]);

    final categories = useMemoized(
        () => [
              if (hasShowBookmarks)
                CategoryListItem(
                  key: ValueKey(showBookmarkCount),
                  title: locale.shows,
                  apiResponse: asyncShowBookmarks,
                ),
              if (hasMovieBookmarks)
                CategoryListItem(
                  key: ValueKey(movieBookmarkCount),
                  title: locale.movies,
                  apiResponse: asyncMovieBookmarks,
                ),
              if (hasHystory)
                CategoryListItem(
                  key: ValueKey(historyCount),
                  title: locale.history,
                  apiResponse: asyncHystory,
                ),
            ],
        [showBookmarkCount, movieBookmarkCount, historyCount]);

    final key = useMemoized(
        () => GlobalKey<VerticalListViewState>(), [categories.length]);

    return Column(
      children: [
        ValueListenableBuilder<MediaItem?>(
          valueListenable: focusedMediaItem,
          builder: (context, mediaItem, _) {
            return FeaturedCard(mediaItem, key: ValueKey(mediaItem?.id));
          },
        ),
        Expanded(
          child: VerticalListView(
            key: key,
            itemHeight: kCardMaxHeight + kListTitleHeight,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return HorizontalListView<MediaItem>(
                key: ValueKey(category.title + index.toString()),
                title: OnlineServiceListTitle(category),
                asyncItems: category.itemsFuture,
                itemBuilder: (context, index, item) {
                  return MediaItemCard(
                    mediaItem: item,
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        if (item.isFolder) {
                          focusedMediaItem.value = null;
                        } else {
                          focusedMediaItem.value = item;
                        }
                      }
                    },
                    onPressed: () {
                      if (item.isFolder) {
                        /// переходим на страницу выбранного провайдера
                        context.pushNamed(item.id);
                      } else {
                        /// переходим на страницу деталей о сериале
                        context.pushNamed('details', extra: item);
                      }
                    },
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
