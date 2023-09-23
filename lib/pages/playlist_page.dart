import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../hooks/list_observer_controller_hook.dart';
import '../models/media_item.dart';
import '../resources/constants.dart';
import '../resources/krs_locale.dart';
import '../ui/cards/krs_list_tile.dart';
import '../ui/lists/vertical_list_view.dart';

class PlaylistPage extends HookConsumerWidget {
  final MediaItem mediaItem;

  const PlaylistPage(
    this.mediaItem, {
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final episodes = useMemoized(() => mediaItem.episodes());

    final seasonsListObserverController = useListObserverController();
    final episodesListObserverController = useListObserverController();

    final selectedSeasonIndex = useValueNotifier(0);
    final selectedEpisodeIndex = useRef(0);
    final ignoreFocusUpdate = useRef(false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: TvUi.navigationBarSize,
        child: SizedBox(
          height: TvUi.navigationBarSize.height,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 412.0 - 52.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// обложка сериала или фильма
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 124.0,
                          height: 124.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              mediaItem.poster,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          mediaItem.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  /// сезоны
                  Expanded(
                    child: VerticalListView(
                      key: const ValueKey('seasonsList'),
                      clipBehavior: Clip.none,
                      controller: seasonsListObserverController,
                      keyEventResult: KeyEventResult.handled,
                      requestItemIndex: () => selectedSeasonIndex.value,
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          ignoreFocusUpdate.value = true;
                        }
                      },
                      itemCount: mediaItem.seasons.length,
                      itemBuilder: (context, index) {
                        final season = mediaItem.seasons[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ValueListenableBuilder(
                            valueListenable: selectedSeasonIndex,
                            builder: (context, value, _) => KrsListTile(
                              selected: selectedSeasonIndex.value == index,
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  if (ignoreFocusUpdate.value) {
                                    ignoreFocusUpdate.value = false;
                                    if (index != selectedSeasonIndex.value) {
                                      return;
                                    }
                                  }

                                  selectedSeasonIndex.value = index;

                                  final seasonIndex = selectedSeasonIndex.value;
                                  final season = mediaItem.seasons[seasonIndex];
                                  final minIndex = mediaItem.seasons
                                      .take(seasonIndex)
                                      .fold(
                                          0,
                                          (value, season) =>
                                              value + season.episodes.length);

                                  /// максимальный индекс эпизода в нужном сезоне
                                  int maxIndex =
                                      minIndex + season.episodes.length;

                                  if (selectedEpisodeIndex.value < minIndex ||
                                      selectedEpisodeIndex.value >= maxIndex) {
                                    /// ^ если текущий выбранный эпизод не в выбранном сезоне

                                    /// прокручиваем список к первому эпизоду выбранного сезона
                                    episodesListObserverController.animateTo(
                                      index: minIndex,
                                      isFixedHeight: true,
                                      offset: (offset) => 0.0,
                                      duration:
                                          const Duration(milliseconds: 50),
                                      curve: Curves.easeIn,
                                    );

                                    /// обновляем индексы эпизода и сезона
                                    selectedSeasonIndex.value = seasonIndex;
                                    selectedEpisodeIndex.value = minIndex;
                                  } else {
                                    /// ^ если текущий выбранный эпизод из выбранного сезона

                                    /// обновляем индекс сезона
                                    selectedSeasonIndex.value = seasonIndex;
                                  }
                                }
                              },
                              onTap: () {},
                              title: '${locale.season} ${season.name}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// разделитель между сезонами и эпизодами
            const SizedBox(
              width: 20.0 + 52.0 + 20.0,
            ),

            /// эпизоды
            Expanded(
              child: VerticalListView(
                key: const ValueKey('episodesList'),
                keyEventResult: KeyEventResult.handled,
                clipBehavior: Clip.none,
                controller: episodesListObserverController,
                requestItemIndex: () => selectedEpisodeIndex.value,
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: KrsListTile(
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          final episodeIndex = index;
                          int episodesOffset = 0;

                          for (int i = 0; i < mediaItem.seasons.length; i++) {
                            /// текущий сезон
                            final season = mediaItem.seasons[i];

                            /// количество эпизодов в текущем сезоне
                            final episodesCount = season.episodes.length;

                            /// относительный индекс эпизода в нужном сезоне
                            final index = episodeIndex - episodesOffset;

                            if (episodesCount > index) {
                              /// обновляем индекс сезона

                              selectedSeasonIndex.value = i;

                              /// прокручиваем список сезонов к выбранному сезону
                              seasonsListObserverController.animateTo(
                                index: selectedSeasonIndex.value,
                                isFixedHeight: true,
                                offset: (offset) => 0.0,
                                duration: const Duration(milliseconds: 50),
                                curve: Curves.easeIn,
                              );

                              break;
                            }
                            episodesOffset += episodesCount;
                          }

                          /// обновляем индекс эпизода
                          selectedEpisodeIndex.value = episodeIndex;
                        }
                      },
                      onTap: () {
                        /// переходим на страницу плеера фильма
                        context.pushReplacementNamed(
                          'player',
                          queryParameters: {
                            'episodeIndex': '$index',
                          },
                          extra: mediaItem,
                        );
                      },
                      title: 'Эпизод ${index + 1}',
                      subtitle:
                          '${episode.seasonNumber}x${episode.episodeNumber}',
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('BACK'),
            ),
          ],
        ),
      ),
    );
  }
}
