import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../resources/krs_theme.dart';
import '../models/media_item.dart';
import '../providers/providers.dart';
import '../resources/krs_locale.dart';
import '../ui/cards/featured_card.dart';
import '../ui/krs_scroll_view.dart';
import '../ui/pages/details_page/play_button.dart';
import '../ui/pages/details_page/voice_acting_button.dart';
import '../ui/pages/krs_app_bar.dart';
import '../ui/try_again_message.dart';

part 'details_page.g.dart';

@riverpod
class Details extends _$Details {
  @override
  Future<MediaItem?> build(MediaItem mediaItem) async {
    return fetch();
  }

  Future<MediaItem?> fetch() async {
    final storage = ref.read(storageProvider);

    /// если есть, то находим сохранённую в базе данных информацию
    final savedItem = mediaItem.findSaved(storage);

    /// загружаем информацию о сериале или фильме
    final item = await savedItem.loadDetails(ref);

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
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// размер экрана
    final screenSize = MediaQuery.of(context).size;

    final storage = ref.read(storageProvider);

    /// контроллер информации о сериале или фильме
    final details = ref.watch(detailsProvider(mediaItem));

    return Scaffold(
      body: details.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => TryAgainMessage(
          imageUrl: mediaItem.poster,
          onRetry: () {
            ref.read(detailsProvider(mediaItem).notifier).fetch();
          },
        ),
        data: (mediaItem) => HookBuilder(
          builder: (context) {
            final scrollController = useScrollController();
            final isScrolling = useState(false);

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// отступ навигационной панели
                      KrsAppBar(
                        children: [
                          /// онлайн-кинотеатр
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.smart_display_outlined,
                                size: 16.0,
                                color: theme.colorScheme.outline,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                (mediaItem?.onlineService ==
                                        OnlineService.filmix)
                                    ? 'Filmix'
                                    : 'TS.KG',
                                style: TextStyle(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),

                          /// озвучка
                          if (mediaItem?.voiceActing.name.isNotEmpty == true)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mic_outlined,
                                  size: 16.0,
                                  color: theme.colorScheme.outline,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  mediaItem!.voiceActing.name,
                                  style: TextStyle(
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      /// основная информация
                      FeaturedCard(mediaItem),

                      /// пустой отступ
                      const Expanded(
                        child: SizedBox(),
                      ),

                      /// кнопки управления
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
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 24.0,
                            runSpacing: 12.0,
                            children: [
                              /// кнопка начала просмотра
                              if (mediaItem!.blocked == false)
                                PlayButton(
                                  mediaItem,
                                  onFocusChange: (hasFocus) {
                                    // playButtonHasFocus.value = hasFocus;
                                  },
                                ),

                              /// если сериал, показываем кнопку выбора эпизода
                              if (mediaItem.type == MediaItemType.show)
                                FilledButton(
                                  onPressed: () {
                                    /// переходим на страницу выбора файла
                                    context.pushNamed(
                                      'playlist',
                                      extra: mediaItem,
                                    );
                                  },
                                  child: Text(locale.selectEpisode),
                                ),

                              /// кнопка добавления или удаления из закладок
                              // BookmarkButton(mediaItem),

                              /// кнопка выбора озвучки
                              if (mediaItem.voices.length > 1)
                                VoiceActingButton(
                                  mediaItem,
                                  onVoiceActingChange: (voiceActing) async {
                                    /// изменяем выбранную озвучку
                                    mediaItem.voiceActing = voiceActing;

                                    if (mediaItem.onlineService ==
                                        OnlineService.tskg) {
                                      mediaItem.id = voiceActing.id;
                                    }

                                    /// сохраняем изменения выбранной озвучки
                                    mediaItem.save(storage);

                                    print('zzzz1z ${mediaItem.isarId}');

                                    /// обновляем страницу деталей
                                    // ignore: use_build_context_synchronously
                                    context.pushReplacementNamed(
                                      'details',
                                      extra: mediaItem,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
