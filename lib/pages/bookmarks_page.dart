import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sembast/sembast.dart';

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

class BookmarksPage extends StatefulHookConsumerWidget {
  const BookmarksPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends ConsumerState<BookmarksPage> {
  /// запрос избранных сериалов
  final showsQuery = MediaItem.store.query(
      finder: Finder(
    filter: Filter.and([
      Filter.equals('type', MediaItemType.show.name),
      Filter.notNull('bookmarked')
    ]),
    sortOrders: [SortOrder('bookmarked', false)],
  ));

  /// запрос избранных фильмов
  final moviesQuery = MediaItem.store.query(
      finder: Finder(
    filter: Filter.and([
      Filter.equals('type', MediaItemType.movie.name),
      Filter.notNull('bookmarked')
    ]),
    sortOrders: [SortOrder('bookmarked', false)],
  ));

  /// запрос истории
  final historyQuery = MediaItem.store.query(
      finder: Finder(
    filter: Filter.notNull('historied'),
    sortOrders: [SortOrder('historied', false)],
  ));

  late final StreamSubscription showsSubscription;
  late final StreamSubscription moviesSubscription;
  late final StreamSubscription historySubscription;

  @override
  void initState() {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    showsSubscription = showsQuery.onSnapshots(storage.db).listen((snapshots) {
      setState(() {});
    });

    moviesSubscription =
        moviesQuery.onSnapshots(storage.db).listen((snapshots) {
      setState(() {});
    });

    historySubscription =
        historyQuery.onSnapshots(storage.db).listen((snapshots) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    unawaited(showsSubscription.cancel());
    unawaited(moviesSubscription.cancel());
    unawaited(historySubscription.cancel());
    super.dispose();
  }

  @override
  Widget build(context) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final locale = Locale.of(context);

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// есть ли в списке избранных сериалов элементы
    final showsCount = showsQuery.countSync(storage.db);
    final asyncShows = useMemoized(() async {
      final items = await showsQuery.getSnapshots(storage.db);
      return items
          .map((e) => MediaItem.fromJson(e.value).findSaved(storage))
          .toList();
    }, [ValueKey(showsCount)]);

    /// есть ли в списке избранных фильмов элементы
    final moviesCount = moviesQuery.countSync(storage.db);
    final asyncMovies = useMemoized(() async {
      final items = await moviesQuery.getSnapshots(storage.db);
      return items
          .map((e) => MediaItem.fromJson(e.value).findSaved(storage))
          .toList();
    }, [moviesCount]);

    /// есть ли в списке избранных фильмов элементы
    final historyCount = historyQuery.countSync(storage.db);
    final asyncHistory = useMemoized(() async {
      final items = await historyQuery.getSnapshots(storage.db);
      return items
          .map((e) => MediaItem.fromJson(e.value).findSaved(storage))
          .toList();
    }, [historyCount]);

    final categories = useMemoized(
        () => [
              if (showsCount > 0)
                CategoryListItem(
                  key: ValueKey(showsCount),
                  title: locale.shows,
                  apiResponse: asyncShows,
                ),
              if (moviesCount > 0)
                CategoryListItem(
                  key: ValueKey(moviesCount),
                  title: locale.movies,
                  apiResponse: asyncMovies,
                ),
              if (historyCount > 0)
                CategoryListItem(
                  key: ValueKey(historyCount),
                  title: locale.history,
                  apiResponse: asyncHistory,
                ),
            ],
        [showsCount, moviesCount, historyCount]);

    final key = useMemoized(() => GlobalKey<VerticalListViewState>(),
        [showsCount, moviesCount, historyCount]);

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
