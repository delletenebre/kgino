import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../extensions/list_extensions.dart';
import '../../models/media_item.dart';
import '../../resources/kika_theme.dart';
import '../navigation/kika_navigation_rail.dart';
import 'backdrop_image.dart';

part 'featured_card.g.dart';

@riverpod
class FocusedMediaItem extends _$FocusedMediaItem {
  @override
  FutureOr<MediaItem?> build(MediaItem mediaItem) async {
    return fetchDetails();
  }

  Future<MediaItem> fetchDetails() async {
    if (mediaItem.isNotFolder) {
      /// отменяем выполнение запроса, если страница закрыта
      final cancelToken = CancelToken();
      ref.onCancel(() {
        cancelToken.cancel();
      });

      return mediaItem.loadDetails(ref, cancelToken);
    }

    return mediaItem;
  }

  // void reset() {
  //   state = const AsyncData(null);
  // }

  bool get hasItem => state.valueOrNull != null;
}

class FeaturedCard extends HookConsumerWidget {
  final MediaItem? mediaItem;
  final EdgeInsetsGeometry? padding;
  final bool expanded;

  const FeaturedCard(
    this.mediaItem, {
    super.key,
    this.padding,
    this.expanded = false,
  });

  @override
  Widget build(context, ref) {
    if (mediaItem == null) {
      return SizedBox(height: TvUi.featuredSize.height);
    }

    final theme = Theme.of(context);

    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    // final positionAnimation = useAnimation<double>(Tween(
    //   begin: -TvUi.featuredSize.height - 40.0,
    //   end: 40.0,
    // ).animate(animationController));
    final opacityAnimation = useAnimation<double>(Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController));
    // final heightAnimation = useAnimation<double>(Tween(
    //   begin: 0.0,
    //   end: TvUi.featuredHeight,
    // ).animate(animationController));

    /// запускаем анимацию
    useEffect(() {
      animationController.forward();

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    final detailedMediaItemProvider =
        ref.watch(focusedMediaItemProvider(mediaItem!));

    final currentMediaItem =
        detailedMediaItemProvider.valueOrNull ?? mediaItem!;

    return SizedBox(
      height: TvUi.featuredSize.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0.0,
            right: 0.0,
            child: BackdropImage(
              key: ValueKey(currentMediaItem.backdrop),
              imageUrl: currentMediaItem.backdrop,
              placeholderUrl: mediaItem!.poster,
            ),
            //     AnimatedSwitcher(
            // duration: kThemeAnimationDuration,
            // transitionBuilder: (child, animation) {
            //   return child;
            // },
            // child: BackdropImage(
            //     key: ValueKey(currentMediaItem.backdrop),
            //     currentMediaItem.backdrop)),
          ),
          Positioned(
            top: 56.0,
            left: (padding?.horizontal ??
                    (KikaNavigationRailState.minWidth + 48.0) * 2) /
                2,
            child: SizedBox(
              width: TvUi.featuredSize.width,
              child: Opacity(
                opacity: opacityAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: SizedBox(
                        height: 16.0,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 12.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          child: AnimatedSwitcher(
                            duration: kThemeAnimationDuration * 2,
                            reverseDuration: Duration.zero,
                            child: detailedMediaItemProvider.when(
                              data: (data) => (currentMediaItem.blocked == true)

                                  /// если контент заблокирован
                                  ? Text(
                                      key: const ValueKey('blocked'),
                                      currentMediaItem.blockedStatus ??
                                          'Заблокировано правообладателем',
                                      style: TextStyle(
                                          color: theme.colorScheme.error),
                                    )

                                  /// жанры, год, страны, продолжительность
                                  : Text(
                                      key: const ValueKey('information'),
                                      [
                                        currentMediaItem.genres.joinFirstTwo(),
                                        currentMediaItem.year,
                                        currentMediaItem.countries
                                            .joinFirstTwo(),
                                        currentMediaItem
                                            .overviewDuration(context),
                                        currentMediaItem.ratingStars,
                                      ].removeEmpty().join(' • '),
                                    ),
                              error: (error, stackTrace) {
                                debugPrint(error.toString());
                                debugPrint(stackTrace.toString());
                                return Text(
                                  'Информация недоступна',
                                  key: const ValueKey('not availables'),
                                );
                              },
                              loading: () => Text(
                                '...',
                                key: const ValueKey('loading'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// название
                    Text(
                      currentMediaItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge,
                    ),

                    // Image.network(
                    //     'https://image.tmdb.org/t/p/h100/h4wmx7DvJVj5MUHdes5Bnw0jUBf.png'),

                    const SizedBox(height: 20.0),

                    /// описание
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      child: AnimatedSwitcher(
                        duration: kThemeAnimationDuration * 2,
                        reverseDuration: Duration.zero,
                        child: Text(
                          currentMediaItem.overviewText.isEmpty
                              ? '...'
                              : currentMediaItem.overviewText,
                          key: ValueKey(currentMediaItem.overviewText),
                        ),
                      ),
                    ),

                    if (expanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          children: [
                            if (mediaItem?.voiceActing.name.isEmpty == false)
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: theme.colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Iconsax.microphone_2,
                                      size: 14.0,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      mediaItem?.voiceActing.name ?? '',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
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
