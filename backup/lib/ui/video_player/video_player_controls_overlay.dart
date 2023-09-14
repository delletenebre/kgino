import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../loading_indicator.dart';
import 'play_pause_button.dart';
import 'video_player_controls_button.dart';
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

  /// обработчик при нажатии на кнопку субтитров
  final Function(bool subtitlesEnabled) onSubtitleToggle;

  /// обработчик при выборе качества видео
  final Function()? onChangeQuality;

  final bool subtitlesEnabled;

  final int quality;

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
    required this.onSubtitleToggle,
    this.onChangeQuality,
    this.subtitlesEnabled = false,
    this.quality = 0,
  });

  @override
  State<VideoPlayerControlsOverlay> createState() => _VideoPlayerControlsOverlayState();
}

class _VideoPlayerControlsOverlayState extends State<VideoPlayerControlsOverlay> {

  final _overlayFocusNode = FocusNode();
  final _progressBarFocusNode = FocusNode();

  bool get hasSubtitles => widget.playerController?.closedCaptionFile != null;

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
    final locale = KrsLocale.of(context);

    if (widget.isVisible) {
      /// ^ если панель управления отображается
      
      /// запрашиваем фокус на кнопку остановки/продолжения проигрывания
      _progressBarFocusNode.requestFocus();
    }

    return GestureDetector(
      onTap: () {
        /// вызываем обработчик нажатия на play/pause
        widget.onPlayPause.call();
        
        /// ставим фокус на ProgressBar
        _progressBarFocusNode.requestFocus();

        widget.onShowOverlay();
      },
      child: Focus(
        autofocus: true,
        skipTraversal: true,
        
        onKey: (node, event) {
          if (!widget.isVisible) {
            /// ^ если оверлей не был виден пользователю
            
            if (event.isKeyPressed(LogicalKeyboardKey.select) || event.isKeyPressed(LogicalKeyboardKey.enter)) {
              /// ^ если был нажат Enter
              
              /// вызываем обработчик нажатия на play/pause
              widget.onPlayPause.call();
              
              /// ставим фокус на ProgressBar
              _progressBarFocusNode.requestFocus();
              
              return KeyEventResult.handled;
            }
          }

          if (event.isKeyPressed(LogicalKeyboardKey.escape) || event.isKeyPressed(LogicalKeyboardKey.backspace)) {
            if (widget.playerController == null || !widget.playerController!.value.isPlaying) {
              Navigator.of(context).pop();
            } else {
              widget.playerController?.pause();
            }
          }

          if (widget.playerController != null) {

            if (event.isKeyPressed(LogicalKeyboardKey.space)) {
              if (widget.playerController!.value.isPlaying) {
                widget.playerController?.pause();
              } else {
                widget.playerController?.play();
              }
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              widget.playerController!.position.then((position) {
                widget.playerController?.seekTo(Duration(seconds: position!.inSeconds + 10));
              });
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              widget.playerController!.position.then((position) {
                widget.playerController?.seekTo(Duration(seconds: position!.inSeconds - 10));
              });
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
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: AnimatedContainer(
                  duration: KrsTheme.animationDuration,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        widget.isVisible ? theme.colorScheme.surface : Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

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

              /// если видео загружается
              if (isLoading) const LoadingIndicator(
                size: 64.0,
              ),

              /// остановить/продолжить воспроизведение
              if (!isLoading) Center(
                child: ValueListenableBuilder(
                  valueListenable: widget.playerController!,
                  builder: (context, VideoPlayerValue video, child) {
                    return PlayPauseButton(
                      isPlaying: video.isPlaying,
                    );
                  },
                ),
              ),

              /// нижняя панель
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
                        focusNode: _progressBarFocusNode,
                        playerController: widget.playerController!,
                        onEnter: () {
                          widget.onPlayPause();
                        },
                        onSeek: (duration) {
                          widget.onSeek.call(duration);
                        },
                      ),
                    ),

                    Row(
                      children: [
                        /// кнопка включения субтитров
                        if (hasSubtitles && !widget.subtitlesEnabled) VideoPlayerControlsButton(
                          
                          onPressed: () {
                            /// вызываем пользовательский обработчик включения
                            /// субтитров
                            widget.onSubtitleToggle(true);
                            
                          },
                          icon: const Icon(Icons.subtitles),
                          child: Text(locale.enableSubtitles),
                          
                        ),

                        /// кнопка выключения субтитров
                        if (hasSubtitles && widget.subtitlesEnabled) VideoPlayerControlsButton(
                          
                          onPressed: () {
                            /// вызываем пользовательский обработчик выключения
                            /// субтитров
                            widget.onSubtitleToggle.call(false);
                          },
                          icon: const Icon(Icons.subtitles_off),
                          child: Text(locale.disableSubtitles),
                          
                        ),

                        /// кнопка смены качества видео
                        if (widget.onChangeQuality != null) VideoPlayerControlsButton(
                          
                          onPressed: () async {
                            /// вызываем пользовательский обработчик выбора
                            /// качества видео
                            widget.onChangeQuality?.call();
                          },
                          icon: const Icon(Icons.video_settings_outlined),
                          child: widget.quality == 0
                            ? Text('Качество видео')
                            : Text('${widget.quality}'),
                          
                        ),

                        const Expanded(
                          child: SizedBox(),
                        ),

                        /// кнопка предыдущего видео
                        if (widget.onSkipPrevious != null) VideoPlayerControlsButton(
                          
                          onPressed: () {
                            /// вызываем пользовательский обработчик запроса
                            /// предыдущего видео
                            widget.onSkipPrevious?.call();
                          },

                          child: Icon(Icons.skip_previous,
                            semanticLabel: locale.previousEpisode,
                          ),
                          
                        ),

                        /// кнопка следующего видео
                        if (widget.onSkipNext != null) Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: VideoPlayerControlsButton(
                            onPressed: () {
                              /// вызываем пользовательский обработчик запроса
                              /// следующего видео
                              widget.onSkipNext?.call();
                            },

                            child: Icon(Icons.skip_next,
                              semanticLabel: locale.nextEpisode,
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