import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/rezka_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../providers/locale_provider.dart';
import '../resources/kika_theme.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/item_card.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/online_service_list_title.dart';
import '../ui/lists/vertical_list_view.dart';

class MoviesPage extends HookConsumerWidget {
  const MoviesPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final locale = Locale.of(context);

    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    final reloadKey = useState(UniqueKey());

    /// filmix провайдер запросов к API
    final filmixApi = ref.read(filmixApiProvider);

    /// filmix список последних добавлений
    final filmixAsyncLatest =
        useMemoized(() => filmixApi.getLatestMovies(), [reloadKey]);

    /// filmix список новинок
    final filmixAsyncNewest =
        useMemoized(() => filmixApi.getMoviesLastThreeYears(), [reloadKey]);

    /// filmix список популярных
    final filmixAsyncPopular =
        useMemoized(() => filmixApi.getPopularMovies(), [reloadKey]);

    /// hdrezka провайдер запросов к API
    final rezkaApi = ref.read(rezkaApiProvider);

    /// hdrezka список последний добавлений
    final rezkaAsyncLatest =
        useMemoized(() => rezkaApi.getLatestMovies(), [reloadKey]);

    /// hdrezka список последний добавлений
    final rezkaAsyncNewest =
        useMemoized(() => rezkaApi.getNewestMovies(), [reloadKey]);

    /// rezka список популярных
    final rezkaAsyncPopular = useMemoized(
        () => rezkaApi.getPopularMovies()..then((f) {}, onError: (error) {}),
        [reloadKey]);

    final categories = useMemoized(
        () => [
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
            ],
        [reloadKey]);

    final key = useMemoized(() => GlobalKey<VerticalListViewState>(),
        [categories.length, reloadKey]);

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
                title: OnlineServiceListTitle(category),
                asyncItems: category.itemsFuture,
                itemBuilder: (context, index, item) {
                  if (item.isError) {
                    return ItemCard(
                      title: 'Ошибка загрузки',
                      endWidget: const Text('Попробовать ещё раз'),
                      imageUrl: 'assets/icons/refresh.svg',
                      onPressed: () {
                        reloadKey.value = UniqueKey();
                        return KeyEventResult.handled;
                      },
                    );
                  }

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
                        /// переходим на страницу деталей о фильме
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
