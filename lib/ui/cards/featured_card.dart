import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kgino/extensions/list_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/test/media_item.dart';
import '../../resources/constants.dart';
import 'backdrop_image.dart';

part 'featured_card.g.dart';

@riverpod
class FocusedMediaItem extends _$FocusedMediaItem {
  @override
  FutureOr<MediaItem?> build(MediaItem? mediaItem) async {
    // ref.onClose(() {
    //   debugPrint('navigationProvider disposed');
    // });

    // loadDetails();

    return fetchDetails();
  }

  Future<void> loadDetails() async {
    if (mediaItem != null) {
      state = const AsyncLoading();

      final detailed = await mediaItem!.loadDetails(ref);
      // final tmdb = (await AsyncValue.guard(() async {
      //   /// запрашиваем данные на TMDB
      //   return await mediaItem.loadTmdb(ref);
      // }))
      //     .valueOrNull;

      state = AsyncData(detailed);
    }
  }

  Future<MediaItem?> fetchDetails() async {
    if (mediaItem != null) {
      final detailed = await mediaItem!.loadDetails(ref);

      return detailed;
    }

    return mediaItem;
  }

  void reset() {
    state = const AsyncData(null);
  }

  bool get hasItem => state.valueOrNull != null;
}

class FeaturedCard extends HookConsumerWidget {
  final MediaItem? mediaItem;

  const FeaturedCard(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);

    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final positionAnimation = useAnimation<double>(Tween(
      begin: -TvUi.featuredHeight - 40.0,
      end: 40.0,
    ).animate(animationController));
    final opacityAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController));
    final heightAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: TvUi.featuredHeight,
    ).animate(animationController));

    /// вычисляем цвет свечения
    useEffect(() {
      animationController.forward();

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    final focusedMediaItem = ref.watch(focusedMediaItemProvider(mediaItem));

    final currentMediaItem = focusedMediaItem.valueOrNull;

    print('BUILED ${currentMediaItem?.id}');

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: mediaItem == null ? 0.0 : TvUi.featuredHeight,
      child: currentMediaItem == null
          ? const SizedBox()
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -(TvUi.navigationBarSize.height),
                  right: 0.0,
                  child: AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: currentMediaItem.backdrop.isEmpty
                        ? null
                        : BackdropImage(currentMediaItem.backdrop),
                  ),
                ),
                Positioned(
                  bottom: positionAnimation,
                  left: TvUi.hPadding,
                  child: SizedBox(
                    width: TvUi.featuredSize.width,
                    child: Opacity(
                      opacity: opacityAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 12.0,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    [
                                      currentMediaItem.genres.joinFirstTwo(),
                                      currentMediaItem.year,
                                      currentMediaItem.countries.joinFirstTwo(),
                                    ].removeEmpty().join(' • '),
                                    //'Superhero/Action • 2022 • 2h 15m'
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            currentMediaItem.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 32.0,
                            ),
                          ),
                          if (currentMediaItem.overview.isNotEmpty)
                            Padding(
                              key: ValueKey(
                                  'overview:${currentMediaItem.overview}'),
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                currentMediaItem.overview,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          // AnimatedSwitcher(
                          //   duration: kThemeAnimationDuration,
                          //   reverseDuration: Duration.zero,
                          //   transitionBuilder: (child, animation) {
                          //     final fadeAnimation = Tween<double>(
                          //       begin: 0.0, // Fully transparent
                          //       end: 1.0, // Fully opaque
                          //     ).animate(animation);

                          //     final slideAnimation = Tween<Offset>(
                          //       begin: const Offset(
                          //           0.0, 1.0), // Start from below the widget
                          //       end: const Offset(
                          //           0.0, 0.0), // End at its original position
                          //     ).animate(animation);

                          //     final sizeAnimation = Tween<double>(
                          //       begin: 0.0, // Start with zero size
                          //       end: 1.0, // End with full size
                          //     ).animate(animation);

                          //     return SizeTransition(
                          //       sizeFactor: sizeAnimation,
                          //       child: FadeTransition(
                          //         opacity: fadeAnimation,
                          //         child: child,
                          //       ),
                          //     );
                          //   },
                          //   child: currentMediaItem.overview.isNotEmpty
                          //       ? Padding(
                          //           key: ValueKey(
                          //               'overview:${currentMediaItem.overview}'),
                          //           padding: const EdgeInsets.only(top: 20.0),
                          //           child: Text(
                          //             currentMediaItem.overview,
                          //             maxLines: 6,
                          //             overflow: TextOverflow.ellipsis,
                          //             style: TextStyle(
                          //               fontSize: 16.0,
                          //               color:
                          //                   theme.colorScheme.onSurfaceVariant,
                          //             ),
                          //           ),
                          //         )
                          //       : null,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
