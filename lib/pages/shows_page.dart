import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../api/filmix_api_provider.dart';
import '../api/rezka_api_provider.dart';
import '../api/tskg_api_provider.dart';
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

class ShowsPage extends HookConsumerWidget {
  const ShowsPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final locale = Locale.of(context);

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    useStream(storage.db?.mediaItems.watchLazy());

    /// запрос избранных сериалов
    final bookmarksQuery = storage.db?.mediaItems
        .where()
        .typeEqualTo(MediaItemType.show)
        .and()
        .bookmarkedIsNotNull();

    /// есть ли в списке избранных элементы
    final bookmarkCount = bookmarksQuery?.count() ?? 0;
    final hasBookmarks = bookmarkCount > 0;

    final asyncBookmarks = useMemoized(() async {
      final items = await bookmarksQuery?.findAllAsync() ?? [];
      return items.map((item) => item.fromDatabase()).toList();
    }, [bookmarkCount]);

    /// tskg провайдер запросов к API
    final tskgApi = ref.read(tskgApiProvider);

    /// filmix провайдер запросов к API
    final filmixApi = ref.read(filmixApiProvider);

    /// tskg список последних добавлений
    final tskgAsyncLatest = useMemoized(() => tskgApi.getLatestShows());

    /// tskg список новых сериалов
    final tskgAsyncNewest = useMemoized(() => tskgApi.getNewestShows());

    /// tskg список популярных сериалов
    final tskgAsyncPopular = useMemoized(() => tskgApi.getPopularShows());

    /// filmix список последних добавлений
    final filmixAsyncLatest = useMemoized(() => filmixApi.getLatestShows());

    /// filmix список новых
    final filmixAsyncNewest = useMemoized(() => filmixApi.getNewestShows());

    /// filmix список популярных
    final filmixAsyncPopular = useMemoized(() => filmixApi.getPopularShows());

    /// hdrezka провайдер запросов к API
    final rezkaApi = ref.read(rezkaApiProvider);

    /// hdrezka список последних добавлений
    final rezkaAsyncLatest = useMemoized(() => rezkaApi.getLatestShows());

    /// hdrezka список популярных
    final rezkaAsyncPopular = useMemoized(() => rezkaApi.getPopularShows());

    /// hdrezka список новых
    final rezkaAsyncNewest = useMemoized(() => rezkaApi.getNewestShows());

    final categories = useMemoized(
        () => [
              if (hasBookmarks)
                CategoryListItem(
                  key: ValueKey(bookmarkCount),
                  title: locale.bookmarks,
                  apiResponse: asyncBookmarks,
                ),
              CategoryListItem(
                onlineService: OnlineService.filmix,
                title: locale.latestArrivals,
                apiResponse: filmixAsyncLatest,
              ),
              CategoryListItem(
                onlineService: OnlineService.filmix,
                title: locale.novelty,
                apiResponse: filmixAsyncNewest,
              ),
              CategoryListItem(
                onlineService: OnlineService.filmix,
                title: locale.popular,
                apiResponse: filmixAsyncPopular,
              ),
              CategoryListItem(
                onlineService: OnlineService.rezka,
                title: locale.latestArrivals,
                apiResponse: rezkaAsyncLatest,
              ),
              CategoryListItem(
                onlineService: OnlineService.rezka,
                title: locale.novelty,
                apiResponse: rezkaAsyncNewest,
              ),
              CategoryListItem(
                onlineService: OnlineService.rezka,
                title: locale.popular,
                apiResponse: rezkaAsyncPopular,
              ),
              CategoryListItem(
                onlineService: OnlineService.tskg,
                title: locale.latestArrivals,
                apiResponse: tskgAsyncLatest,
              ),
              CategoryListItem(
                onlineService: OnlineService.tskg,
                title: locale.novelty,
                apiResponse: tskgAsyncNewest,
              ),
              CategoryListItem(
                onlineService: OnlineService.tskg,
                title: locale.popular,
                apiResponse: tskgAsyncPopular,
              ),
            ],
        [bookmarkCount]);

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
                key: (category.title == locale.bookmarks)
                    ? ValueKey(bookmarkCount)
                    : null,
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
