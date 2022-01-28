import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/models/tskg_episode_details.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/player_page/player_control_overlay.dart';
import 'package:kgino/ui/pages/player_page/player_error.dart';
import 'package:video_player/video_player.dart';

enum PlayerPageState {
  idle,
  loading,
  error,
  networkError,
}

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
  
  /// состояние страницы
  PlayerPageState _pageState = PlayerPageState.idle;
  
  /// контроллер видео-плеера
  VideoPlayerController? _playerController;

  /// информация о проигрываемом видео
  TskgEpisodeDetails? _currentPlayingEpisode;

  /// список идентификаторов эпизодов плейлиста
  final playlistIds = <int>[];

  /// индикатор загрузки данных
  bool get isLoading => _pageState == PlayerPageState.loading;

  void updatePageState(PlayerPageState state) {
    if (mounted) {
      /// ^ если виджет всё ещё активен

      /// обновляем его состояние
      setState(() {
        _pageState = state;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initializeVideo();

  }

  @override
  void dispose() {
    super.dispose();

    if (_playerController != null) {
      /// ^ если плеер существует
      
      /// сохраняем просмотренно время эпизода
      saveEpisodeProgress(
        _currentPlayingEpisode?.id ?? 0,
        _playerController!.value.position
      );
      
      _playerController?.dispose();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    late final Widget content;

    switch (_pageState) {
      
      case PlayerPageState.idle:
        content = Stack(
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

            /// элементы управления плеером
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: PlayerControlOverlay(

                playerController: _playerController,
                
                /// при запросе следующего видео
                onSkipPrevious: onSkipPrevious,

                /// при запросе предыдущего видео
                onSkipNext: onSkipNext,

                /// при перемотке видео
                onSeek: (duration) {
                  /// перематываем видео
                  _playerController?.seekTo(duration);
                },

              ),
            ),

            
          ]
        );
        break;

      /// если видео загружается
      case PlayerPageState.loading:
        content = Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLoading
              ? SizedBox(
                  key: UniqueKey(),
                  width: 96.0,
                  height: 96.0,
                  child: const CircularProgressIndicator()
                )
              : const SizedBox(),
          ),
        );
        break;

      case PlayerPageState.error:
        content = PlayerError(
          message: 'При загрузке видео произошла ошибка',
          onRetry: onRetry
        );
        break;

      case PlayerPageState.networkError:
        content = PlayerError(
          message: 'Нет соединения с сетью',
          onRetry: onRetry
        );
        break;
    }


    return Scaffold(
      body: content,
    );
  }

  /// загрузка видео-файла эпизода по id
  Future<void> loadEpisode(int episodeId) async {
    /// завершаем работу плеера
    await _playerController?.dispose();
    _playerController = null;
    
    /// обновляем состояние UI
    updatePageState(PlayerPageState.loading);

    /// получаем данные эпизода
    final episode = await TskgApi.getEpisodeDetails(episodeId);
    
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

        /// обновляем информацию о проигрываемом видео
        _currentPlayingEpisode = episode;

        try {
          /// инициализируем плеер
          await _playerController?.initialize();

          /// запускаем видео
          _playerController?.play();

          /// обновляем состояние UI
          updatePageState(PlayerPageState.idle);

        } catch (exception) {
          /// ^ если при загрузке видео произошла ошибка

          /// обновляем состояние UI
          updatePageState(PlayerPageState.error);

        }
        

        // _playerController.addListener(() {
        // });
      }

    } else {
      /// ^ если не смогли загрузить эпизод
      
      /// показываем ошибку
      updatePageState(PlayerPageState.networkError);

    }
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipPrevious() async {
    if (playlistIds.isEmpty) {
      /// ^ если список эпизодов ещё не загружен...
      
      /// ...останавливаем логику
      return;
    }

    if (_playerController != null) {
      /// ^ если в плеере загружено видео
    
      final currentVideo = _playerController!.value;

      /// получаем текущую позицию просмотра
      //final position = currentVideo.position;

      /// получаем общую продолжительность текущего видео
      // final totalDuration = currentVideo.duration;

      /// вычисляем сколько было просмотрено в процентах
      // final positionInPercent = position.inSeconds * 100 / totalDuration.inSeconds;

      if (currentVideo.position.inSeconds > 30) {
        /// ^ если было просмотрено больше 30 секунд видео

        /// перематываем текущее видео в начало
        _playerController?.seekTo(Duration.zero);

        /// останавливаем логику
        return;
      }
    }

    if (_currentPlayingEpisode != null) {
      /// ^ если видео из плейлиста уже проигрывается
      
      /// получаем индекс текущего видео в плейлисте
      int indexInPlaylist = playlistIds.indexOf(_currentPlayingEpisode!.id);

      if (indexInPlaylist > 0) {
        /// ^ если в плейлисте есть предыдущее видео...
        
        /// ...загружаем предыдущий эпизод
        loadEpisode(playlistIds[indexInPlaylist - 1]);

      } else {
        /// ^ если в плейлисте это видео первое...

        /// ...перематываем текущее видео в начало
        _playerController?.seekTo(Duration.zero);

      }
    }
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipNext() async {
    if (playlistIds.isEmpty) {
      /// ^ если список эпизодов ещё не загружен...
      
      /// ...останавливаем логику
      return;
    }

    if (_currentPlayingEpisode != null) {
      /// ^ если видео из плейлиста уже проигрывается
      
      /// получаем индекс текущего видео в плейлисте
      int indexInPlaylist = playlistIds.indexOf(_currentPlayingEpisode!.id);

      if (playlistIds.length > indexInPlaylist + 1) {
        /// ^ если в плейлисте есть следующее видео...
        
        /// ...загружаем следующий эпизод
        loadEpisode(playlistIds[indexInPlaylist + 1]);
        
      }
    }
  }


  /// обработчик при перезагрузке текущего эпизода
  Future<void> onRetry() async {
    if (_currentPlayingEpisode != null) {
      /// ^ если текущий эпизод загружен
      
      /// пытаемся запусть видео ещё раз
      loadEpisode(_currentPlayingEpisode!.id);
    } else {
      /// ^ если проблема в формировании плейлиста/эпизода

      /// инициализируем виджет
      initializeVideo();
    }

  }


  /// инициализация видео
  Future<void> initializeVideo() async {
    if (widget.showId.isEmpty) {
      /// ^ если не указан id сериала
      
      /// возвращаемся назад
      // TODO возможно лучше показать ошибку
      Get.back();
    
    } else {
      /// ^ если id сериала был передан
      
      /// обновляем UI
      updatePageState(PlayerPageState.loading);

      /// получаем данные сериала (сезоны и эпизоды)
      final show = await TskgApi.getShow(widget.showId);
      
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

    }
  }


  /// сохраняем информацию о времени просмотра эпизода
  Future<void> saveEpisodeProgress(int episodeId, Duration position) async {
    if (episodeId > 0) {

    }
  }
}