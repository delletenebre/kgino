import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode_details.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/player_page/player_control_overlay.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  final String showId;
  final int initialId;

  const PlayerPage({
    Key? key,
    required this.showId,
    this.initialId = 0,
  }) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  
  VideoPlayerController? _playerController;

  /// информация о проигрываемом видео
  TskgEpisodeDetails? _currentPlayingEpisode;

  /// список идентификаторов эпизодов плейлиста
  final playlistIds = <int>[];

  /// индикатор загрузки данных
  bool _loading = true;

  void updateLoadingState(bool state) {
    setState(() {
      _loading = state;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.showId.isEmpty) {
      /// ^ если не указан id сериала
      
      /// возвращаемся назад
      // TODO возможно лучше показать ошибку
      Get.back();
    
    } else {
      /// ^ если id сериала был передан
      
      updateLoadingState(true);
      /// получаем данные сериала (сезоны и эпизоды)
      TskgApi.getShow(widget.showId).then((show) {
        /// очищаем спискок идентификаторов эпизодов
        playlistIds.clear();

        for (final season in show.seasons) {
          /// ^ перебираем сезоны
          
          for (final episode in season.episodes) {
            /// ^ перебираем эпизоды
            
            /// добавляем id эпизода в список
            playlistIds.add(episode.id);
          }
        }

        debugPrint('playlistIds: $playlistIds');

        if (playlistIds.isEmpty) {
          /// ^ если список эпизодов пуст
        
          /// возвращаемся назад
          // TODO возможно лучше показать ошибку
          Get.back();
        
        } else {
          /// ^ если есть элементы в списоке эпизодов
          
          /// по умолчанию первое видео - по списку эпизодов
          int initialEposodeId = playlistIds.first;
          
          if (widget.initialId > 0 && playlistIds.contains(widget.initialId)) {
            /// ^ если передали id желаемого эпизода и он есть в списке
            /// всех эпизодов
            
            initialEposodeId = widget.initialId;
          }

          /// загружаем видео-файл запрошенного эпизода
          loadEpisode(initialEposodeId);
        }

      });
    }

  }

  @override
  void dispose() {
    super.dispose();
    _playerController?.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: _playerController?.value.isInitialized ?? false
                ? AspectRatio(
                    aspectRatio: _playerController!.value.aspectRatio,
                    child: VideoPlayer(_playerController!),
                  )
                : Container(),
          ),

          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: PlayerControlOverlay(
              totalVideoDuration: _playerController?.value.duration,
              
              /// при запросе следующего видео
              onSkipPrevious: onSkipPrevious,

              /// при запросе предыдущего видео
              onSkipNext: onSkipNext,

              /// при перемотке видео
              onSeek: (duration) {
                /// перематываем видео
                _playerController?.seekTo(duration);
              },


            )
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _loading
              ? Container(
                  width: 96.0,
                  height: 96.0,
                  child: const CircularProgressIndicator()
                )
              : const SizedBox(),
          ),
        ]
      ),
    );
  }

  /// загрузка видео-файла эпизода по id
  Future<void> loadEpisode(int episodeId) async {
    /// завершаем работу плеера
    await _playerController?.dispose();
    _playerController = null;
    
    /// обновляем состояние UI
    updateLoadingState(true);

    /// получаем данные эпизода
    final episode = await TskgApi.getEpisodeDetails(episodeId);
    
    debugPrint('episode: $episode');

    if (episode != null) {
      /// ^ если данние по эпизоду получены
      
      /// качество видео по умолчанию - SD
      String videoUrl = episode.video.files.sd.url;
      
      if (episode.video.files.hd.url.isNotEmpty) {
        /// ^ если есть видео в HD качестве
        
        /// задаём качество видео HD
        videoUrl = episode.video.files.hd.url;
      }

      if (videoUrl.isNotEmpty) {
        /// ^ если ссылка на видео-файл задана
      
        /// загружаем видео
        _playerController = VideoPlayerController.network(videoUrl);

        /// инициализируем плеер
        await _playerController?.initialize();

        /// обновляем информацию о проигрываемом видео
        _currentPlayingEpisode = episode;

        /// обновляем состояние UI
        updateLoadingState(false);
        

        // _playerController.addListener(() {
        // });
      }
    }
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipPrevious() async {
    
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipNext() async {
    if (_playerController != null) {
      /// ^ если в плеере загружено видео
    
      final currentVideo = _playerController!.value;

      /// получаем текущую позицию просмотра
      //final position = currentVideo.position;

      /// получаем общую продолжительность текущего видео
      // final totalDuration = currentVideo.duration;

      /// вычисляем сколько было просмотрено в процентах
      // final positionInPercent = position.inSeconds * 100 / totalDuration.inSeconds;

      debugPrint('currentVideo.position: ${currentVideo.position}');

      if (currentVideo.position.inSeconds > 30) {
        /// ^ если было просмотрено больше 30 секунд видео

        /// перематываем текущее видео в начало
        _playerController?.seekTo(Duration.zero);

        /// останавливаем логику
        return;
      }
    }


    
  }
}