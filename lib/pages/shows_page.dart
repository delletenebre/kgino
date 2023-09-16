import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/filmix_api_provider.dart';
import '../models/media_item.dart';
import '../providers/focused_media_item_provider.dart';
import '../resources/constants.dart';
import '../ui/cards/featured_card.dart';
import '../ui/cards/media_card.dart';
import '../ui/lists/horizontal_list_view.dart';
import '../ui/lists/vertical_list_view.dart';
import '../ui/navigation_bar/krs_navigation_bar.dart';

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -(const KrsNavigationBar().preferredSize.height),
          right: 0.0,
          child: Consumer(
            builder: (context, ref, child) {
              final focusedMediaItem = ref.watch(focusedMediaItemProvider);
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: focusedMediaItem.valueOrNull == null ||
                        focusedMediaItem.isLoading ||
                        focusedMediaItem.value!.backdropImage.isEmpty
                    ? null
                    : RepaintBoundary(
                        key: UniqueKey(),
                        child: ShaderMask(
                          blendMode: BlendMode.dstOut,
                          shaderCallback: (rect) {
                            const alignment = Alignment(0.575, -1.0);

                            return const RadialGradient(
                              center: alignment,
                              radius: 1.0,
                              // focal: alignment,
                              // focalRadius: 0.62,
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
                            child: SizedBox.fromSize(
                              size: TvUi.backdropImageSize,
                              child: Image.network(
                                focusedMediaItem.value!.backdropImage,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
        Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final focusedMediaItem = ref.watch(focusedMediaItemProvider);
                // if (focusedMediaItem.value == null) {
                //   return const SizedBox();
                // }

                final mediaItem = focusedMediaItem.valueOrNull;

                return AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  height: mediaItem == null ? 0.0 : TvUi.featuredHeight,
                  child: mediaItem == null
                      ? const SizedBox()
                      : FeaturedCard(mediaItem),
                );
              },
            ),
            Expanded(
              child: VerticalListView(
                key: UniqueKey(),
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    ref
                        .read(focusedMediaItemProvider.notifier)
                        .updateItem(null);
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
                            ref
                                .read(focusedMediaItemProvider.notifier)
                                .updateItem(item);
                          }
                        },
                        onTap: () {
                          /// переходим на страницу деталей о сериале
                          context.goNamed('details', extra: item);
                        },
                        title: item.title,
                        imageUrl: item.posterImage ?? '',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
