import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../models/test/media_item.dart';
import '../resources/constants.dart';
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
    final theme = Theme.of(context);

    final api = ref.read(filmixApiProvider);

    /// список последний добавлений
    final asyncLatest = useMemoized(() => api.getLatestShows());

    /// популярные
    final asyncPopular = useMemoized(() => api.getPopularShows());

    final items = [
      asyncLatest,
      asyncPopular,
      asyncLatest,
      asyncPopular,
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
            itemCount: items.length,
            itemBuilder: (context, index) {
              return HorizontalListView<MediaItem>(
                key: UniqueKey(),
                itemHeight: TvUi.horizontalCardSize.height,
                title: Text('Популярные'),
                asyncItems: items[index],
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
              );
            },
          ),
        ),
      ],
    );
  }
}
