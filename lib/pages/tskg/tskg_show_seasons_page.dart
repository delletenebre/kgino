import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../controllers/seen_items_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../models/season_item.dart';
import '../../resources/krs_locale.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_horizontal_list_view_2.dart';
import '../../ui/pages/episode_card.dart';


class TskgShowSeasonsPage extends StatefulWidget {
  final TskgMovieItem show;

  const TskgShowSeasonsPage({
    super.key,
    required this.show,
  });

  @override
  State<TskgShowSeasonsPage> createState() => _TskgShowSeasonsPageState();
}

class _TskgShowSeasonsPageState extends State<TskgShowSeasonsPage> {
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
    for (final season in widget.show.seasons) {
      _episodes.addAll(season.episodes);
    }

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.show.seasons.fold(0, (previousValue, season) {
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

    final currentSeason = widget.show.seasons[_selectedSeasonIndex];
    final seenEpisodesController = GetIt.instance<SeenItemsController>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// номера сезонов
          SizedBox(
            height: 40.0 + 48.0 * 2,
            child: KrsHorizontalListView2<SeasonItem>(
              padding: const EdgeInsets.all(48.0),
              controller: _seasonsScrollController,
              spacing: 8.0,
              onItemFocused: (season) {
                _checkEpisodeBySeason(season);
              },
              requestItemIndex: () => _selectedSeasonIndex,
              items: widget.show.seasons,
              itemBuilder: (context, focusNode, index, season) {
                return IconButton(
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
                );
              },
            ),
          ),

          const SizedBox(height: 48.0),

          /// список эпизодов
          Expanded(
            child: SizedBox.fromSize(
              size: const Size.fromHeight(112.0 + 24.0 + 18.0 + 8.0),
              child: KrsHorizontalListView2<EpisodeItem>(
                controller: _episodesScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                spacing: 24.0,
                titleText: '${currentSeason.name}, ${locale.episodesCount(currentSeason.episodes.length)}',
                onItemFocused: (episode) {
                  _checkSeasonByEpisode(episode);
                },
                requestItemIndex: () => _selectedEpisodeIndex,
                items: _episodes,
                itemBuilder: (context, focusNode, index, episode) {
                  /// просмотренное время [0; 1]
                  double seenValue = 0.0;
                  final seenEpisode = seenEpisodesController.findEpisode(
                    storageKey: widget.show.storageKey,
                    episodeId: episode.id,
                  );

                  if (seenEpisode != null) {
                    seenValue = seenEpisode.percentPosition;
                  }

                  return EpisodeCard(
                    focusNode: focusNode,
                    titleText: episode.name,
                    // TODO return it
                    description: '',//'${episode.quality} ${Utils.formatDuration(episode.duration)}',

                    /// время просмотра
                    seenValue: seenValue,

                    onPressed: () {
                      /// переходим на страницу плеера сериала
                      context.goNamed('tskgPlayer',
                        params: {
                          'id': widget.show.id,    
                        },
                        queryParams: {
                          'episodeId': episode.id,
                        },
                        extra: widget.show,
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
    
    for (int i = 0; i < widget.show.seasons.length; i++) {
      /// текущий сезон
      final season = widget.show.seasons[i];

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
    final seasonIndex = widget.show.seasons.indexOf(season);
    int minIndex = 0;

    for (int i = 0; i < seasonIndex; i++) {
      /// текущий сезон
      final season = widget.show.seasons[i];

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
