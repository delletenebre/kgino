import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../models/episode_item.dart';
import '../../models/kgino_item.dart';
import '../../models/season_item.dart';
import '../../resources/krs_locale.dart';
import '../../ui/lists/horizontal_list_view.dart';
import '../../ui/lists/kgino_episode_list_tile.dart';


class FlmxEpisodesPage extends StatefulWidget {
  final KginoItem kginoItem;

  const FlmxEpisodesPage(this.kginoItem,{
    super.key,
  });

  @override
  State<FlmxEpisodesPage> createState() => _FlmxEpisodesPageState();
}

class _FlmxEpisodesPageState extends State<FlmxEpisodesPage> {
  final _seasonsScrollController = ListObserverController(
    controller: ScrollController()
  );

  final _episodesScrollController = ListObserverController(
    controller: ScrollController(),
  );

  final _episodes = <EpisodeItem>[];
  late final int _episodeCount;
  int _selectedSeasonIndex = 0;
  int _selectedEpisodeIndex = 0;

  @override
  void initState() {
    /// все эпизоды в одном списке
    for (final season in widget.kginoItem.seasons) {
      _episodes.addAll(season.episodes);
    }

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.kginoItem.seasons.fold(0, (previousValue, season) {
      return previousValue + season.episodes.length;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final currentSeason = widget.kginoItem.seasons[_selectedSeasonIndex];
    // final seenEpisodesController = GetIt.instance<SeenItemsController>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// номера сезонов
          HorizontalListView<SeasonItem>(
            height: 40.0 + 48.0 * 2.0,
            padding: const EdgeInsets.all(48.0),
            controller: _seasonsScrollController,
            spacing: 8.0,
            // onItemFocused: (season) {
            //   _checkEpisodeBySeason(season);
            // },
            requestItemIndex: () => _selectedSeasonIndex,
            itemsFuture: Future.microtask(() => widget.kginoItem.seasons),
            itemBuilder: (context, focusNode, index, season) {
              return Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    _checkEpisodeBySeason(season);
                  }
                },

                child: IconButton(
                  focusNode: focusNode,
                  style: ButtonStyle(
                    
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.focused)) {
                        return theme.colorScheme.primary;
                      }

                      if (_selectedSeasonIndex == index) {
                        return theme.colorScheme.primary.withOpacity(0.62);
                      } else {
                        return theme.colorScheme.secondaryContainer;
                      }
                    }),

                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.focused)) {
                        return theme.colorScheme.onPrimary;
                      }
                      return null;
                    }),
                    textStyle: MaterialStateProperty.resolveWith((states) {
                      return const TextStyle();
                    }),

                    overlayColor: MaterialStateProperty.all(null),
                    
                  ),
                  
                  onPressed: () {
                    /// при нажатии на номер сезона
                    _checkEpisodeBySeason(season);
                  },
                  icon: Text('${index + 1}'),
                )
              );
            },
          ),

          const SizedBox(height: 48.0),

          /// список эпизодов
          Expanded(
            child: SizedBox.fromSize(
              size: const Size.fromHeight(112.0 + 24.0 + 18.0 + 8.0),
              child: HorizontalListView<EpisodeItem>(
                controller: _episodesScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                spacing: 24.0,
                titleText: '${currentSeason.name}, ${locale.episodesCount(currentSeason.episodes.length)}',
                requestItemIndex: () => _selectedEpisodeIndex,
                itemsFuture: Future.microtask(() => _episodes),
                itemBuilder: (context, focusNode, index, episode) {
                  /// просмотренное время [0; 1]
                  double seenValue = 0.0;
                  // final seenEpisode = seenEpisodesController.findEpisode(
                  //   storageKey: widget.kginoItem.storageKey,
                  //   episodeId: episode.id,
                  // );

                  // if (seenEpisode != null) {
                  //   seenValue = seenEpisode.percentPosition;
                  // }

                  return KginoEpisodeListTile(
                    focusNode: focusNode,
                    titleText: episode.name,
                    description: '${episode.seasonNumber}x${episode.episodeNumber}',//'${episode.quality} ',
                    duration: Duration(seconds: episode.duration),

                    /// время просмотра
                    seenValue: seenValue,

                    onFocused: () {
                      _checkSeasonByEpisode(episode);
                    },

                    onPressed: () {
                      /// переходим на страницу плеера сериала
                      context.goNamed('tskgPlayer',
                        params: {
                          'id': widget.kginoItem.id,    
                        },
                        queryParams: {
                          'episodeId': episode.id,
                        },
                        extra: widget.kginoItem,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkSeasonByEpisode(EpisodeItem episode) {
    final episodeIndex = _episodes.indexOf(episode);
    int episodesOffset = 0;
    
    for (int i = 0; i < widget.kginoItem.seasons.length; i++) {
      /// текущий сезон
      final season = widget.kginoItem.seasons[i];

      /// количество эпизодов в текущем сезоне
      final episodesCount = season.episodes.length;

      /// относительный индекс эпизода в нужном сезоне
      final index = episodeIndex - episodesOffset;
      
      if (episodesCount > index) {

        /// обновляем индекс сезона
        setState(() {
          _selectedSeasonIndex = i;
        });

        /// прокручиваем список сезонов к выбранному сезону
        _seasonsScrollController.animateTo(
          index: _selectedSeasonIndex,
          isFixedHeight: true,
          offset: (offset) => 48.0,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeIn,
        );
        
        break;
      }
      episodesOffset += episodesCount;
    }

    /// обновляем индекс эпизода
    setState(() {
      _selectedEpisodeIndex = episodeIndex;
    });

  }

  void _checkEpisodeBySeason(SeasonItem season) {
    final seasonIndex = widget.kginoItem.seasons.indexOf(season);
    int minIndex = 0;

    for (int i = 0; i < seasonIndex; i++) {
      /// текущий сезон
      final season = widget.kginoItem.seasons[i];

      /// количество эпизодов в текущем сезоне
      final episodesCount = season.episodes.length;

      /// минимальный индекс эпизода в нужном сезоне
      minIndex += episodesCount;
    }

    /// максимальный индекс эпизода в нужном сезоне
    int maxIndex = minIndex + season.episodes.length;

    if (_selectedEpisodeIndex < minIndex
        || _selectedEpisodeIndex >= maxIndex) {
      /// ^ если текущий выбранный эпизод не в выбранном сезоне

      /// прокручиваем список к первому эпизоду выбранного сезона
      _episodesScrollController.animateTo(
        index: minIndex,
        isFixedHeight: true,
        offset: (offset) => 48.0,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeIn,
      );

      /// обновляем индексы эпизода и сезона
      setState(() {
        _selectedEpisodeIndex = minIndex;
        _selectedSeasonIndex = seasonIndex;
      });

    } else {
      /// ^ если текущий выбранный эпизод из выбранного сезона

      /// обновляем индекс сезона
      setState(() {
        _selectedSeasonIndex = seasonIndex;
      });

    }
    
  }

}
