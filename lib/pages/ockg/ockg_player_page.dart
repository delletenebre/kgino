import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/seen_items_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../ui/video_player/video_player_view.dart';

class OckgPlayerPage extends StatefulWidget {
  final MovieItem movie;
  final String episodeId;

  const OckgPlayerPage({
    super.key,
    required this.movie,
    this.episodeId = '',
  });

  @override
  State<OckgPlayerPage> createState() => _OckgPlayerPageState();
}

class _OckgPlayerPageState extends State<OckgPlayerPage> {
  final _episodes = <EpisodeItem>[];
  late final int _episodeCount;
  int _currentIndex = 0;

  /// контроллер просмотренных эпизодов
  final _seenItemsController = GetIt.instance<SeenItemsController>();

  late MovieItem _seenShow;

  @override
  void initState() {
    /// все эпизоды в одном списке
    for (final season in widget.movie.seasons) {
      _episodes.addAll(season.episodes);
    }

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.movie.episodeCount;

    _currentIndex = _episodes.indexWhere((episode) {
      return episode.id == widget.episodeId;
    });

    _seenShow = _seenItemsController.findItemByKey(widget.movie.storageKey)
        ?? widget.movie;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return VideoPlayerView(
      titleText: _seenShow.name,
      subtitlesEnabled: _seenShow.subtitlesEnabled,
      onInitialPlayableItem: () => _getPlayableItem(true),

      onSkipNext: (_currentIndex + 1 < _episodeCount) ? () {
        /// переходим к следующему файлу
        setState(() {
          _currentIndex++;
        });

        return _getPlayableItem();
      } : null,
      onSkipPrevious: (_currentIndex > 0) ? () {
        /// переходим к предыдущему файлу
        setState(() {
          _currentIndex--;
        });

        return _getPlayableItem();
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

  Future<EpisodeItem> _getPlayableItem([bool initial = false]) async {
    final currentEpisode = _episodes[_currentIndex];

    if (initial) {
      /// находим сохранённый эпизод, если он есть

      /// проверяем был ли эпизод в просмотренных
      return _seenItemsController.findEpisode(
        storageKey: _seenShow.storageKey,
        episodeId: currentEpisode.id,
      ) ?? currentEpisode;

    } else {
      /// сбрасываем время просмотра у текущего эпизода, чтобы при переключении
      /// не запрашивал продолжить просмотр или нет
      currentEpisode.position = 0;
      return currentEpisode;
    }
  }
}