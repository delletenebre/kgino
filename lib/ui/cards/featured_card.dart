import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kgino/extensions/list_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/media_item.dart';
import '../../resources/constants.dart';
import 'backdrop_image.dart';

part 'featured_card.g.dart';

@riverpod
class FocusedMediaItem extends _$FocusedMediaItem {
  @override
  FutureOr<MediaItem?> build(MediaItem? mediaItem) async {
    return fetchDetails();
  }

  // Future<void> loadDetails() async {
  //   if (mediaItem != null && !mediaItem!.isFolder) {
  //     state = const AsyncLoading();

  //     final detailed = await mediaItem!.loadDetails(ref);
  //     // final tmdb = (await AsyncValue.guard(() async {
  //     //   /// запрашиваем данные на TMDB
  //     //   return await mediaItem.loadTmdb(ref);
  //     // }))
  //     //     .valueOrNull;

  //     state = AsyncData(detailed);
  //   }
  // }

  Future<MediaItem?> fetchDetails() async {
    if (mediaItem != null && !mediaItem!.isFolder) {
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
    final screenHeight = MediaQuery.sizeOf(context).height;
    final featuredHeight =
        screenHeight - TvUi.featuredHeight - TvUi.navigationBarSize.height >
                178.0
            ? TvUi.featuredHeight
            : screenHeight - TvUi.navigationBarSize.height - 178.0;
    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final positionAnimation = useAnimation<double>(Tween(
      begin: -featuredHeight - 40.0,
      end: 40.0,
    ).animate(animationController));
    final opacityAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController));
    // final heightAnimation = useAnimation<double>(Tween(
    //   begin: 0.0,
    //   end: TvUi.featuredHeight,
    // ).animate(animationController));

    /// вычисляем цвет свечения
    useEffect(() {
      animationController.forward();

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    final focusedMediaItem = ref.watch(focusedMediaItemProvider(mediaItem));

    final currentMediaItem =
        focusedMediaItem.valueOrNull ?? MediaItem.skeleton();

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: mediaItem == null ? 0.0 : featuredHeight,
      color: theme.colorScheme.surface,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(TvUi.navigationBarSize.height),
            right: 0.0,
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child:
                  currentMediaItem.backdrop.isEmpty || currentMediaItem.isFolder
                      ? null
                      : BackdropImage(currentMediaItem.backdrop),
            ),
          ),
          Positioned(
            bottom: positionAnimation,
            left: TvUi.hPadding,
            child: Skeletonizer(
              enabled: focusedMediaItem.isLoading,
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
                          child: Text(
                            mediaItem != null
                                ? [
                                    currentMediaItem.genres.joinFirstTwo(),
                                    currentMediaItem.year,
                                    currentMediaItem.countries.joinFirstTwo(),
                                    currentMediaItem.overviewDuration(context),
                                    currentMediaItem.ratingStars,
                                  ].removeEmpty().join(' • ')
                                : '',
                          ),
                        ),
                      ),

                      /// название
                      Text(
                        mediaItem != null ? currentMediaItem.title : '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 32.0,
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      /// описание
                      if (mediaItem != null &&
                          currentMediaItem.overview.isNotEmpty)
                        Text(
                          currentMediaItem.overview,
                          key: const ValueKey('overview'),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),

                      const SizedBox(height: 28.0),

                      Wrap(
                        spacing: 24.0,
                        children: [
                          /// забликирован ли контент
                          if (mediaItem?.blocked == true)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: theme.colorScheme.error,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  'Заблокировано правообладателем',
                                  style: TextStyle(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedCardBackground extends HookWidget {
  final MediaItem? mediaItem;
  // final Widget? child;

  const FeaturedCardBackground(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final featuredHeight =
        screenHeight - TvUi.featuredHeight - TvUi.navigationBarSize.height >
                178.0
            ? TvUi.featuredHeight
            : screenHeight - TvUi.navigationBarSize.height - 178.0;
    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final positionAnimation = useAnimation<double>(Tween(
      begin: -featuredHeight - 40.0,
      end: 40.0,
    ).animate(animationController));
    final opacityAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController));
    // final heightAnimation = useAnimation<double>(Tween(
    //   begin: 0.0,
    //   end: TvUi.featuredHeight,
    // ).animate(animationController));

    /// вычисляем цвет свечения
    useEffect(() {
      animationController.forward();

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: mediaItem == null ? 0.0 : featuredHeight,
      color: theme.colorScheme.surface,
    );
  }
}
