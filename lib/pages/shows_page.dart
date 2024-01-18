import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../api/filmix_api_provider.dart';
import '../api/rezka_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/filmix/filmix_item.dart';
import '../models/media_item.dart';
import '../models/rezka/rezka_item.dart';
import '../models/tskg/tskg_item.dart';
import '../providers/providers.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/images/online_service_logo.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookConsumerWidget {
  const ShowsPage({super.key});

  @override
  Widget build(context, ref) {
    /// сохраняем состояние страницы между переходами [PageView]
    useAutomaticKeepAlive();

    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    final screenSize = MediaQuery.of(context).size;

    final selectedMediaItem = useState<int?>(null);
    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    useStream(
      kIsWeb ? null : storage.db.mediaItems.watchLazy(),
    );

    /// запрос избранных сериалов
    final bookmarksQuery = storage.db.mediaItems
        .where()
        .typeEqualTo(MediaItemType.show)
        .and()
        .bookmarkedIsNotNull();

    /// есть ли в списке избранных элементы
    final bookmarkCount = bookmarksQuery.count();
    final hasBookmarks = bookmarkCount > 0;

    final asyncBookmarks = useMemoized(() async {
      final items = await bookmarksQuery.findAllAsync();
      return items.map((item) {
        if (item.onlineService == OnlineService.filmix) {
          return FilmixItem.fromJson(item.toJson());
        }
        if (item.onlineService == OnlineService.tskg) {
          return TskgItem.fromJson(item.toJson());
        }
        if (item.onlineService == OnlineService.rezka) {
          return RezkaItem.fromJson(item.toJson());
        }
        throw Exception();
      }).toList();
    }, [bookmarkCount]);

    /// tskg провайдер запросов к API
    final tskgApi = ref.read(tskgApiProvider);

    /// tskg список последний добавлений
    final tskgAsyncLatest = useMemoized(() => tskgApi.getLatestShows());

    /// filmix провайдер запросов к API
    final filmixApi = ref.read(filmixApiProvider);

    /// filmix список последний добавлений
    final filmixAsyncLatest = useMemoized(() => filmixApi.getLatestShows());

    /// hdrezka провайдер запросов к API
    final rezkaApi = ref.read(rezkaApiProvider);

    /// hdrezka список последний добавлений
    final rezkaAsyncLatest = useMemoized(() => rezkaApi.getLatestShows());

    final a = rezkaApi.parseStreams(
        '#hWzM2MHBdaHR0cHM6Ly9zdHJlYW0udm9pZGJvb3N0LmNjL2E1MWE3ZDBkNzM2YWY4M2EwMWMwNmM4MzIzZGE2NjY5OjIwMjQwMTE5MTA6ZDFWVFUxVm9iRFV4UlVwT1RXUlZTVGhpYlU1RlNUQTR\/\/_\/\/JCQhIUAkJEBeIUAjJCRAXR0lyUkRaVFdFSnhWRXRxTVRWTWJHOXNRa3ByVG1GQmMxZ3JNa2QwV0VsRFpWVXZZMVZISzFsU1RVVk1Ra28xU1ZCSWJVTXhVM0psZGtKR1NUQkRTREIyVVVkd1VtZzVXQ3RwZDJGdmNHZ3phRTA5LzkvOS85LzYvOC80L2ZkNmZiLm1wNDpobHM6bWFuaWZlc3QubTN1OCBvciBodHRwczovL3N0cmVhbS52b2lkYm9vc3QuY2MvYTUxYTdkMGQ3MzZhZjgzYTAxYzA2YzgzMjNkYTY2Njk6MjAyNDAxMTkxMDpkMVZUVTFWb2JEVXhSVXBPVFdSVlNUaGliVTVGU1RBNFdHSXJSRFpUV0VKeFZFdHFNVFZNYkc5c1FrcHJUbUZCYzFnck1rZDBXRWxEWlZVdlkxVkhLMWxTVFVWTVFrbzFTVkJJYlVNeFUzSmxka0pHU1RCRFNEQjJVVWR3VW1nNVdDdHBkMkZ2Y0dnemFFMDkvOS85LzkvNi84LzQvZmQ2ZmIubXA0LFs0ODBwXWh0dHBzOi8vc3RyZWFtLnZvaWRib29zdC5jYy9lMzJlNDFkZDY4NmRlNWVlYTMyZWU2NDdiYjhiNjU1MzoyMDI0MDExOTEwOm\/\/_\/\/Xl5eIUAjIyEhIyM=QxVlRVMVZvYkRVeFJVcE9UV1JWU1RoaWJVNUZTVEE0V0dJclJEWlRXRUp4VkV0cU1UVk1iRzlzUWtwclRtRkJjMWdyTWtkMFdFbERaVlV2WTFWSEsxbFNUVVZNUWtvMVNWQkliVU14VTNKbGRrSkdTVEJEU0RCMlVVZHdVbWc1V0N0cGQyRnZjR2d6YUUwOS85LzkvOS82LzgvNC9zcXgwaC5tcDQ6aGxzOm1hbmlmZXN0Lm0zdTggb3IgaHR0cHM6Ly9zdHJlYW0udm9pZGJvb3N0LmNjL2UzMmU0MWRkNjg2ZGU1ZWVhMzJlZTY0N2JiOGI2NTUzOjIwMjQwMTE5MTA6ZDFWVFUxVm9iRFV4UlVwT1RXUlZTVGhpYlU1RlNUQTRXR0lyUkRaVFdFSnhWRXRxTVRWTWJHOXNRa3ByVG1GQmMxZ3JNa2QwV0VsRFpWVXZZMVZISzFsU1RVVk1Ra28xU1ZCSWJVTXhVM0psZGtKR1NUQkRTREIyVVVkd1VtZzVXQ3RwZDJGdmNHZ3phRTA5LzkvOS85LzYvOC80L3NxeDBoLm1wNCxbNzIwcF1odHRwczovL3N0cmV\/\/_\/\/JCQjISFAIyFAIyM=hbS52b2lkYm9vc3QuY2MvZmNmNGIyMzY5NjYzOTRmZWU3NDM3MjljZDI0ZGU0OWM6MjAyNDAxMTkxMDpkMVZUVTFWb2JEVXhSVXBPVFdSVlNUaGliVTVGU1RBNFdHSXJSRFpUV0VKeFZFdHFNVFZNYkc5c1FrcHJUbUZCYzFnck1rZDBXRWxEWlZVdlkxVkhLMWxTVFVWTVFrbzFTVkJJYlVNeFUzSmxka0pHU1RCRFNEQjJVVWR3VW1nNVdDdHBkMkZ2Y0dnemFFMDkvOS85LzkvNi84LzQvZjMwcTYubXA0OmhsczptYW5pZmVzdC5tM3U4IG9yIGh0dHBzOi8vc3RyZWFtLnZvaWRib29zdC5jYy9mY2Y0YjIzNjk2NjM5NGZlZTc0MzcyOWNkMjRkZTQ5YzoyMDI0MDExOTEwOmQxVlRVMVZvYkRVeFJVcE9UV1JWU1RoaWJVNUZTVEE0V0dJclJEWlRXRUp4VkV0cU1UVk1iRzlzUWtwclRtRkJjMWdyTWtkMFdFbERaVlV2WTFWSEsxbFNUVVZNUWtvMVNWQkliVU14VTNKbGRrSkdTVEJEU0RCMlVVZHdVbWc1V0N0cGQyRnZjR2d6YUUwOS85LzkvOS82LzgvNC9mMzBxNi5tcDQsWzEwODBwXWh0dHBzOi8vc3RyZWFtLnZvaWRib29zdC5jYy9hNTliY2U4ZjAwYjQ0NzQ0YWE5YTM3MTgzYzhmNTkxZToyMDI0MDExOTEwOmQxVlRVMVZvYkRVeFJVcE9UV1JWU1RoaWJVNUZTVEE0V0dJclJEWlRXRUp4VkV0cU1UVk1iRzlzUWtwclRtRkJjMWdyTWtkMFdFbERaVlV2WTFWSEsxbFNUVVZNUWtvMVNWQkliVU14VTNKbGRrSkdTVEJEU0RCMlVVZHdVbWc1V0N0cGQyRnZjR2d6YUUwOS85LzkvOS82LzgvNC9obW96Yy5tcDQ6aGxzOm1hbmlmZXN0Lm0zdTggb3IgaHR0cHM6Ly9zdHJlYW0udm9pZGJvb3N0LmNjL2E1OWJjZThmMDBiNDQ3NDRhYTlhMzcxODNjOGY1OTFlOjIwMjQwMTE5MTA6ZDFWVFUxVm9iRFV4UlVwT1RXUlZTVGhpYlU1RlNUQTRXR0lyUkRaVFdFSnhWRXRxTVRWTWJHOXNRa3ByVG1GQmMxZ3JNa2QwV0VsRFpWVXZZMVZISzFsU1RVVk1Ra28xU1ZCSWJVTXhVM0psZGtKR1NUQkRTREIyVVVkd1VtZzVXQ3RwZDJGdmNHZ3phRTA5LzkvOS85LzYvOC80L2htb3pjLm1wNCxbMTA4MHAgVWx0cmFdaHR0cHM6Ly9zdHJlYW0udm9pZGJvb3N0LmNjL2E1OWJjZThmMDBiNDQ3NDRhYTlhMzcxODNjOGY1OTFlOjIwMjQwMTE5MTA6ZDFWVFUxVm9iRFV4UlVwT1RXUlZTVGhpYlU1RlNUQTRXR0lyUkRaVFdFSnhWRXRxTVRWTWJHOXNRa3ByVG1GQmMxZ3JNa2QwV0VsRFpWVXZZMVZISzFsU1RVVk1Ra28xU1ZCSWJVTXhVM0p\/\/_\/\/QEBAQEAhIyMhXl5esZGtKR1NUQkRTREIyVVVkd1VtZzVXQ3RwZDJGdmNHZ3phRTA5LzkvOS85LzYvOC80L2htb3pjLm1wNDpobHM6bWFuaWZlc3QubTN1OCBvciBodHRwczovL3N0cmVhbS52b2lkYm9vc3QuY2MvYTU5YmNlOGYwMGI0NDc0NGFhOWEzNzE4M2M4\/\/_\/\/IyMjI14hISMjIUBAZjU5MWU6MjAyNDAxMTkxMDpkMVZUVTFWb2JEVXhSVXBPVFdSVlNUaGliVTVGU1RBNFdHSXJSRFpUV0VKeFZFdHFNVFZNYkc5c1FrcHJUbUZCYzFnck1rZDBXRWxEWlZVdlkxVkhLMWxTVFVWTVFrbzFTVkJJYlVNeFUzSmxka0pHU1RCRFNEQjJVVWR3VW1nNVdDdHBkMkZ2Y0dnemFFMDkvOS85LzkvNi84LzQvaG1vemMubXA0');
    print(a);

    final providers = useMemoized(() => [
          MediaItem(
            id: 'filmixShows',
            title: 'Filmix',
            poster: 'assets/images/filmix.svg',
            type: MediaItemType.folder,
          ),
          MediaItem(
            id: 'rezkaShows',
            title: 'HD Rezka',
            poster: 'assets/images/rezka.png',
            type: MediaItemType.folder,
          ),
          MediaItem(
            id: 'tskgShows',
            title: 'TS.KG',
            poster: 'assets/images/tskg.svg',
            type: MediaItemType.folder,
          ),
        ]);

    final categories = useMemoized(
        () => [
              CategoryListItem(
                title: 'Провайдеры',
                items: providers,
              ),
              if (hasBookmarks)
                CategoryListItem(
                  key: ValueKey(bookmarkCount),
                  title: locale.bookmarks,
                  apiResponse: asyncBookmarks,
                ),
              CategoryListItem(
                onlineService: OnlineService.filmix,
                title: 'Последние поступления',
                apiResponse: filmixAsyncLatest,
              ),
              CategoryListItem(
                onlineService: OnlineService.rezka,
                title: 'Последние поступления',
                apiResponse: rezkaAsyncLatest,
              ),
              CategoryListItem(
                onlineService: OnlineService.tskg,
                title: 'Последние поступления',
                apiResponse: tskgAsyncLatest,
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
            Future.delayed(kThemeAnimationDuration).then((value) {
              if (mediaItem != null) {
                key.currentState?.animateToCurrent();
              }
            });
            return FeaturedCard(mediaItem);
          },
        ),
        Expanded(
          child: VerticalListView(
            key: key,
            padding: const EdgeInsets.symmetric(vertical: TvUi.vPadding),
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                selectedMediaItem.value = null;
                focusedMediaItem.value = null;
              }
            },
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
                      key: category.key,
                      asyncItems: category.itemsFuture,
                      itemBuilder: (context, item) {
                        return MediaItemCard(
                          mediaItem: item,
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              if (item.isFolder) {
                                selectedMediaItem.value = null;
                                focusedMediaItem.value = null;
                              } else {
                                selectedMediaItem.value = index;
                                focusedMediaItem.value = item;
                              }
                            }
                          },
                          onTap: () {
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
