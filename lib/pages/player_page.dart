import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/seen_items_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../ui/video_player/video_player_view.dart';

class PlayerPage extends StatefulWidget {
  final MovieItem movieItem;
  final String episodeId;
  final Future<EpisodeItem> Function(
    bool initial,
    EpisodeItem currentEpisode,
    String seenShowStorageKey,
  ) getPlayableItem;

  const PlayerPage({
    super.key,
    required this.movieItem,
    required this.getPlayableItem,
    this.episodeId = '',
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late final List<EpisodeItem> _episodes;
  late final int _episodeCount;
  int _currentIndex = 0;

  /// контроллер просмотренных эпизодов
  final _seenItemsController = GetIt.instance<SeenItemsController>();

  late MovieItem _seenShow;

  @override
  void initState() {
    /// все эпизоды в одном списке
    _episodes = widget.movieItem.getAllEpisodes();

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.movieItem.episodeCount;

    _currentIndex = _episodes.indexWhere((episode) {
      return episode.id == widget.episodeId;
    });

    _seenShow = _seenItemsController.findItemByKey(widget.movieItem.storageKey)
        ?? widget.movieItem;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerView(
      titleText: _seenShow.name,
      subtitlesEnabled: _seenShow.subtitlesEnabled,
      onInitialPlayableItem: () => widget.getPlayableItem(
        true,
        _episodes[_currentIndex],
        _seenShow.storageKey,
      ),

      onSkipNext: (_currentIndex + 1 < _episodeCount) ? () {
        /// переходим к следующему файлу
        setState(() {
          _currentIndex++;
        });

        return widget.getPlayableItem(
          false,
          _episodes[_currentIndex],
          _seenShow.storageKey,
        );
      } : null,

      onSkipPrevious: (_currentIndex > 0) ? () {
        /// переходим к предыдущему файлу
        setState(() {
          _currentIndex--;
        });

        return widget.getPlayableItem(
          false,
          _episodes[_currentIndex],
          _seenShow.storageKey,
        );
      } : null,

      onUpdatePosition: (episode, position, subtitlesEnabled) {
        _seenItemsController.updatePosition(
          movie: _seenShow,
          episode: episode,
          position: position,
          subtitlesEnabled: subtitlesEnabled,
        );
      }
    );
  }
}
