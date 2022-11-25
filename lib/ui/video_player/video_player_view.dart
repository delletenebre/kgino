import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/playable_item.dart';
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

  const VideoPlayerView({
    super.key,
    required this.onInitialPlayableItem,
    this.onSkipPrevious,
    this.onSkipNext,
  });

  @override
  createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  /// состояние страницы
  VideoPlayerState _pageState = VideoPlayerState.loading;

  VideoPlayerController? _playerController;
  late PlayableItem _playableItem;

  bool _isControlOverlayVisible = true;
  late final RestartableTimer _showControlsOverlayTimer;

  /// индикатор загрузки данных
  bool get isLoading => _pageState == VideoPlayerState.loading;

  /// обновление состояния страницы
  void updatePageState(VideoPlayerState state) {
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
    widget.onInitialPlayableItem().then((playableItem) {
      _playableItem = playableItem;
      _initializeVideo();
    });

    /// инициализируем таймер скрытия панели управления плеером
    _showControlsOverlayTimer = RestartableTimer(const Duration(seconds: 5), () {
      if (mounted && (_playerController?.value.isPlaying ?? false)) {
        setState(() {
          _isControlOverlayVisible = false;
        });
      }
    });
    
    /// останавливаем таймер скрытия панели управления плеером
    //_showControlsOverlayTimer.cancel();
  }

  @override
  void dispose() {
    _playerController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    updatePageState(VideoPlayerState.loading);

    _playerController?.dispose();

    _playerController = VideoPlayerController.network(_playableItem.videoUrl);
    // _playerController = VideoPlayerController.network('https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_30MB.mp4');//(widget.videoUrl);
    
    try {
      /// инициализируем плеер
      await _playerController!.initialize();

      /// запускаем видео
      await _playerController!.play();

      /// перематываем в нужную позицию
      await _playerController!.seekTo(Duration(seconds: _playableItem.startTime));

      /// обновляем информацию о просмотре
      //_playerController.addListener(changeVideoPositionListener);

      /// обновляем состояние UI
      updatePageState(VideoPlayerState.initialized);

    } catch (exception) {
      /// ^ если при загрузке видео произошла ошибка
      
      /// обновляем состояние UI
      updatePageState(VideoPlayerState.error);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: ((context) {
          if (_pageState == VideoPlayerState.loading) {
            /// ^ если загрузка видео
            
            return const LoadingIndicator(
              size: 64.0,
            );
          }

          if (_pageState == VideoPlayerState.error) {
            /// ^ если произошла ошибка
            
            return TryAgainMessage(
              onRetry: _initializeVideo,
            );
          }
          
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              if (_playerController!.value.isInitialized) Center(
                child: AspectRatio(
                  aspectRatio: _playerController!.value.aspectRatio,
                  child: VideoPlayer(_playerController!),
                ),
              ),

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
                    _playerController?.dispose();
                    _playableItem = await widget.onSkipNext!.call();
                    _initializeVideo();
                  },
                  
                  onSkipPrevious: widget.onSkipPrevious == null ? null : () async {
                    _playerController?.dispose();
                    _playableItem = await widget.onSkipPrevious!.call();
                    _initializeVideo();
                  },
                  
                ),
              ),
            ],
          );
        }),
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
}