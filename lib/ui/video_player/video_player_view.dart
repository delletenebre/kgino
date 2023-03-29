import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/episode_item.dart';
import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../../utils.dart';
import '../loading_indicator.dart';
import '../try_again_message.dart';
import 'video_player_controls_overlay.dart';

enum VideoPlayerState {
  initialized,
  loading,
  error,
}

class VideoPlayerView extends StatefulWidget {
  final String titleText;
  final bool subtitlesEnabled;
  final bool isLiveStream;

  final Future<EpisodeItem> Function() onInitialPlayableItem;
  final Future<EpisodeItem> Function()? onSkipPrevious;
  final Future<EpisodeItem> Function()? onSkipNext;

  /// при обновлении времени просмотра
  final Function(
    EpisodeItem episode,
    int position,
    bool subtitlesEnabled,
  ) onUpdatePosition;

  const VideoPlayerView({
    super.key,
    required this.titleText,
    required this.subtitlesEnabled,
    this.isLiveStream = false,
    required this.onInitialPlayableItem,
    this.onSkipPrevious,
    this.onSkipNext,
    required this.onUpdatePosition,
  });

  @override
  createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  /// флаг, чтобы спросить о продолжении просмотра один раз
  bool _initialize = false;

  /// состояние страницы
  VideoPlayerState _pageState = VideoPlayerState.loading;

  /// контроллер видеоплеера
  VideoPlayerController? _playerController;

  YoutubePlayerController? _youtubeController;

  EpisodeItem? _episode;

  bool _isControlOverlayVisible = true;
  late final RestartableTimer _showControlsOverlayTimer;

  /// индикатор загрузки данных
  bool get isLoading => _pageState == VideoPlayerState.loading;

  /// включены или выключены субтитры
  late bool _subtitlesEnabled;

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

    /// включены или выключены субтитры
    _subtitlesEnabled = widget.subtitlesEnabled;

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

    _youtubeController?.dispose();
    _youtubeController = null;
  }

  String getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }

  Future<ClosedCaptionFile> _loadSubtitle(String url) async {
    try {
      final data = NetworkAssetBundle(Uri.parse(url));
      final newdata = await data.load('');
      String fileContents = getStringFromBytes(newdata);
      return WebVTTCaptionFile(fileContents);
    } catch (exception) {
      return WebVTTCaptionFile('');
    }
  }

  Future<void> _initializeVideo() async {
    /// завершаем работу текущего плеера
    _disposeVideoController();

    if (_episode != null) {
      if (_episode!.videoFileUrl.contains('youtube.com')) {
        _initializeYoutubeVideo();
      } else {
        _initializeDefaultVideo();
      }
    }
  }

  Future<void> _initializeYoutubeVideo() async {
    final videoId = YoutubePlayer.convertUrlToId(_episode!.videoFileUrl) ?? '';
    if (videoId.isNotEmpty) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          showLiveFullscreenButton: false,
          hideControls: true,
          isLive: widget.isLiveStream,
          forceHD: true,
        ),
      );
      _youtubeController?.updateValue(_youtubeController!.value.copyWith(isFullScreen: true));

      /// обновляем состояние UI
      _updatePageState(VideoPlayerState.initialized);
    }
  }

  Future<void> _initializeDefaultVideo() async {
    Future<ClosedCaptionFile>? closedCaptionFile;
    if (_episode!.subtitlesFileUrl.isNotEmpty) {
      closedCaptionFile = _loadSubtitle(_episode!.subtitlesFileUrl);
    }

    _playerController = VideoPlayerController.network(_episode!.videoFileUrl,
      closedCaptionFile: closedCaptionFile,
    );

    try {
      /// инициализируем плеер
      await _playerController!.initialize().then((_) {
        /// проверяем нужную позицию
        if (_episode!.position < 60) {
          /// запускаем видео
          _playerController!.play();
        }

        /// обновляем информацию о просмотре
        _playerController!.addListener(_changeVideoPositionListener);

        /// обновляем состояние UI
        _updatePageState(VideoPlayerState.initialized);
      });

    } catch (exception) {
      /// ^ если при загрузке видео произошла ошибка
      
      debugPrint('$exception');

      /// обновляем состояние UI
      _updatePageState(VideoPlayerState.error);
    }
  }

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);
    
    if (_pageState == VideoPlayerState.initialized) {
      if (_youtubeController != null) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: YoutubePlayer(
              controller: _youtubeController!,
            ),
          ),
        );
      }

      if (!_initialize && _episode!.position >= 60) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final result = await Utils.showModal<bool?>(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                /// кнопка продолжить просмотр
                SizedBox(
                  width: 320.0,
                  child: ElevatedButton(
                    autofocus: true,
                    style: KrsTheme.filledTonalButtonStyleOf(context),
                    onPressed: () {
                      if (mounted) {
                        /// перематываем на нужную позицию и запускаем видео
                        _playerController?.seekTo(Duration(seconds: _episode!.position - 5))
                          .then((_) {
                            _playerController?.play();
                          });

                        /// закрываем диалоговое окно
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(locale.continueWatching),
                  ),
                ),

                /// кнопка начать сначала
                SizedBox(
                  width: 320.0,
                  child: ElevatedButton(
                    autofocus: true,
                    style: KrsTheme.filledTonalButtonStyleOf(context),
                    onPressed: () {
                      if (mounted) {
                        /// запускаем видео
                        _playerController?.play();

                        /// закрываем диалоговое окно
                        Navigator.pop(context, false);
                      }
                    },
                    child: Text(locale.startOver),
                  ),
                ),

              ],
            ),
          );

          /// если при выборе нажали кнопку назад - закрываем плеер
          if (result == null) {
            if (mounted) {
              Navigator.pop(context);
            }
          }
          
        });
      }
      
      _initialize = true;
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
              if (!widget.isLiveStream) SafeArea(
                child: VideoPlayerControlsOverlay(
                  titleText: widget.titleText,
                  subtitleText: '${_episode!.seasonNumber}x${_episode!.episodeNumber} ${_episode!.name}',
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


  int _lastPosition = 0;
  /// слушатель изменения позиции просмотра виде
  void _changeVideoPositionListener() {

    /// текущая позиция просмотра видео
    final position = _playerController?.value.position.inSeconds ?? 0;

    if (_lastPosition == position) {
      return;
    }
    
    _lastPosition = position;

    /// общая продолжительность видео
    final duration = _playerController?.value.duration.inSeconds ?? 0;

    if (position % 10 == 0 || position == duration) {
      /// сохраняем информацию о времени просмотра эпизода
      widget.onUpdatePosition(_episode!,  position, _subtitlesEnabled);
    }

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
    Future<EpisodeItem> Function() playableItemGetter
  ) async {
    /// завершаем работу текущего плеера
    _disposeVideoController();
    
    /// запрашиваем новое видео
    _episode = await playableItemGetter();
    
    /// инициализируем новый плеер
    _initializeVideo();
  }

}
