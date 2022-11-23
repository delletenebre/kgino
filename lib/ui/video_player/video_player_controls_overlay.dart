import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../resources/krs_theme.dart';
import '../loading_indicator.dart';
import 'play_pause_button.dart';
import 'video_player_progress_bar.dart';

class VideoPlayerControlsOverlay extends StatefulWidget {

  /// контроллер видеоплеера
  final VideoPlayerController playerController;

  /// название эпизода
  final String titleText;
  final String subtitleText;

  final bool isVisible;

  /// обработчик запроса предыдущего видео
  final Function() onSkipPrevious;

  /// обработчик запроса следующего видео
  final Function() onSkipNext;

  /// обработчик при перемотке видео
  final Function(Duration) onSeek;

  /// обработчик при play/pause
  final Function() onPlayPause;

  /// обработчик при нажатии на обрабатываемую плеером клавишу
  final Function(LogicalKeyboardKey) onShowOverlay;

  const VideoPlayerControlsOverlay({
    super.key,
    required this.playerController,
    required this.titleText,
    this.subtitleText = '',
    required this.isVisible,

    required this.onSkipNext,
    required this.onSkipPrevious,
    required this.onSeek,
    required this.onPlayPause,
    required this.onShowOverlay,
  });

  @override
  State<VideoPlayerControlsOverlay> createState() => _VideoPlayerControlsOverlayState();
}

class _VideoPlayerControlsOverlayState extends State<VideoPlayerControlsOverlay> {

  final _overlayFocusNode = FocusScopeNode();
  final _playButtonFocusNode = FocusNode();

  bool get isLoading => !widget.playerController.value.isInitialized
      || widget.playerController.value.isBuffering;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _overlayFocusNode.dispose();
    _playButtonFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.isVisible) {
      /// ^ если панель управления отображается
      
      /// запрашиваем фокус на кнопку остановки/продолжения проигрывания
      _playButtonFocusNode.requestFocus();
    }

    return FocusScope(
      autofocus: true,
      node: _overlayFocusNode,
      onKey: (node, event) {
        widget.onShowOverlay(event.logicalKey);

        if (widget.isVisible) {
          return KeyEventResult.ignored;
        } else {
          return KeyEventResult.handled;
        }
        
      },
      child: AnimatedOpacity(
        duration: KrsTheme.animationDuration,
        opacity: widget.isVisible ? 1.0 : 0.0,
        child: Stack(
          children: [
            /// название видео
            AnimatedPositioned(
              duration: KrsTheme.animationDuration,
              top: widget.isVisible ? 48.0 : 0.0,
              left: 48.0,
              right: 48.0,
              child: Column(
                children: [
                  /// название видео
                  Text(widget.titleText,
                    style: TextStyle(
                      fontSize: 24.0,
                      shadows: [
                        Shadow(
                          color: theme.colorScheme.surface,
                          blurRadius: 24.0,
                        ),
                        Shadow(
                          color: theme.colorScheme.surface,
                          blurRadius: 24.0,
                        ),
                        Shadow(
                          color: theme.colorScheme.surface,
                          blurRadius: 24.0,
                        ),
                        Shadow(
                          color: theme.colorScheme.surface,
                          blurRadius: 24.0,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  /// дополнительная информация о видео
                  if (widget.subtitleText.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(widget.subtitleText,
                      style: TextStyle(
                        fontSize: 16.0,
                        shadows: [
                          Shadow(
                            color: theme.colorScheme.surface,
                            blurRadius: 16.0,
                          ),
                          Shadow(
                            color: theme.colorScheme.surface,
                            blurRadius: 16.0,
                          ),
                          Shadow(
                            color: theme.colorScheme.surface,
                            blurRadius: 16.0,
                          ),
                          Shadow(
                            color: theme.colorScheme.surface,
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            /// ^ если видео загружается
            // if (isLoading) const LoadingIndicator(
            //   size: 96.0,
            // ),

            /// остановить/продолжить воспроизведение
            // if (!isLoading)
            Center(
              child: ValueListenableBuilder(
                valueListenable: widget.playerController,
                builder: (context, VideoPlayerValue video, child) {
                  return PlayPauseButton(
                    focusNode: _playButtonFocusNode,
                    isPlaying: video.isPlaying,
                    onPressed: () {
                      widget.onPlayPause.call();
                    },
                  );
                },
              ),
            ),

            AnimatedPositioned(
              duration: KrsTheme.animationDuration,
              bottom: widget.isVisible ? 16.0 : 0.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  VideoPlayerProgressBar(
                    playerController: widget.playerController,
                    onSeek: (duration) {
                      widget.onSeek.call(duration);
                    },
                  ),

                  const SizedBox(height: 12.0),

                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),

                      /// кнопка предыдущего видео
                      TextButton(

                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// предыдущего видео
                          widget.onSkipPrevious.call();
                        },

                        child: const Icon(Icons.skip_previous,
                          size: 24.0,
                          semanticLabel: 'Предыдущее видео',
                          shadows: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        
                      ),

                      const SizedBox(width: 16.0),

                      /// кнопка следующего видео
                      TextButton(

                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// следующего видео
                          widget.onSkipNext.call();
                        },

                        child: const Icon(Icons.skip_next,
                          size: 24.0,
                          semanticLabel: 'Следующее видео',
                          shadows: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        
                      ),

                    ],
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  
}