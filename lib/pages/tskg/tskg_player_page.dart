import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../controllers/seen_items_controller.dart';
import '../../models/episode_item.dart';
import '../../models/movie_item.dart';
import '../../ui/video_player/video_player_view.dart';

class TskgPlayerPage extends StatefulWidget {
  final MovieItem show;
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
  late final List<EpisodeItem> _episodes;
  late final int _episodeCount;
  int _currentIndex = 0;

  /// контроллер просмотренных эпизодов
  final _seenItemsController = GetIt.instance<SeenItemsController>();

  late MovieItem _seenShow;

  @override
  void initState() {
    /// все эпизоды в одном списке
    _episodes = widget.show.getAllEpisodes();

    /// количество эпизодов во всех сезонах
    _episodeCount = widget.show.episodeCount;

    _currentIndex = _episodes.indexWhere((episode) {
      return episode.id == widget.episodeId;
    });

    _seenShow = _seenItemsController.findItemByKey(widget.show.storageKey)
        ?? widget.show;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build $this');
    
    /// контроллер просмотренных эпизодов
    final seenEpisodesController = GetIt.instance<SeenItemsController>();

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
        seenEpisodesController.updatePosition(
          movie: _seenShow,
          episode: episode,
          position: position,
          subtitlesEnabled: subtitlesEnabled,
        );
      }
    );
  }

  Future<EpisodeItem> _getPlayableItem([bool initial = false]) async {
    
    /// получаем текущий эпизод из плейлиста
    final currentEpisode = _episodes[_currentIndex];

    /// провайдер запросов к API
    final api = GetIt.instance<TskgApiProvider>();
    
    /// получаем данные эпизода
    final episodeDetails = await api.getEpisodeDetails(currentEpisode.id);

    /// задаём качество видео в HD или в SD
    String videoUrl = episodeDetails?.video.files.hd.url
        ?? episodeDetails?.video.files.sd.url ?? '';

    /// субтитры
    String subtitlesUrl = episodeDetails?.video.subtitles ?? '';

    /// обновляем ссылку на видео файл
    currentEpisode.videoFileUrl = videoUrl;

    /// обновляем ссылку на файл субтитров
    currentEpisode.subtitlesFileUrl = subtitlesUrl;

    if (initial) {
      /// проверяем был ли эпизод в просмотренных
      final seenEpisode = _seenItemsController.findEpisode(
        storageKey: _seenShow.storageKey,
        episodeId: currentEpisode.id,
      );

      /// восстанавливаем время просмотра, если эпизод уже был в просмотренных
      currentEpisode.position = seenEpisode?.position ?? 0;
      
    } else {
      /// сбрасываем время просмотра у текущего эпизода, чтобы при переключении
      /// не запрашивал продолжить просмотр или нет
      currentEpisode.position = 0;
    }

    return currentEpisode;
  }

}
