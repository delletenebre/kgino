import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/video_player_item.dart';
import '../pages/try_again_message.dart';
import 'video_player_controls_overlay.dart';

enum VideoPlayerPageState {
  playing,
  loading,
  error,
}

class VideoPlayerView extends StatefulWidget {
  final VideoPlayerItem videoPlayerItem;

  const VideoPlayerView({
    super.key,
    required this.videoPlayerItem,
  });

  @override
  createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  /// состояние страницы
  VideoPlayerPageState _pageState = VideoPlayerPageState.loading;

  late VideoPlayerController _playerController;

  bool _isControlOverlayVisible = true;
  late final RestartableTimer _showControlsOverlayTimer;

  /// индикатор загрузки данных
  bool get isLoading => _pageState == VideoPlayerPageState.loading;

  /// обновление состояния страницы
  void updatePageState(VideoPlayerPageState state) {
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

    /// инициализируем таймер скрытия панели управления плеером
    _showControlsOverlayTimer = RestartableTimer(const Duration(seconds: 5), () {
      if (mounted && _playerController.value.isPlaying) {
        setState(() {
          _isControlOverlayVisible = false;
        });
      }
    });
    
    /// останавливаем таймер скрытия панели управления плеером
    //_showControlsOverlayTimer.cancel();

    _initializeVideo();
    
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    updatePageState(VideoPlayerPageState.loading);

    _playerController = VideoPlayerController.network(widget.videoPlayerItem.videoUrl);
    // _playerController = VideoPlayerController.network('https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_30MB.mp4');//(widget.videoUrl);
    
    try {
      /// инициализируем плеер
      await _playerController.initialize();

      /// запускаем видео
      await _playerController.play();

      /// перематываем в нужную позицию
      await _playerController.seekTo(Duration(seconds: widget.videoPlayerItem.startTime));

      /// обновляем информацию о просмотре
      //_playerController.addListener(changeVideoPositionListener);

      /// обновляем состояние UI
      updatePageState(VideoPlayerPageState.playing);

    } catch (exception) {
      /// ^ если при загрузке видео произошла ошибка
      
      /// обновляем состояние UI
      updatePageState(VideoPlayerPageState.error);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: ((context) {
          if (_pageState == VideoPlayerPageState.error) {
            /// ^ если произошла ошибка
            
            return TryAgainMessage(
              onRetry: _initializeVideo,
            );
          }
          
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              if (_playerController.value.isInitialized) Center(
                child: AspectRatio(
                  aspectRatio: _playerController.value.aspectRatio,
                  child: VideoPlayer(_playerController),
                ),
              ),

              SafeArea(
                child: VideoPlayerControlsOverlay(
                  titleText: widget.videoPlayerItem.title,
                  subtitleText: widget.videoPlayerItem.subtitle,
                  isVisible: _isControlOverlayVisible,
                  playerController: _playerController,
                  onPlayPause: () {
                    if (_playerController.value.isPlaying) {
                      _playerController.pause();
                    } else {
                      _playerController.play();
                    }

                    /// обновляем время показа панели управления плеером
                    updateContolOverlayVisibilityTimer();
                  },

                  onSeek: (duration) {
                    /// перематываем видео
                    _playerController.seekTo(duration);

                    /// обновляем время показа панели управления плеером
                    updateContolOverlayVisibilityTimer();
                  },
                  
                  onShowOverlay: () {
                    /// показываем панель управления плеером
                    showControlOverlay();
                  },
                  
                  // onSkipNext: () {
                    
                  // },
                  
                  // onSkipPrevious: () {
                    
                  // },
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