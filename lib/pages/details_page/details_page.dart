import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/media_item.dart';
import '../../providers/locale_provider.dart';
import '../../providers/storage_provider.dart';
import '../../resources/kika_theme.dart';
import '../../ui/animated_loading.dart';
import '../../ui/cards/featured_card.dart';
import '../../ui/kika_scroll_view.dart';
import '../../ui/try_again_message.dart';
import 'ui/bookmark_button.dart';
import 'ui/play_button.dart';
import 'ui/seasons_view.dart';
import 'ui/voice_acting_button.dart';

part 'details_page.g.dart';

@riverpod
class Details extends _$Details {
  @override
  Future<MediaItem?> build(MediaItem mediaItem) => fetch();

  Future<MediaItem?> fetch() async {
    final storage = ref.read(storageProvider);

    /// если есть, то находим сохранённую в базе данных информацию
    final savedItem = mediaItem.findSaved(storage);

    /// загружаем информацию о сериале или фильме
    final item = await savedItem.loadDetails(ref, CancelToken());

    /// загружаем сезоны
    final seasons = await item.loadSeasons(ref);

    /// объединяем информацию с сезонами
    item.seasons = seasons;

    /// загружаем варианты озвучки
    final voices = await item.loadVoices(ref);

    /// объединяем информацию с вариантами озвучки
    item.voices = voices;

    return item;
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
    final locale = Locale.of(context);

    final storage = ref.read(storageProvider);

    /// контроллер информации о сериале или фильме
    final details = ref.watch(detailsProvider(mediaItem));

    final buttonsContainerFocusNode = useFocusNode();

    return Scaffold(
      body: details.when(
        skipLoadingOnReload: false,
        skipLoadingOnRefresh: false,
        loading: () => const AnimatedLoading(size: 96.0),
        error: (error, stackTrace) => TryAgainMessage(
          imageUrl: mediaItem.poster,
          onRetry: () {
            ref.invalidate(detailsProvider);
          },
        ),
        data: (mediaItem) => HookBuilder(
          builder: (context) {
            final scrollController = useScrollController();
            final isScrolling = useState(false);

            return KikaScrollView(
              scrollController: scrollController,
              onStartScroll: (scrollMetrics) {
                isScrolling.value = true;
              },
              onEndScroll: (scrollMetrics) {
                isScrolling.value = false;
              },
              children: [
                /// основная информация
                FeaturedCard(
                  mediaItem,
                  padding: const EdgeInsets.symmetric(horizontal: 56.0),
                  expanded: true,
                ),

                const SizedBox(height: 24.0),

                /// кнопки управления
                Focus(
                  focusNode: buttonsContainerFocusNode,
                  canRequestFocus: false,
                  skipTraversal: true,
                  onFocusChange: (hasFocus) {
                    if (hasFocus && !isScrolling.value) {
                      scrollController.animateTo(
                        0.0,
                        duration: kThemeAnimationDuration,
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  onKeyEvent: (node, event) {
                    if (HardwareKeyboard.instance
                        .isLogicalKeyPressed(LogicalKeyboardKey.escape)) {
                      context.pop();
                      return KeyEventResult.handled;
                    }

                    if (HardwareKeyboard.instance
                        .isLogicalKeyPressed(LogicalKeyboardKey.arrowRight)) {
                      if (buttonsContainerFocusNode.children.last.hasFocus) {
                        /// если выбран последний элемент, то предотвращаем
                        /// смену фокуса при нажатии вправо
                        return KeyEventResult.handled;
                      }
                    }

                    if (HardwareKeyboard.instance
                        .isLogicalKeyPressed(LogicalKeyboardKey.arrowLeft)) {
                      if (buttonsContainerFocusNode.children.first.hasFocus) {
                        /// если выбран первый элемент, то предотвращаем
                        /// смену фокуса при нажатии влево
                        return KeyEventResult.handled;
                      }
                    }

                    return KeyEventResult.ignored;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 56.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        if (mediaItem!.blocked == true)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: FilledButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(locale.back),
                            ),
                          ),

                        /// кнопка начала просмотра
                        if (mediaItem.blocked == false)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: PlayButton(mediaItem),
                          ),

                        /// кнопка добавления или удаления из закладок
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: BookmarkButton(mediaItem),
                        ),

                        /// кнопка выбора озвучки
                        if (mediaItem.voices.length > 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: VoiceActingButton(
                              mediaItem,
                              onVoiceActingChange: (voiceActing) async {
                                /// изменяем выбранную озвучку
                                mediaItem.voiceActing = voiceActing;

                                if (mediaItem.onlineService ==
                                    OnlineService.tskg) {
                                  mediaItem.id = voiceActing.id;
                                }

                                /// сохраняем изменения выбранной озвучки
                                mediaItem.save(storage).then((_) {
                                  /// обновляем страницу деталей
                                  context.pushReplacementNamed(
                                    'details',
                                    extra: mediaItem,
                                  );
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                /// если это сериал - показываем плейлист
                if (mediaItem.isShow)
                  Focus(
                    canRequestFocus: false,
                    skipTraversal: true,
                    onFocusChange: (hasFocus) {
                      if (hasFocus && !isScrolling.value) {
                        scrollController.position.moveTo(
                          kCardMaxHeight + 48.0,
                          duration: kThemeAnimationDuration,
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: SeasonsView(mediaItem),
                  ),

                const SizedBox(height: 48.0),
              ],
            );
          },
        ),
      ),
    );
  }
}
