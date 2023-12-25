import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../hooks/list_observer_controller_hook.dart';
import '../models/media_item.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/lists/vertical_list_view.dart';
import '../ui/pages/krs_app_bar.dart';
import '../ui/pages/playlist/krs_list_tile.dart';

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

    final seasonsListObserverController = useListObserverController();
    final episodesListObserverController = useListObserverController();
    final episodesListFocusNode = useFocusNode();

    final selectedSeasonIndex = useValueNotifier(0);
    final selectedEpisodeIndex = useRef(0);
    final ignoreFocusUpdate = useRef(false);

    int episodesOffset = 0;
    List<int> seasonEpisodesMap = [0];
    for (final season in mediaItem.seasons) {
      /// количество эпизодов в текущем сезоне
      final episodesCount = season.episodes.length;
      seasonEpisodesMap.add(
          seasonEpisodesMap.fold(0, (value, index) => value + index) +
              episodesCount);
    }
    seasonEpisodesMap[0] = 0;

    final itemScrollController = GroupedItemScrollController();

    return Scaffold(
      appBar: const KrsAppBar(),
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
                            child: CachedNetworkImage(
                              imageUrl: mediaItem.poster,
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
                      padding: const EdgeInsets.all(18.0),
                      separatorHeight: 12.0,
                      listObserverController: seasonsListObserverController,
                      autofocus: true,
                      // keyEventResult: KeyEventResult.handled,
                      requestItemIndex: () => selectedSeasonIndex.value,
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
                                    duration: kThemeAnimationDuration,
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
                            onSelect: () {
                              episodesListFocusNode.requestFocus();
                            },
                            onTap: () {
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
                              int maxIndex = minIndex + season.episodes.length;

                              if (selectedEpisodeIndex.value < minIndex ||
                                  selectedEpisodeIndex.value >= maxIndex) {
                                /// ^ если текущий выбранный эпизод не в выбранном сезоне

                                /// прокручиваем список к первому эпизоду выбранного сезона
                                episodesListObserverController.animateTo(
                                  index: minIndex,
                                  isFixedHeight: true,
                                  offset: (offset) => 0.0,
                                  duration: kThemeAnimationDuration,
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
                            },
                            title:
                                season.nameOr('${locale.season} ${index + 1}'),
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
            const SizedBox(
              width: 20.0 + 52.0 + 20.0,
            ),

            /// эпизоды

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
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StickyGroupedListView<dynamic, String>(
                      elements: List.generate(
                          50,
                          (index) => {
                                'group': 'zzzz',
                                'name': index.toString(),
                              }),
                      groupBy: (element) => element['group'],
                      groupSeparatorBuilder: (dynamic element) => SizedBox(),
                      itemBuilder: (context, dynamic element) =>
                          Text(element['name']),
                      itemComparator: (e1, e2) =>
                          e1['name'].compareTo(e2['name']), // optional
                      elementIdentifier: (element) => element.name,
                      itemScrollController: itemScrollController,
                      order: StickyGroupedListOrder.ASC,
                    ),
                    // VerticalListView(
                    //         key: const ValueKey('episodesList'),
                    //         padding: const EdgeInsets.all(20.0),
                    //         listOffset: 64.0,
                    //         focusNode: episodesListFocusNode,
                    //         separatorHeight: 0.0,
                    //         listObserverController: episodesListObserverController,
                    //         // keyEventResult: KeyEventResult.handled,
                    //         requestItemIndex: () => selectedEpisodeIndex.value,
                    //         itemCount: episodes.length,
                    //         itemBuilder: (context, index) {
                    //           final episode = episodes[index];
                    //
                    //           final item = Padding(
                    //             padding: const EdgeInsets.only(bottom: 12.0),
                    //             child: PlaylistEpisodeTile(
                    //               episode: episode,
                    //               onFocusChange: (hasFocus) {
                    //                 if (hasFocus) {
                    //                   final episodeIndex = index;
                    //                   int episodesOffset = 0;
                    //
                    //                   for (int i = 0;
                    //                       i < mediaItem.seasons.length;
                    //                       i++) {
                    //                     /// текущий сезон
                    //                     final season = mediaItem.seasons[i];
                    //
                    //                     /// количество эпизодов в текущем сезоне
                    //                     final episodesCount = season.episodes.length;
                    //
                    //                     /// относительный индекс эпизода в нужном сезоне
                    //                     final index = episodeIndex - episodesOffset;
                    //
                    //                     if (episodesCount > index) {
                    //                       /// обновляем индекс сезона
                    //
                    //                       selectedSeasonIndex.value = i;
                    //
                    //                       /// прокручиваем список сезонов к выбранному сезону
                    //                       seasonsListObserverController.animateTo(
                    //                         index: selectedSeasonIndex.value,
                    //                         isFixedHeight: true,
                    //                         offset: (offset) => 0.0,
                    //                         duration: kThemeAnimationDuration,
                    //                         curve: Curves.easeIn,
                    //                       );
                    //
                    //                       break;
                    //                     }
                    //                     episodesOffset += episodesCount;
                    //                   }
                    //
                    //                   /// обновляем индекс эпизода
                    //                   selectedEpisodeIndex.value = episodeIndex;
                    //                 }
                    //               },
                    //               onTap: () {
                    //                 /// переходим на страницу плеера фильма
                    //                 context.pushReplacementNamed(
                    //                   'player',
                    //                   queryParameters: {
                    //                     'episodeIndex': '$index',
                    //                   },
                    //                   extra: mediaItem,
                    //                 );
                    //               },
                    //             ),
                    //           );
                    //
                    //           if (seasonEpisodesMap.contains(index)) {
                    //             return StickyHeader(
                    //               header: Container(
                    //                 height: 50.0,
                    //                 color: Colors.blueGrey[700],
                    //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Text(
                    //                   'Header #$index',
                    //                   style: const TextStyle(color: Colors.white),
                    //                 ),
                    //               ),
                    //               content: item,
                    //             );
                    //           } else {
                    //             return item;
                    //           }
                    //
                    //           return Padding(
                    //             padding: const EdgeInsets.only(bottom: 12.0),
                    //             child: PlaylistEpisodeTile(
                    //               episode: episode,
                    //               onFocusChange: (hasFocus) {
                    //                 if (hasFocus) {
                    //                   final episodeIndex = index;
                    //                   int episodesOffset = 0;
                    //
                    //                   for (int i = 0;
                    //                       i < mediaItem.seasons.length;
                    //                       i++) {
                    //                     /// текущий сезон
                    //                     final season = mediaItem.seasons[i];
                    //
                    //                     /// количество эпизодов в текущем сезоне
                    //                     final episodesCount = season.episodes.length;
                    //
                    //                     /// относительный индекс эпизода в нужном сезоне
                    //                     final index = episodeIndex - episodesOffset;
                    //
                    //                     if (episodesCount > index) {
                    //                       /// обновляем индекс сезона
                    //
                    //                       selectedSeasonIndex.value = i;
                    //
                    //                       /// прокручиваем список сезонов к выбранному сезону
                    //                       seasonsListObserverController.animateTo(
                    //                         index: selectedSeasonIndex.value,
                    //                         isFixedHeight: true,
                    //                         offset: (offset) => 0.0,
                    //                         duration: kThemeAnimationDuration,
                    //                         curve: Curves.easeIn,
                    //                       );
                    //
                    //                       break;
                    //                     }
                    //                     episodesOffset += episodesCount;
                    //                   }
                    //
                    //                   /// обновляем индекс эпизода
                    //                   selectedEpisodeIndex.value = episodeIndex;
                    //                 }
                    //               },
                    //               onTap: () {
                    //                 /// переходим на страницу плеера фильма
                    //                 context.pushReplacementNamed(
                    //                   'player',
                    //                   queryParameters: {
                    //                     'episodeIndex': '$index',
                    //                   },
                    //                   extra: mediaItem,
                    //                 );
                    //               },
                    //             ),
                    //           );
                    //         },
                    //       ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
