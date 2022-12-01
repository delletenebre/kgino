import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../resources/krs_theme.dart';
import '../loading_indicator.dart';
import 'play_pause_button.dart';
import 'video_player_progress_bar.dart';

class VideoPlayerControlsOverlay extends StatefulWidget {

  /// контроллер видеоплеера
  final VideoPlayerController? playerController;

  /// название эпизода
  final String titleText;
  final String subtitleText;

  final bool isVisible;

  /// обработчик запроса предыдущего видео
  final Function()? onSkipPrevious;

  /// обработчик запроса следующего видео
  final Function()? onSkipNext;

  /// обработчик при перемотке видео
  final Function(Duration) onSeek;

  /// обработчик при play/pause
  final Function() onPlayPause;

  /// обработчик при нажатии на обрабатываемую плеером клавишу
  final Function() onShowOverlay;

  const VideoPlayerControlsOverlay({
    super.key,
    required this.playerController,
    required this.titleText,
    this.subtitleText = '',
    required this.isVisible,

    this.onSkipNext,
    this.onSkipPrevious,
    required this.onSeek,
    required this.onPlayPause,
    required this.onShowOverlay,
  });

  @override
  State<VideoPlayerControlsOverlay> createState() => _VideoPlayerControlsOverlayState();
}

class _VideoPlayerControlsOverlayState extends State<VideoPlayerControlsOverlay> {

  final _overlayFocusNode = FocusNode();
  final _playButtonFocusNode = FocusNode();

  bool get isLoading {
    return widget.playerController == null
      || !widget.playerController!.value.isInitialized;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _overlayFocusNode.dispose();

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

    return Focus(
      autofocus: true,
      skipTraversal: true,
      
      onKey: (node, event) {

        if (!widget.isVisible) {
          if (event.isKeyPressed(LogicalKeyboardKey.select) || event.isKeyPressed(LogicalKeyboardKey.enter)) {
            widget.onPlayPause.call();
            _playButtonFocusNode.requestFocus();
            
            return KeyEventResult.handled;
          }
        }

        widget.onShowOverlay();

        return KeyEventResult.ignored;
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
                  _TitleText(widget.titleText,
                    fontSize: 26.0,
                  ),

                  /// дополнительная информация о видео
                  if (widget.subtitleText.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: _TitleText(widget.subtitleText,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),

            /// ^ если видео загружается
            if (isLoading) const LoadingIndicator(
              size: 64.0,
            ),

            /// остановить/продолжить воспроизведение
            if (!isLoading) Center(
              child: ValueListenableBuilder(
                valueListenable: widget.playerController!,
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

            if (!isLoading) AnimatedPositioned(
              duration: KrsTheme.animationDuration,
              bottom: widget.isVisible ? 32.0 : 0.0,
              left: 32.0,
              right: 32.0,
              child: Column(
                children: [
                  if (widget.playerController!.value.duration.inSeconds > 0) Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: VideoPlayerProgressBar(
                      playerController: widget.playerController!,
                      onEnter: () {
                        widget.playerController?.play();
                      },
                      onSeek: (duration) {
                        widget.onSeek.call(duration);
                      },
                    ),
                  ),

                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),

                      /// кнопка предыдущего видео
                      if (widget.onSkipPrevious != null) OutlinedButton(
                        onPressed: () {
                          /// вызываем пользовательский обработчик запроса
                          /// предыдущего видео
                          widget.onSkipPrevious?.call();
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

                      /// кнопка следующего видео
                      if (widget.onSkipNext != null) Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: OutlinedButton(
                          onPressed: () {
                            /// вызываем пользовательский обработчик запроса
                            /// следующего видео
                            widget.onSkipNext?.call();
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

class _TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  
  const _TitleText(this.text, {
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shadowColor = theme.colorScheme.surface;

    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: 2.0,
          ),
          Shadow(
            color: shadowColor,
            blurRadius: 4.0,
          ),
          Shadow(
            color: shadowColor,
            blurRadius: 8.0,
          ),
          Shadow(
            color: shadowColor,
            blurRadius: fontSize,
          ),
          Shadow(
            color: shadowColor,
            blurRadius: fontSize,
          ),
          Shadow(
            color: shadowColor,
            blurRadius: fontSize,
          ),
          
        ],
      ),
    );
  }
}