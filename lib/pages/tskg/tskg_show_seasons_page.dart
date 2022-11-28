import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../models/tskg/tskg_season.dart';
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
  final _seasonsScrollController = AutoScrollController(
    axis: Axis.horizontal,
    viewportBoundaryGetter: () => const Rect.fromLTRB(48.0, 0.0, 48.0, 0.0),
  );

  final _episodesScrollController = AutoScrollController(
    axis: Axis.horizontal,
    viewportBoundaryGetter: () => const Rect.fromLTRB(48.0, 0.0, 48.0, 0.0),
  );

  late final List<FocusNode> _seasonFocusNodes;
  late final List<FocusNode> _episodeFocusNodes;
  
  final _episodes = [];
  late final int _episodeCount;
  int _selectedSeasonIndex = 0;
  int _selectedEpisodeIndex = 0;

  bool _userRequestFocus = true;
  bool _userRequestEpisodeFocus = true;

  @override
  void initState() {
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
    _seasonsScrollController.dispose();
    _episodesScrollController.dispose();

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
              autoScrollController: _seasonsScrollController,
              spacing: 8.0,
              onScrollEnd: () {
                
              },
              onItemFocusedFirstTime: (index) {
                print('season onItemFocusedFirstTime index: $index');
                print('season onItemFocusedFirstTime _selectedSeasonIndex: $_selectedSeasonIndex');
                if (index != _selectedSeasonIndex) {
                  _userRequestFocus = false;
                  _seasonFocusNodes[_selectedSeasonIndex].requestFocus();
                }
                //_checkEpisodeBySeasonIndex(index);
              },
              onItemFocused: (index) {
                print('season onItemFocused index: $index');
                if (_userRequestFocus) {
                  _checkEpisodeBySeasonIndex(index);
                } else {
                  _userRequestFocus = true;
                }
                
              },
              itemFocusNodes: _seasonFocusNodes,
              itemCount: widget.show.seasons.length,
              itemBuilder: (context, index) {
                return IconButton(
                  focusNode: _seasonFocusNodes[index],
                  style: KrsTheme.filledTonalButtonStyleOf(context),
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
                autoScrollController: _episodesScrollController,
                //scrollToLastPosition: false,
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                spacing: 24.0,
                titleText: '${currentSeason.title}, ${locale.episodesCount(currentSeason.episodes.length)}',
                onScrollEnd: () {
                  
                },
                onItemFocusedFirstTime: (index) {
                  print('episode onItemFocusedFirstTime index: $index');
                  print('episode onItemFocusedFirstTime _selectedEpisodeIndex: $_selectedEpisodeIndex');
                  if (index != _selectedEpisodeIndex) {
                    _userRequestEpisodeFocus = false;
                    _episodeFocusNodes[_selectedEpisodeIndex].requestFocus();
                  }
                  //_checkEpisodeBySeasonIndex(index);
                },
                onItemFocused: (index) {
                  print('episode onItemFocused index: $index');
                  if (_userRequestEpisodeFocus) {
                    /// проверяем и обновляем текущий сезон по выборанному эпизоду
                    _checkSeasonByEpisodeIndex(index);
                  } else {
                    _userRequestEpisodeFocus = true;
                  }
                },
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
        
        _seasonsScrollController.scrollToIndex(_selectedSeasonIndex,
          preferPosition: AutoScrollPosition.begin,
          duration: KrsTheme.fastAnimationDuration,
        );

        setState(() {
          _selectedSeasonIndex = i;
        });
        
        break;
      }
      episodesOffset += episodesCount;
    }

    setState(() {
      _selectedEpisodeIndex = episodeIndex;
    });

  }

  void _checkEpisodeBySeasonIndex(int seasonIndex) {
    int episodesOffset = 0;

    for (int i = 0; i < seasonIndex; i++) {
      /// текущий сезон
      final season = widget.show.seasons[i];

      /// количество эпизодов в текущем сезоне
      final episodesCount = season.episodes.length;

      /// относительный индекс эпизода в нужном сезоне
      episodesOffset += episodesCount;
    }

    //_episodeFocusNodes[episodesOffset].requestFocus();

    _episodesScrollController.scrollToIndex(episodesOffset,
      preferPosition: AutoScrollPosition.begin,
      duration: KrsTheme.fastAnimationDuration,
    );

    setState(() {
      _selectedEpisodeIndex = episodesOffset;
      _selectedSeasonIndex = seasonIndex;
    });
    
  }
}
