import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../models/tskg/tskg_show.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../ui/lists/krs_list_view.dart';
import '../../ui/pages/episode_card.dart';


class TskgShowSeasonsPage extends StatefulWidget {
  final TskgShow show;

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

  late final List<FocusNode> _seasonFocusNodes;
  late final List<FocusNode> _episodeFocusNodes;
  
  final _episodes = [];
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

    _seasonFocusNodes = List.generate(widget.show.seasons.length, (index) {
      return FocusNode();
    });

    _episodeFocusNodes = List.generate(_episodeCount, (index) {
      return FocusNode();
    });

    super.initState();
  }

  @override
  void dispose() {
    // _seasonsScrollController.dispatchOnceObserve();
    // _episodesScrollController.dispatchOnceObserve();

    for (final focusNode in _episodeFocusNodes) {
      focusNode.dispose();
    }

    for (final focusNode in _seasonFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final currentSeason = widget.show.seasons[_selectedSeasonIndex];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// номера сезонов
          SizedBox(
            height: 40.0 + 48.0 * 2,
            child: KrsListView(
              padding: const EdgeInsets.all(48.0),
              controller: _seasonsScrollController,
              spacing: 8.0,
              onLoadNextPage: () {
                
              },
              onItemFocused: (index) {
                _checkEpisodeBySeasonIndex(index);
              },
              requestItemIndex: () => _selectedSeasonIndex,
              itemFocusNodes: _seasonFocusNodes,
              itemCount: widget.show.seasons.length,
              itemBuilder: (context, index) {
                return IconButton(
                  focusNode: _seasonFocusNodes[index],
                  style: _selectedSeasonIndex == index
                      ? KrsTheme.filledButtonStyleOf(context)
                      : KrsTheme.filledTonalButtonStyleOf(context),
                  onPressed: () {
                    /// переходим на страницу плеера фильма
                    // context.goNamed('tskgShowPlayer',
                    //   params: {
                    //     'id': widget.show.showId,    
                    //   },
                    //   queryParams: {
                    //     'startTime': 0.toString(),
                    //     'fileIndex': index.toString(),
                    //   },
                    //   extra: widget.show,
                    // );
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
              child: KrsListView(
                controller: _episodesScrollController,
                //scrollToLastPosition: false,
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                spacing: 24.0,
                titleText: '${currentSeason.title}, ${locale.episodesCount(currentSeason.episodes.length)}',
                onLoadNextPage: () {
                  
                },
                onItemFocused: (index) {
                  _checkSeasonByEpisodeIndex(index);
                },
                requestItemIndex: () => _selectedEpisodeIndex,
                itemFocusNodes: _episodeFocusNodes,
                itemCount: _episodeCount,
                itemBuilder: (context, index) {
                  final episode = _episodes[index];

                  return EpisodeCard(
                    focusNode: _episodeFocusNodes[index],
                    titleText: episode.title,
                    onPressed: () {
                      /// переходим на страницу плеера сериала
                      // context.goNamed('tskgShowPlayer',
                      //   params: {
                      //     'id': widget.show.showId,    
                      //   },
                      //   queryParams: {
                      //     'startTime': 0.toString(),
                      //     'fileIndex': index.toString(),
                      //   },
                      //   extra: widget.show,
                      // );
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

  void _checkSeasonByEpisodeIndex(int episodeIndex) {
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

  void _checkEpisodeBySeasonIndex(int seasonIndex) {
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
    int maxIndex = minIndex + widget.show.seasons[seasonIndex].episodes.length;

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
