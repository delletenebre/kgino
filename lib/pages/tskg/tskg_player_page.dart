import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../controllers/seen_items_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../ui/video_player/video_player_view.dart';

class TskgPlayerPage extends StatefulWidget {
  final TskgMovieItem show;
  final String episodeId;

  const TskgPlayerPage({
    super.key,
    required this.show,
    this.episodeId = '',
  });

  @override
  State<TskgPlayerPage> createState() => _TskgPlayerPageState();
}

class _TskgPlayerPageState extends State<TskgPlayerPage> {
  final _episodes = <EpisodeItem>[];
  late final int _episodeCount;
  int _currentIndex = 0;
  bool _subtitlesEnabled = false;
  int _startTime = 0;

  @override
  void initState() {
    /// все эпизоды в одном списке
    for (final season in widget.show.seasons) {
      _episodes.addAll(season.episodes);
    }

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.show.episodeCount;

    _currentIndex = widget.episodeIndex;
    

    /// контроллер просмотренных эпизодов
    final seenItemsController = GetIt.instance<SeenItemsController>();
    
    /// проверяем был ли сериал уже в просмотренных
    final seenShow = seenItemsController.findItemByKey(widget.show.storageKey);
    
    if (seenShow != null) {
      /// ^ если сериал уже был в просмотренных
      
      /// восстонавливаем состояние субтитров (включены или выключены)
      _subtitlesEnabled = seenShow.subtitlesEnabled;
      
      /// проверяем был ли эпизод в просмотренных
      final seenEpisode = seenItemsController.findEpisode(
        storageKey: widget.show.storageKey,
        episodeId: widget.episodeId,
      );

      if (seenEpisode != null) {
        /// ^ если эпизод уже был в просмотренных
        
        /// восстанавливаем время просмотра
        _startTime = seenEpisode.position;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// контроллер просмотренных эпизодов
    final seenEpisodesController = GetIt.instance<SeenItemsController>();

    return VideoPlayerView(
      onInitialPlayableItem: _getPlayableItem,

      onSkipNext: (_currentIndex + 1 < _episodeCount) ? () {
        /// переходим к следующему файлу
        setState(() {
          _startTime = 0;
          _currentIndex++;
        });

        return _getPlayableItem();
      } : null,

      onSkipPrevious: (_currentIndex > 0) ? () {
        /// переходим к предыдущему файлу
        setState(() {
          _startTime = 0;
          _currentIndex--;
        });

        return _getPlayableItem();
      } : null,

      onUpdatePosition: (episodeId, position, duration, subtitlesEnabled, episodeName) {
        _subtitlesEnabled = subtitlesEnabled;

        seenEpisodesController.updatePosition(
          position: position,
          subtitlesEnabled: _subtitlesEnabled,
        );
      }
    );
  }

  Future<EpisodeItem> _getPlayableItem() async {
    
    final currentEpisode = _episodes[_currentIndex];
    
    /// провайдер запросов к API
    final api = GetIt.instance<TskgApiProvider>();
    
    /// получаем данные эпизода
    final episodeDetails = await api.getEpisodeDetails(currentEpisode.id);

    /// качество видео по умолчанию - SD
    String videoUrl = episodeDetails?.video.files.sd.url ?? '';
    
    /// субтитры
    String subtitleUrl = episodeDetails?.video.subtitles ?? '';
    
    if (episodeDetails != null) {
      if (episodeDetails.video.files.hd.url.isNotEmpty) {
        /// ^ если есть видео в HD качестве
        
        /// задаём качество видео HD
        videoUrl = episodeDetails.video.files.hd.url;
      }
    }
    
    String subtitle = '${episodeDetails?.nameWithSeason}';

    return EpisodeItem(
      id: '${episodeDetails?.id}',
      videoFileUrl: videoUrl,
      subtitlesFileUrl: subtitleUrl,
    );
  }

}
