import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgino/api/tskg/models/tskg_episode_details.dart';
import 'package:kgino/api/tskg/models/tskg_show.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/pages/player_page/player_control_overlay.dart';
import 'package:kgino/ui/pages/player_page/player_error.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

enum PlayerPageState {
  idle,
  loading,
  error,
  networkError,
}

class PlayerPage extends StatefulWidget {
  final String showId;
  final int initialId;
  final int startTime;

  const PlayerPage({
    Key? key,
    required this.showId,
    this.initialId = 0,
    this.startTime = 0,
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

  late TskgShow _currentShow;

  /// список идентификаторов эпизодов плейлиста
  final playlistIds = <int>[];

  /// индикатор загрузки данных
  bool get isLoading => _pageState == PlayerPageState.loading;

  bool isControlOverlayVisible = false;
  late final RestartableTimer showControlsOverlayTimer;

  void updatePageState(PlayerPageState state) {
    if (mounted) {
      /// ^ если виджет всё ещё активен

      /// обновляем его состояние
      setState(() {
        _pageState = state;
      });
    }
  }

  /// слушатель изменения позиции просмотра виде
  void changeVideoPositionListener() {
    final episodeId = _currentPlayingEpisode?.id;

    /// текущая позиция просмотра видео
    final position = _playerController?.value.position.inSeconds ?? 0;

    /// общая продолжительность видео
    final duration = _playerController?.value.duration.inSeconds ?? 0;

    /// сколько просмотрено в процентах [0,1]
    final percentPosition = position / duration;
    
    /// сохраняем информацию о времени просмотра эпизода
    if (episodeId != null) {
      viewedController.updateEpisode(
        showId: _currentShow.id,
        title: _currentShow.title,
        episodeId: episodeId,
        /// если просмотрено > 95%, считаем, что эпизод просмотрен
        position: percentPosition > 0.95 ? duration : position,
        duration: duration,
      );
    }

    if (position == duration) {
      /// ^ если видео закончилось
      
      /// запускаем следующий по списку эпизод
      onSkipNext();
    }

    /// чтобы экран не уходил в сон
    Wakelock.toggle(enable: _playerController?.value.isPlaying ?? false);
    
  }

  final viewedController = Get.find<ViewedController>();

  @override
  void initState() {
    super.initState();

    /// инициализируем таймер скрытия панели управления плеером
    showControlsOverlayTimer = RestartableTimer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isControlOverlayVisible = false;
        });
      }
    });
    
    /// останавливаем таймер скрытия панели управления плеером
    showControlsOverlayTimer.cancel();

    /// инициализируем плеер и первое видео
    initializeVideo();

  }

  @override
  void dispose() {
    super.dispose();

    /// прерываем таймер показа панели управления плеером
    showControlsOverlayTimer.cancel();

    _playerController?.removeListener(changeVideoPositionListener);

    _playerController?.dispose();
    
  }
  
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    late final Widget content;

    switch (_pageState) {
      
      case PlayerPageState.idle:
        content = Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// виджет плеера
            Center(
              child: _playerController?.value.isInitialized ?? false
                  ? AspectRatio(
                      aspectRatio: _playerController!.value.aspectRatio,
                      child: VideoPlayer(_playerController!),
                    )
                  : const SizedBox(),
            ),

            /// панель управления плеером
            SafeArea(
              child: PlayerControlOverlay(
                isVisible: isControlOverlayVisible,

                playerController: _playerController,

                /// виджет названия проигрываемого видео
                title: Column(
                  children: [
                    /// название сериала
                    Text(_currentPlayingEpisode?.fullname ?? '',
                      style: const TextStyle(
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16.0),

                    /// название эпизода
                    Text(_currentPlayingEpisode?.name ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                
                /// при запросе следующего видео
                onSkipPrevious: onSkipPrevious,

                /// при запросе предыдущего видео
                onSkipNext: onSkipNext,

                /// при перемотке видео
                onSeek: (duration) {
                  /// перематываем видео
                  _playerController?.seekTo(duration);

                  /// обновляем время показа панели управления плеером
                  updateContolOverlayVisibilityTimer();
                },

                /// при запросе остановки/продолжения проигрывания видео
                onPlayPause: () {
                  if (_playerController?.value.isPlaying ?? false) {
                    _playerController?.pause();
                  } else {
                    _playerController?.play();
                  }

                  /// обновляем время показа панели управления плеером
                  updateContolOverlayVisibilityTimer();
                },

                /// при нажатии на клавишу, когда панель управления плеером
                /// скрыта
                onShowOverlay: (logicalKey) {
                  
                  /// показываем панель управления плеером
                  showControlOverlay();

                  if (logicalKey == LogicalKeyboardKey.enter || logicalKey == LogicalKeyboardKey.numpadEnter) {
                    /// ^ если был нажат enter
                    
                  }
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
          message: 'Отсутствует соединение с сетью',
          onRetry: onRetry
        );
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: content,
    );
  }

  /// загрузка видео-файла эпизода по id
  Future<void> loadEpisode({required int episodeId, int startTime = 0}) async {
    /// завершаем работу плеера
    await _playerController?.dispose();
    _playerController = null;
    
    /// обновляем состояние UI
    updatePageState(PlayerPageState.loading);

    /// получаем данные эпизода
    final episode = await TskgApi().getEpisodeDetails(episodeId);
    
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

        /// сохраняем информацию о проигрываемом эпизоде
        _currentPlayingEpisode = episode;

        try {
          /// инициализируем плеер
          await _playerController?.initialize();

          /// запускаем видео
          await _playerController?.play();

          /// перематываем в нужную позицию
          await _playerController?.seekTo(Duration(seconds: startTime));

          /// обновляем информацию о просмотре
          _playerController?.addListener(changeVideoPositionListener);

          /// обновляем состояние UI
          updatePageState(PlayerPageState.idle);

        } catch (exception) {
          /// ^ если при загрузке видео произошла ошибка

          /// обновляем состояние UI
          updatePageState(PlayerPageState.error);

        }

      }

    } else {
      /// ^ если не смогли загрузить эпизод
      
      /// показываем ошибку
      updatePageState(PlayerPageState.networkError);

    }
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipPrevious() async {
    
    /// обновляем время показа панели управления плеером
    updateContolOverlayVisibilityTimer();

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
        loadEpisode(
          episodeId: playlistIds[indexInPlaylist - 1],
        );

      } else {
        /// ^ если в плейлисте это видео первое...

        /// ...перематываем текущее видео в начало
        _playerController?.seekTo(Duration.zero);

      }
    }
    
  }


  /// обработчик при запросе следующего видео
  Future<void> onSkipNext() async {
    
    /// обновляем время показа панели управления плеером
    updateContolOverlayVisibilityTimer();

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
        loadEpisode(
          episodeId: playlistIds[indexInPlaylist + 1],
        );
        
      }
    }
    
  }


  /// обработчик при перезагрузке текущего эпизода
  Future<void> onRetry() async {
    if (_currentPlayingEpisode != null) {
      /// ^ если текущий эпизод загружен
      
      /// пытаемся запусть видео ещё раз
      loadEpisode(
        episodeId: _currentPlayingEpisode!.id,
      );
    } else {
      /// ^ если проблема в формировании плейлиста/эпизода

      /// инициализируем виджет
      initializeVideo();
    }

  }


  /// инициализация плеера и первого видео
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
      _currentShow = await TskgApi().getShow(widget.showId);
      
      /// очищаем спискок идентификаторов эпизодов
      playlistIds.clear();

      for (final season in _currentShow.seasons) {
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
        
        /// id эпизода, который необходимо запустить
        late int initialEposodeId;
        
        if (widget.initialId > 0 && playlistIds.contains(widget.initialId)) {
          /// ^ если передали id желаемого эпизода и он есть в списке
          /// всех эпизодов
          
          initialEposodeId = widget.initialId;
        
        } else {
          /// ^ если не указали эпизода или его нет в списке всех эпизодов

          /// устанавливаем первое видео по списку эпизодов
          initialEposodeId = playlistIds.first;
        }

        /// загружаем видео-файл запрошенного эпизода
        await loadEpisode(
          episodeId: initialEposodeId,
          startTime: widget.startTime,
        );
      }

    }
  }


  /// показываем панель управления плеером
  showControlOverlay() {
    if (!isControlOverlayVisible) {
      /// показываем панель управления плеером
      setState(() {
        isControlOverlayVisible = true;
      });
    }

    updateContolOverlayVisibilityTimer();
  }

  /// обновление таймера скрытия панели управления плеером
  void updateContolOverlayVisibilityTimer() {
    if (isControlOverlayVisible) {
      /// перезапускаем таймер скрытия панели управления плеером
      showControlsOverlayTimer.reset();
    }
  }
}