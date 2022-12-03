import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../models/playable_item.dart';
import '../../resources/krs_locale.dart';
import '../loading_indicator.dart';
import '../pages/try_again_message.dart';
import 'video_player_controls_overlay.dart';

enum VideoPlayerState {
  initialized,
  loading,
  error,
}

class VideoPlayerView extends StatefulWidget {
  final Future<PlayableItem> Function() onInitialPlayableItem;
  final Future<PlayableItem> Function()? onSkipPrevious;
  final Future<PlayableItem> Function()? onSkipNext;

  /// при обновлении времени просмотра
  final Function(String episodeId, int position, int duration, bool subtitlesEnabled) onUpdatePosition;

  const VideoPlayerView({
    super.key,
    required this.onInitialPlayableItem,
    this.onSkipPrevious,
    this.onSkipNext,
    required this.onUpdatePosition,
  });

  @override
  createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  /// состояние страницы
  VideoPlayerState _pageState = VideoPlayerState.loading;

  /// контроллер видеоплеера
  VideoPlayerController? _playerController;

  late PlayableItem _playableItem;

  bool _isControlOverlayVisible = true;
  late final RestartableTimer _showControlsOverlayTimer;

  /// индикатор загрузки данных
  bool get isLoading => _pageState == VideoPlayerState.loading;

  /// включены или выключены субтитры
  bool _subtitlesEnabled = false;

  /// если больше, чем ноль, то спросить, нужно ли продолжить просмотр с этого
  /// момента; когда -1 - означает, что спрашивать больше не нужно, т.к. была
  /// первая инициализация
  int _startTime = 0;

  /// обновление состояния страницы
  void _updatePageState(VideoPlayerState state) {
    if (mounted && _pageState != state) {
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

    /// инициализируем начальное видео
    _changeVideo(widget.onInitialPlayableItem);

    /// инициализируем таймер скрытия панели управления плеером
    _showControlsOverlayTimer = RestartableTimer(const Duration(seconds: 5), () {
      if (mounted && (_playerController?.value.isPlaying ?? false)) {
        setState(() {
          _isControlOverlayVisible = false;
        });
      }
    });
    
  }

  @override
  void dispose() {
    /// прерываем таймер показа панели управления плеером
    _showControlsOverlayTimer.cancel();

    /// завершаем работу текущего плеера
    _disposeVideoController(widgetDispose: true);

    super.dispose();
  }

  void _disposeVideoController({bool widgetDispose = false}) {
    if (!widgetDispose) {
      _updatePageState(VideoPlayerState.loading);
    }

    /// удаляем слушателей у текущего плеера
    _playerController?.removeListener(_changeVideoPositionListener);

    /// завершаем работу текущего плеера
    _playerController?.dispose();
  }

  String getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }

  Future<ClosedCaptionFile> _loadSubtitle(String url) async {
    final data = NetworkAssetBundle(Uri.parse(url));
    final newdata = await data.load('');
    String fileContents = getStringFromBytes(newdata);
    return WebVTTCaptionFile(fileContents);
  }

  Future<void> _initializeVideo() async {
    /// завершаем работу текущего плеера
    _disposeVideoController();

    Future<ClosedCaptionFile>? closedCaptionFile;
    if (_playableItem.subtitleUrl.isNotEmpty) {
      closedCaptionFile = _loadSubtitle(_playableItem.subtitleUrl);
    }

    _playerController = VideoPlayerController.network(_playableItem.videoUrl,
      closedCaptionFile: closedCaptionFile,
    );
    // _playerController = VideoPlayerController.network('https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_30MB.mp4');//(widget.videoUrl);
    
    try {
      /// инициализируем плеер
      await _playerController!.initialize().then((_) {
        /// проверяем нужную позицию
        if (_startTime > -1) {
          _startTime = _playableItem.startTime;
        } else {
          /// запускаем видео
          _playerController!.play();
        }

        /// обновляем информацию о просмотре
        _playerController!.addListener(_changeVideoPositionListener);

        /// включены или выключены субтитры
        _subtitlesEnabled = _playableItem.subtitlesEnabled;

        /// обновляем состояние UI
        _updatePageState(VideoPlayerState.initialized);
      });

      

    } catch (exception) {
      /// ^ если при загрузке видео произошла ошибка
      
      /// обновляем состояние UI
      _updatePageState(VideoPlayerState.error);
    }
  }

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);
    
    if (_startTime > 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final seekToPosition = await showGeneralDialog(
          context: context,
          barrierColor: Colors.black,
          barrierDismissible: false,
          pageBuilder: (_, __, ___) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// кнопка продолжить просмотр
                  ElevatedButton(
                    autofocus: true,
                    onPressed: () {
                      if (mounted) {
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: Text(locale.continueWatching),
                  ),

                  /// кнопка начать сначала
                  ElevatedButton(
                    onPressed: () {
                      if (mounted) {
                        Navigator.of(context).pop(false);
                      }
                    },
                    child: Text(locale.startOver),
                  ),
                ],
              )
            );
          },
        );

        if (seekToPosition == null) {
          _startTime = -1;
          if (mounted) {
            Navigator.of(context).pop();
          }
        } else {
          if (seekToPosition == true) {
            await _playerController?.seekTo(Duration(seconds: _startTime));
          }
          _startTime = -1;
          _playerController?.play();
        }
        
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {

          /// если загрузка видео
          if (_pageState == VideoPlayerState.loading) {
            
            /// показываем индикатор загрузки
            return const LoadingIndicator(
              size: 64.0,
            );
          }

          /// если произошла ошибка
          if (_pageState == VideoPlayerState.error) {
            
            /// показываем экран с текстом ошибки
            return TryAgainMessage(
              onRetry: _initializeVideo,
            );
          }
          
          /// контейнер с видео
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [

              /// видео плеер
              Center(
                child: AspectRatio(
                  aspectRatio: _playerController!.value.aspectRatio,
                  child: VideoPlayer(_playerController!),
                ),
              ),

              /// субтитры
              if (_subtitlesEnabled) Positioned(
                bottom: 12.0,
                child: ValueListenableBuilder(
                  valueListenable: _playerController!,
                  builder: (context, video, child) {
                    return ClosedCaption(
                      text: video.caption.text,
                      textStyle: const TextStyle(
                        fontSize: 24.0,
                      ),
                    );
                  }
                ),
              ),

              /// оверлей с панелью управления видео
              SafeArea(
                child: VideoPlayerControlsOverlay(
                  titleText: _playableItem.title,
                  subtitleText: _playableItem.subtitle,
                  isVisible: _isControlOverlayVisible,
                  playerController: _playerController,
                  onPlayPause: () {
                    if (_playerController!.value.isPlaying) {
                      _playerController?.pause();
                    } else {
                      _playerController?.play();
                    }

                    /// обновляем время показа панели управления плеером
                    updateContolOverlayVisibilityTimer();
                  },

                  onSeek: (duration) {
                    /// перематываем видео
                    _playerController!.seekTo(duration);

                    /// обновляем время показа панели управления плеером
                    updateContolOverlayVisibilityTimer();
                  },
                  
                  onShowOverlay: () {
                    /// показываем панель управления плеером
                    showControlOverlay();
                  },
                  
                  onSkipNext: widget.onSkipNext == null ? null : () async {
                    /// запрашиваем следующее видео
                    _changeVideo(widget.onSkipNext!);
                  },
                  
                  onSkipPrevious: widget.onSkipPrevious == null ? null : () async {
                    /// запрашиваем предыдущее видео
                    _changeVideo(widget.onSkipPrevious!);
                  },

                  subtitlesEnabled: _subtitlesEnabled,
                  onSubtitleToggle: (subtitlesEnabled) {
                    setState(() {
                      _subtitlesEnabled = subtitlesEnabled;
                    });
                  },
                  
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// показываем панель управления плеером
  showControlOverlay() {
    if (mounted && !_isControlOverlayVisible) {
      /// показываем панель управления плеером
      setState(() {
        _isControlOverlayVisible = true;
      });
    }

    updateContolOverlayVisibilityTimer();
  }

  /// обновление таймера скрытия панели управления плеером
  void updateContolOverlayVisibilityTimer() {
    if (_isControlOverlayVisible) {
      /// перезапускаем таймер скрытия панели управления плеером
      _showControlsOverlayTimer.reset();
    }
  }

  /// слушатель изменения позиции просмотра виде
  void _changeVideoPositionListener() {
    
    /// текущая позиция просмотра видео
    final position = _playerController?.value.position.inSeconds ?? 0;

    /// общая продолжительность видео
    final duration = _playerController?.value.duration.inSeconds ?? 0;

    // /// сколько просмотрено в процентах [0,1]
    // final percentPosition = position / duration;

    /// сохраняем информацию о времени просмотра эпизода
    widget.onUpdatePosition(_playableItem.id, position, duration, _subtitlesEnabled);

    /// чтобы экран не уходил в сон
    Wakelock.toggle(
      enable: _playerController?.value.isPlaying ?? false,
    );

    if (position == duration) {
      /// ^ если видео закончилось
      
      if (widget.onSkipNext != null) {
        /// ^ если есть следующее видео

        /// запрашиваем следующее видео
        _changeVideo(widget.onSkipNext!);
      
      } else {
        /// ^ если следующего видео нет

        /// закрываем плеер
        context.pop();

      }
    }

  }

  Future<void> _changeVideo(
    Future<PlayableItem> Function() playableItemGetter
  ) async {
    /// завершаем работу текущего плеера
    _disposeVideoController();
    
    /// запрашиваем новое видео
    _playableItem = await playableItemGetter();
    
    /// инициализируем новый плеер
    _initializeVideo();
  }

}
