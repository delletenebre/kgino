import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../models/media_item.dart';
import '../providers/providers.dart';
import '../resources/constants.dart';
import '../ui/cards/featured_card.dart';
import '../ui/details_page/bookmark_button.dart';
import '../ui/details_page/play_button.dart';
import '../ui/details_page/voice_actings_button.dart';
import '../ui/krs_scroll_view.dart';
import '../ui/try_again_message.dart';

part 'details_page.g.dart';

@riverpod
class Details extends _$Details {
  @override
  Future<MediaItem?> build(MediaItem? mediaItem) async {
    return fetch();
  }

  Future<MediaItem?> fetch() async {
    final storage = ref.read(storageProvider);
    final savedItem = mediaItem?.findSaved(storage) ?? mediaItem;
    print('savedItem: ${savedItem?.toJson()}');

    return await savedItem?.loadDetails(ref);
  }

  bool get hasItem => state.valueOrNull != null;
}

class DetailsPage extends HookConsumerWidget {
  final MediaItem mediaItem;
  final secondContainerKey = GlobalKey();

  DetailsPage(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final locale = KrsLocale.of(context);

    /// размер экрана
    final screenSize = MediaQuery.of(context).size;

    final storage = ref.read(storageProvider);

    final details = ref.watch(detailsProvider(mediaItem));

    return Scaffold(
      body: details.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => TryAgainMessage(
          imageUrl: mediaItem.poster,
          onRetry: () {},
        ),
        data: (mediaItem) => HookBuilder(
          builder: (context) {
            final scrollController = useScrollController();
            final isScrolling = useState(false);

            // final playButtonHasFocus = useState(false);
            final secondContainerPosition = useState(0.0);

            /// вычисляем позицию второго контейнера, если он есть
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              final box = secondContainerKey.globalPaintBounds;
              if (box != null) {
                secondContainerPosition.value = box.top;
              }
            });

            return KrsScrollView(
              scrollController: scrollController,
              onStartScroll: (scrollMetrics) {
                isScrolling.value = true;
              },
              onEndScroll: (scrollMetrics) {
                isScrolling.value = false;
              },
              children: [
                SizedBox(
                  height: screenSize.height,
                  child: Column(
                    children: [
                      SizedBox(height: TvUi.navigationBarSize.height),
                      FeaturedCard(mediaItem),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Focus(
                        canRequestFocus: false,
                        skipTraversal: true,
                        onFocusChange: (hasFocus) {
                          if (hasFocus && !isScrolling.value) {
                            scrollController.animateTo(
                              0.0,
                              duration: KrsTheme.animationDuration,
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: TvUi.hPadding,
                            vertical: TvUi.vPadding,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// если кнопка Смотреть в фокусе
                                  // if (playButtonHasFocus.value)
                                  // PlayButtonTooltip(
                                  //   kginoItem,
                                  //   showEpisodeNumber: false,
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  /// кнопка начала просмотра
                                  PlayButton(
                                    mediaItem!,
                                    onFocusChange: (hasFocus) {
                                      // playButtonHasFocus.value = hasFocus;
                                    },
                                  ),

                                  /// если файлов несколько, показываем кнопку выбора
                                  /// эпизода
                                  // if (mediaItem.seasons.first.episodes.length >
                                  //     1)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: FilledButton(
                                      onPressed: () {
                                        /// переходим на страницу выбора файла
                                        context.pushNamed(
                                          'playlist',
                                          extra: mediaItem,
                                        );
                                      },
                                      child: Text(locale.selectEpisode),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text('BACK'),
                                  ),

                                  /// кнопка добавления или удаления из закладок
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: BookmarkButton(mediaItem),
                                  ),

                                  /// кнопка выбора озвучки
                                  if (mediaItem.voiceActings.length > 1)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: VoiceActingsButton(
                                        mediaItem,
                                        onVoiceActingChange:
                                            (voiceActing) async {
                                          mediaItem.voiceActing = voiceActing;

                                          await mediaItem.save(storage);

                                          /// обновляем страницу деталей
                                          context.goNamed('details',
                                              extra: mediaItem);
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Focus(
                //   key: secondContainerKey,
                //   canRequestFocus: false,
                //   skipTraversal: true,
                //   onFocusChange: (hasFocus) {
                //     if (hasFocus && !isScrolling.value) {
                //       scrollController.animateTo(secondContainerPosition.value,
                //         duration: KrsTheme.animationDuration,
                //         curve: Curves.easeIn,
                //       );
                //     }
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(24.0),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [

                //         Container(
                //           height: MediaQuery.of(context).size.height,
                //           child: FilledButton(
                //             onPressed: () {

                //             },
                //             child: Text('button 3'),
                //           ),
                //         ),

                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}
