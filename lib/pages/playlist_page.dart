import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../hooks/list_observer_controller_hook.dart';
import '../models/test/media_item.dart';
import '../resources/constants.dart';
import '../resources/krs_locale.dart';
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

    final episodes = useMemoized(
        () => mediaItem.seasons.expand((season) => season.episodes).toList());

    final seasonsListObserverController = useListObserverController();
    final episodesListObserverController = useListObserverController();

    final _selectedSeasonIndex = useState(0);
    final _selectedEpisodeIndex = useState(0);

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
              width: 412.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mediaItem.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.pop();
                  //   },
                  //   child: Text('BACK'),
                  // ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: VerticalListView(
                      key: const ValueKey('seasonsList'),
                      controller: seasonsListObserverController,
                      keyEventResult: KeyEventResult.handled,
                      requestItemIndex: () => _selectedSeasonIndex.value,
                      itemCount: mediaItem.seasons.length,
                      itemBuilder: (context, index) {
                        print('INDEX SEASON REBUILD: $index');
                        final season = mediaItem.seasons[index];
                        return ListTile(
                          onFocusChange: (hasFocus) {
                            print(
                                '_selectedEpisodeIndex: ${_selectedEpisodeIndex.value}');
                            if (hasFocus) {
                              final seasonIndex =
                                  mediaItem.seasons.indexOf(season);
                              int minIndex = 0;

                              for (int i = 0; i < seasonIndex; i++) {
                                /// текущий сезон
                                final season = mediaItem.seasons[i];

                                /// количество эпизодов в текущем сезоне
                                final episodesCount = season.episodes.length;

                                /// минимальный индекс эпизода в нужном сезоне
                                minIndex += episodesCount;
                              }

                              /// максимальный индекс эпизода в нужном сезоне
                              int maxIndex = minIndex + season.episodes.length;

                              if (_selectedEpisodeIndex.value < minIndex ||
                                  _selectedEpisodeIndex.value >= maxIndex) {
                                /// ^ если текущий выбранный эпизод не в выбранном сезоне

                                /// прокручиваем список к первому эпизоду выбранного сезона
                                episodesListObserverController.animateTo(
                                  index: minIndex,
                                  isFixedHeight: true,
                                  offset: (offset) => 0.0,
                                  duration: const Duration(milliseconds: 50),
                                  curve: Curves.easeIn,
                                );

                                /// обновляем индексы эпизода и сезона
                                _selectedSeasonIndex.value = seasonIndex;
                                _selectedEpisodeIndex.value = minIndex;
                                print(
                                    '_selectedEpisodeIndex minIndex: ${_selectedEpisodeIndex.value}');
                              } else {
                                /// ^ если текущий выбранный эпизод из выбранного сезона

                                /// обновляем индекс сезона
                                _selectedSeasonIndex.value = seasonIndex;
                              }
                            }
                          },
                          onTap: () {},
                          title: Text('${locale.season} ${season.name}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: VerticalListView(
                key: const ValueKey('episodesList'),
                keyEventResult: KeyEventResult.handled,
                controller: episodesListObserverController,
                requestItemIndex: () => _selectedEpisodeIndex.value,
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return ListTile(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        final episodeIndex = episodes.indexOf(episode);
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

                            _selectedSeasonIndex.value = i;

                            /// прокручиваем список сезонов к выбранному сезону
                            seasonsListObserverController.animateTo(
                              index: _selectedSeasonIndex.value,
                              isFixedHeight: true,
                              offset: (offset) => 0.0,
                              duration: const Duration(milliseconds: 50),
                              curve: Curves.easeIn,
                            );

                            break;
                          }
                          episodesOffset += episodesCount;
                        }
                        print('episodeIndex $episodeIndex');

                        /// обновляем индекс эпизода
                        _selectedEpisodeIndex.value = episodeIndex;
                      }
                    },
                    onTap: () {},
                    title: Text('Episode ${index}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
