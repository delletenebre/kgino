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
  bool _subtitlesEnabled = false;

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// контроллер просмотренных эпизодов
    final seenEpisodesController = GetIt.instance<SeenItemsController>();

    return VideoPlayerView(
      titleText: widget.movie.name,
      subtitlesEnabled: widget.movie.subtitlesEnabled,
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
        _subtitlesEnabled = subtitlesEnabled;

        seenEpisodesController.updatePosition(
          movie: widget.movie,
          episode: episode,
          position: position,
          subtitlesEnabled: subtitlesEnabled,
        );
      }
    );
  }

  Future<EpisodeItem> _getPlayableItem([bool initial = false]) async {
    MovieItem? seenShow;
    EpisodeItem? seenEpisode;
    int seasonNumber = 0;
    int episodeNumber = 0;

    if (initial) {
      /// ^ если это первый запуск, а не перемотка
      
      /// находим сохранённый эпизод, если он есть

      /// контроллер просмотренных эпизодов
      final seenItemsController = GetIt.instance<SeenItemsController>();
      
      /// проверяем был ли сериал уже в просмотренных
      seenShow = seenItemsController.findItemByKey(widget.movie.storageKey);

      if (seenShow != null) {
        /// ^ если сериал уже был в просмотренных
        
        /// восстонавливаем состояние субтитров (включены или выключены)
        _subtitlesEnabled = seenShow.subtitlesEnabled;
        
        /// проверяем был ли эпизод в просмотренных
        final seenEpisode = seenItemsController.findEpisode(
          storageKey: widget.movie.storageKey,
          episodeId: widget.episodeId,
        );

        // if (seenEpisode != null) {
        //   /// ^ если эпизод уже был в просмотренных
          
        //   /// восстанавливаем время просмотра
        //   _startTime = seenEpisode.position;
        // }
      }
    } else {
      for (int seasonIndex = 0; seasonIndex < widget.movie.seasons.length; seasonIndex++) {
        final season = widget.movie.seasons[seasonIndex];
        final episodeIndex = season.episodes.indexWhere((episode) {
          return episode.id == widget.episodeId;
        });
        if (episodeIndex > -1) {
          seasonNumber = seasonIndex + 1;
          episodeNumber = episodeIndex + 1;
          break;
        }
      }
    }

    final currentEpisode = _episodes[_currentIndex];
    final videoUrl = currentEpisode.videoFileUrl.replaceFirst('/home/video/', 'https://p1.oc.kg:8082/');
    
    // String subtitle = '';
    // if (widget.movie.files.length > 1) {
    //   subtitle = currentFile.name;
    // }

    final episode = seenEpisode ?? EpisodeItem(
      id: currentEpisode.id,
      name: currentEpisode.name,
      duration: currentEpisode.duration,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
    );

    episode.videoFileUrl = videoUrl;

    return episode;
  }
}