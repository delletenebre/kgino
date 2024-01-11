import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/media_item.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/lists/vertical_grouped_list_view.dart';
import '../ui/lists/vertical_list_view.dart';
import '../ui/pages/krs_app_bar.dart';
import '../ui/pages/playlist/krs_list_tile.dart';
import '../ui/pages/playlist/playlist_episode_tile.dart';

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

    final episodes = useMemoized(() => mediaItem.episodes);

    final seasonsKey = GlobalKey<VerticalListViewState>();
    final episodesKey = GlobalKey<VerticalListViewState>();
    // final episodesKey = GlobalKey<VerticalGroupedListViewState>();

    final selectedSeasonIndex = useValueNotifier(0);
    final selectedEpisodeIndex = useRef(0);
    final ignoreFocusUpdate = useRef(false);

    scrollEpisodesBySeason(int index) {
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
          .fold(0, (value, season) => value + season.episodes.length);

      /// максимальный индекс эпизода в нужном сезоне
      int maxIndex = minIndex + season.episodes.length;

      if (selectedEpisodeIndex.value < minIndex ||
          selectedEpisodeIndex.value >= maxIndex) {
        /// ^ если текущий выбранный эпизод не в выбранном сезоне

        /// прокручиваем список к первому эпизоду выбранного сезона
        episodesKey.currentState?.scrollTo(minIndex);

        /// обновляем индексы эпизода и сезона
        selectedSeasonIndex.value = seasonIndex;
        selectedEpisodeIndex.value = minIndex;
      } else {
        /// ^ если текущий выбранный эпизод из выбранного сезона

        /// обновляем индекс сезона
        selectedSeasonIndex.value = seasonIndex;
      }
    }

    int episodesOffset = 0;
    int seasonsOffset = 0;
    List<int> seasonEpisodesMap = [0];
    final groupedEpisodes = <GroupedListViewItem>[];
    for (final season in mediaItem.seasons) {
      seasonsOffset++;

      /// количество эпизодов в текущем сезоне
      final episodesCount = season.episodes.length;
      groupedEpisodes.addAll(
        List.generate(episodesCount, (index) {
          return GroupedListViewItem(
            group: season.nameOr('${locale.season} $seasonsOffset'),
            groupIndex: seasonsOffset,
            index: episodesOffset + index,
          );
        }),
      );
      episodesOffset += episodesCount;
    }
    seasonEpisodesMap[0] = 0;

    return Scaffold(
      appBar: const KrsAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: TvUi.hPadding),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// обложка сериала
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 124.0,
                          height: 124.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: CachedNetworkImage(
                              imageUrl: mediaItem.poster,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),

                        /// отступ
                        const SizedBox(height: 12.0),

                        /// название сериала
                        Text(
                          mediaItem.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),

                /// сезоны
                Expanded(
                  child: VerticalListView(
                    key: seasonsKey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: TvUi.hPadding,
                      vertical: TvUi.vPadding,
                    ),
                    separatorHeight: 12.0,
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        ignoreFocusUpdate.value = true;
                      }
                    },
                    itemCount: mediaItem.seasons.length,
                    itemBuilder: (context, index) {
                      final season = mediaItem.seasons[index];
                      return ValueListenableBuilder(
                        valueListenable: selectedSeasonIndex,
                        builder: (context, value, _) => KrsListTile(
                          selected: selectedSeasonIndex.value == index,
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              /// прокручиваем эпизоды к выбранному сезону
                              scrollEpisodesBySeason(index);
                            }
                          },
                          onSelect: () {
                            /// при выборе сезона перемещаем фокус на список эпизодов
                            FocusScope.of(context).nextFocus();
                          },
                          onTap: () {
                            /// прокручиваем эпизоды к нажатому сезону
                            scrollEpisodesBySeason(index);
                          },
                          title: season.nameOr('${locale.season} ${index + 1}'),
                          subtitle:
                              locale.episodesCount(season.episodes.length),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// разделитель между сезонами и эпизодами
          // const SizedBox(
          //   width: 20.0 + 52.0 + 20.0,
          // ),

          /// эпизоды
          // Expanded(
          //   child: VerticalGroupedListView(
          //     key: episodesKey,
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: TvUi.hPadding,
          //       vertical: 128.0,
          //     ),
          //     separatorHeight: 0.0,
          //     requestItemIndex: () => selectedEpisodeIndex.value,
          //     elements: groupedEpisodes,
          //     itemBuilder: (context, index) {
          //       final episode = episodes[index];
          //
          //       final item = Padding(
          //         padding: const EdgeInsets.only(bottom: 12.0),
          //         child: PlaylistEpisodeTile(
          //           episode: episode,
          //           onFocusChange: (hasFocus) {
          //             if (hasFocus) {
          //               final episodeIndex = index;
          //               int episodesOffset = 0;
          //
          //               for (int i = 0; i < mediaItem.seasons.length; i++) {
          //                 /// текущий сезон
          //                 final season = mediaItem.seasons[i];
          //
          //                 /// количество эпизодов в текущем сезоне
          //                 final episodesCount = season.episodes.length;
          //
          //                 /// относительный индекс эпизода в нужном сезоне
          //                 final index = episodeIndex - episodesOffset;
          //
          //                 if (episodesCount > index) {
          //                   /// обновляем индекс сезона
          //
          //                   selectedSeasonIndex.value = i;
          //
          //                   /// прокручиваем список сезонов к выбранному сезону
          //                   seasonsKey.currentState
          //                       ?.scrollTo(selectedSeasonIndex.value);
          //
          //                   break;
          //                 }
          //                 episodesOffset += episodesCount;
          //               }
          //
          //               /// обновляем индекс эпизода
          //               selectedEpisodeIndex.value = episodeIndex;
          //             }
          //           },
          //           onTap: () {
          //             /// переходим на страницу плеера фильма
          //             context.pushReplacementNamed(
          //               'player',
          //               queryParameters: {
          //                 'episodeIndex': '$index',
          //               },
          //               extra: mediaItem,
          //             );
          //           },
          //         ),
          //       );
          //
          //       return Padding(
          //         padding: const EdgeInsets.only(bottom: 12.0),
          //         child: PlaylistEpisodeTile(
          //           episode: episode,
          //           onFocusChange: (hasFocus) {
          //             if (hasFocus) {
          //               final episodeIndex = index;
          //               int episodesOffset = 0;
          //
          //               for (int i = 0; i < mediaItem.seasons.length; i++) {
          //                 /// текущий сезон
          //                 final season = mediaItem.seasons[i];
          //
          //                 /// количество эпизодов в текущем сезоне
          //                 final episodesCount = season.episodes.length;
          //
          //                 /// относительный индекс эпизода в нужном сезоне
          //                 final index = episodeIndex - episodesOffset;
          //
          //                 if (episodesCount > index) {
          //                   /// обновляем индекс сезона
          //
          //                   selectedSeasonIndex.value = i;
          //
          //                   /// прокручиваем список сезонов к выбранному сезону
          //                   seasonsKey.currentState
          //                       ?.scrollTo(selectedSeasonIndex.value);
          //
          //                   break;
          //                 }
          //                 episodesOffset += episodesCount;
          //               }
          //
          //               /// обновляем индекс эпизода
          //               selectedEpisodeIndex.value = episodeIndex;
          //             }
          //           },
          //           onTap: () {
          //             /// переходим на страницу плеера фильма
          //             context.pushReplacementNamed(
          //               'player',
          //               queryParameters: {
          //                 'episodeIndex': '$index',
          //               },
          //               extra: mediaItem,
          //             );
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedSeasonIndex,
                  builder: (context, seasonIndex, _) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      mediaItem.seasons[seasonIndex].name,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: VerticalListView(
                    key: episodesKey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: TvUi.hPadding,
                      vertical: TvUi.vPadding,
                    ),
                    listOffset: 64.0,
                    separatorHeight: 0.0,
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final episode = episodes[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: PlaylistEpisodeTile(
                          episode: episode,
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              final episodeIndex = index;
                              int episodesOffset = 0;

                              for (int i = 0;
                                  i < mediaItem.seasons.length;
                                  i++) {
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
                                  seasonsKey.currentState?.scrollTo(
                                    selectedSeasonIndex.value,
                                  );

                                  break;
                                }
                                episodesOffset += episodesCount;
                              }

                              /// обновляем индекс эпизода
                              selectedEpisodeIndex.value = episodeIndex;
                            }
                          },
                          onTap: (position) {
                            /// переходим на страницу плеера
                            context.pushReplacementNamed(
                              'player',
                              queryParameters: {
                                'episodeIndex': '$index',
                                'initialPosition': '$position',
                              },
                              extra: mediaItem,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
