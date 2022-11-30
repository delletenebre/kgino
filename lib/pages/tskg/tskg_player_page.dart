import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../api/tskg_api_provider.dart';
import '../../models/playable_item.dart';
import '../../models/tskg/tskg_episode.dart';
import '../../models/tskg/tskg_show.dart';
import '../../ui/video_player/video_player_view.dart';

class TskgPlayerPage extends StatefulWidget {
  final int startTime;
  final int episodeIndex;
  final TskgShow show;

  const TskgPlayerPage({
    super.key,
    required this.show,
    this.startTime = 0,
    this.episodeIndex = 0,
  });

  @override
  State<TskgPlayerPage> createState() => _TskgPlayerPageState();
}

class _TskgPlayerPageState extends State<TskgPlayerPage> {
  final _episodes = <TskgEpisode>[];
  late final int _episodeCount;
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.episodeIndex;

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
  Widget build(BuildContext context) {

    return VideoPlayerView(
      onInitialPlayableItem: _getPlayableItem,
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
    );
  }

  Future<PlayableItem> _getPlayableItem() async {
    
    final currentEpisode = _episodes[_currentIndex];
    
    /// провайдер запросов к API
    final api = GetIt.instance<TskgApiProvider>();
    
    /// получаем данные эпизода
    final episode = await api.getEpisodeDetails(currentEpisode.id);

    /// качество видео по умолчанию - SD
    String videoUrl = episode?.video.files.sd.url ?? '';
    
    /// субтитры
    String subtitleUrl = episode?.video.subtitles ?? '';
    
    if (episode != null) {
      if (episode.video.files.hd.url.isNotEmpty) {
        /// ^ если есть видео в HD качестве
        
        /// задаём качество видео HD
        videoUrl = episode.video.files.hd.url;
      }
    }
    
    String subtitle = '${episode?.name}';

    return PlayableItem(
      videoUrl: videoUrl,
      subtitleUrl: subtitleUrl,
      title: widget.show.name,
      subtitle: subtitle,
      startTime: widget.startTime,
    );
  }

  /// загрузка видео-файла эпизода по id
  // Future<void> loadEpisode(int episodeId) async {
    
    // if (episode != null) {
    //   /// ^ если данние по эпизоду получены
      
    //   /// качество видео по умолчанию - SD
    //   String videoUrl = episode.video.files.sd.url;
      
    //   if (episode.video.files.hd.url.isNotEmpty) {
    //     /// ^ если есть видео в HD качестве
        
    //     /// задаём качество видео HD
    //     videoUrl = episode.video.files.hd.url;
    //   }

    //   if (videoUrl.isNotEmpty) {
    //     /// ^ если ссылка на видео-файл задана
      
    //     /// загружаем видео
    //     _playerController = VideoPlayerController.network(videoUrl);

    //     /// сохраняем информацию о проигрываемом эпизоде
    //     _currentPlayingEpisode = episode;

    //     try {
    //       /// инициализируем плеер
    //       await _playerController?.initialize();

    //       /// запускаем видео
    //       await _playerController?.play();

    //       /// перематываем в нужную позицию
    //       await _playerController?.seekTo(Duration(seconds: startTime));

    //       /// обновляем информацию о просмотре
    //       _playerController?.addListener(changeVideoPositionListener);

    //       /// обновляем состояние UI
    //       updatePageState(PlayerPageState.idle);

    //     } catch (exception) {
    //       /// ^ если при загрузке видео произошла ошибка
    //       /// обновляем состояние UI
    //       updatePageState(PlayerPageState.error);

    //     }

    //   }

    // } else {
    //   /// ^ если не смогли загрузить эпизод
      
    //   /// показываем ошибку
    //   updatePageState(PlayerPageState.networkError);

    // }
  // }
}