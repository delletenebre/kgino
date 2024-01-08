import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../api/tskg_api_provider.dart';
import '../models/category_list_item.dart';
import '../models/media_item.dart';
import '../resources/krs_theme.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_item_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';

class ShowsPage extends HookConsumerWidget {
  const ShowsPage({super.key});

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    final selectedMediaItem = useState<int?>(null);
    final focusedMediaItem = useValueNotifier<MediaItem?>(null);

    /// tskg провайдер запросов к API
    final tskgApi = ref.read(tskgApiProvider);

    /// tskg список последний добавлений
    final tskgAsyncLatest = useMemoized(() => tskgApi.getLatestShows());

    /// filmix провайдер запросов к API
    final filmixApi = ref.read(filmixApiProvider);

    /// filmix список последний добавлений
    final filmixAsyncLatest = useMemoized(() => filmixApi.getLatestShows());

    final providers = useMemoized(() => [
          MediaItem(
            id: 'filmixShows',
            title: 'Filmix',
            poster: 'assets/images/filmix.svg',
            type: MediaItemType.folder,
          ),
          MediaItem(
            id: 'tskgShows',
            title: 'TS.KG',
            poster: 'assets/images/tskg.svg',
            type: MediaItemType.folder,
          ),
          // MediaItem(
          //   id: 'rezkaShows',
          //   title: 'HD Rezka',
          //   poster: 'assets/images/tskg.svg',
          //   type: MediaItemType.folder,
          // ),
        ]);

    final categories = [
      CategoryListItem(
        title: 'Провайдеры',
        items: providers,
      ),
      CategoryListItem(
        onlineService: OnlineService.tskg,
        title: 'Последние поступления',
        apiResponse: tskgAsyncLatest,
      ),
      CategoryListItem(
        onlineService: OnlineService.filmix,
        title: 'Последние поступления',
        apiResponse: filmixAsyncLatest,
      ),
    ];

    return Column(
      children: [
        ValueListenableBuilder<MediaItem?>(
          valueListenable: focusedMediaItem,
          builder: (context, mediaItem, _) => FeaturedCard(mediaItem),
        ),
        Expanded(
          child: VerticalListView(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
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
