import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/filmix_api_provider.dart';
import '../extensions/buildless_auto_dispose_async_notifier_mixins.dart';
import '../models/media_item.dart';
import '../providers/providers.dart';
import '../resources/constants.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

// part 'shows_page.g.dart';

// @riverpod
// class FilmixLatestShows extends _$FilmixLatestShows
//     with FilmixApiMixins, ApiCallMixins {
//   @override
//   Future<List<MediaItem>> build() {
//     return fetch();
//   }

//   @override
//   Future<List<MediaItem>> apiCall(cancelToken) {
//     return api.getLatestShows(cancelToken: cancelToken);
//   }
// }

// @riverpod
// class FilmixPopularShows extends _$FilmixPopularShows
//     with FilmixApiMixins, ApiCallMixins {
//   @override
//   Future<List<MediaItem>> build() {
//     return fetch();
//   }

//   @override
//   Future<List<MediaItem>> apiCall(cancelToken) {
//     return api.getPopularShows(cancelToken: cancelToken);
//   }
// }

class ShowsPage extends HookConsumerWidget {
  const ShowsPage({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    final listKey = useState(UniqueKey());

    final cardDetailsHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        TvUi.cardListHeight;

    final pageHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        TvUi.vPadding;
    final expandedListHeight = pageHeight;
    final collapsedListHeight = pageHeight - TvUi.featuredHeight;

    final cardDetails = ref.watch(cardDetailsProvider);
    final cardDetailsController = ref.read(cardDetailsProvider.notifier);

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -(const KrsNavigationBar().preferredSize.height),
          right: 0.0,
          child: RepaintBoundary(
            child: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (rect) {
                const alignment = Alignment(0.575, -1.0);

                return const RadialGradient(
                  center: alignment,
                  radius: 1.0,
                  focal: alignment,
                  focalRadius: 0.62,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  transform: GradientOval(),
                ).createShader(rect);
              },

              /// постер фильма
              child: Opacity(
                opacity: 1.0,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/id0gCbEij0NItwKpoEhL2TR0KT6.jpg',
                  width: TvUi.backdropImageSize.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: kThemeAnimationDuration,
          height: TvUi.featuredHeight,
          child: FeaturedCard(
            title: 'title',
          ),
        ),
        AnimatedPositioned(
          duration: kThemeAnimationDuration,
          top: TvUi.featuredHeight,
          left: 0,
          right: 0,
          bottom: 0,
          child: VerticalListView(
            key: UniqueKey(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return HorizontalListView<MediaItem>(
                key: UniqueKey(),
                itemHeight: TvUi.horizontalCardSize.height,
                title: Text('Популярные'),
                asyncItems: items[index],
                itemBuilder: (context, index, item) {
                  return MediaCard(
                    title: item.title,
                    imageUrl: item.posterUrl,
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

// clipBehavior: Clip.none,
// padding: const EdgeInsets.symmetric(
//   horizontal: TvUi.hPadding,
// ),
// scrollDirection: Axis.horizontal,
// separatorBuilder: (context, index) =>
//     const SizedBox(width: 20.0),
// itemCount: latestShows.length,
// itemBuilder: (context, index) {
//   final mediaItem = latestShows[index];
//   return MediaCard(
//     title: mediaItem.title,
//     imageUrl: mediaItem.posterUrl,
//   );
// },

class GradientOval extends GradientTransform {
  const GradientOval();

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final scale = bounds.right / bounds.bottom;
    final oldWidth = bounds.bottom;
    final newWidth = oldWidth * scale;

    return Matrix4.identity()
      ..scale(scale, 1.0)
      ..translate(-(newWidth - oldWidth) / 2, 0.0);
  }
}
