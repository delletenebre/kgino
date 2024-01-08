import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

// import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import 'controls/play_pause_button.dart';

class PlayerControlsOverlay extends StatefulHookConsumerWidget {
  final VideoPlayerController controller;
  final String title;
  final String subtitle;
  final Function()? onSkipNext;
  final Function()? onSkipPrevious;
  final Function(String quality)? onQualityChanged;
  final Function(bool enabled)? onSubtitlesChanged;

  final Function(int position)? onSavePositionRequested;

  final List<String> qualities;
  final String quality;

  /// null - нет субтитров, true - включены, false - выключены
  final bool? hasSubtitles;

  /// позиция последнего  просмотра
  final int initialPosition;

  final bool menuOpened;

  const PlayerControlsOverlay({
    super.key,
    required this.controller,
    this.title = '',
    this.subtitle = '',
    this.onSkipNext,
    this.onSkipPrevious,
    this.onSubtitlesChanged,
    this.onSavePositionRequested,
    this.qualities = const [],
    this.quality = '',
    this.onQualityChanged,
    this.hasSubtitles,
    this.initialPosition = 0,
    this.menuOpened = false,
  });

  @override
  ConsumerState<PlayerControlsOverlay> createState() =>
      _PlayerControlsOverlayState();
}

class _PlayerControlsOverlayState extends ConsumerState<PlayerControlsOverlay> {
  Timer? _visibilityTimer;
  bool _visible = false;
  final _progressBarFocusNode = FocusNode();

  int _lastSavedPosition = -1;

  StreamSubscription? playingSubscription;

  /// какое-либо меню, которое запрещает убирать интерфейс с экрана
  /// например, выбор качества видео
  bool _menuOpened = false;

  /// завершена ли загрузка видео
  bool _videoLoaded = false;

  /// нужно ли запрошивать продолжение просмотра
  bool _requestInitialPositionChange = false;

  @override
  void initState() {
    /// нужно ли запрошивать продолжение просмотра
    _requestInitialPositionChange = widget.initialPosition > 0;

    _menuOpened = widget.menuOpened;

    super.initState();

    widget.controller.addListener(videoPlayerListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(videoPlayerListener);
    playingSubscription?.cancel();
    _visibilityTimer?.cancel();
    _progressBarFocusNode.dispose();

    super.dispose();
  }

  /// уведомитель о состоянии воспроизведения
  final isPlayingNotifier = ValueNotifier<bool>(false);

  /// слушатель состояния видео-плеера
  void videoPlayerListener() {
    /// уведомляем, если начали или остановили просмотр
    isPlayingNotifier.value = widget.controller.value.isPlaying;
  }

  @override
  void didChangeDependencies() {
    showOverlay();
    // playingSubscription ??=
    //     controller(context).player.stream.position.listen((position) {
    //   final playing = controller(context).player.state.playing;
    //   if (_visible && playing && !_menuOpened) {
    //     if (_visibilityTimer == null || _visibilityTimer!.isActive == false) {
    //       _visibilityTimer?.cancel();
    //       _visibilityTimer = Timer(const Duration(seconds: 5), () {
    //         if (playing && !_menuOpened) {
    //           _progressBarFocusNode.requestFocus();
    //           unshiftSubtitles();
    //           setState(() {
    //             _visible = false;
    //           });
    //         }
    //       });
    //     }
    //   } else {
    //     _visibilityTimer?.cancel();
    //   }
    //
    //   if (playing) {
    //     final positionInSeconds = position.inSeconds;
    //     if (positionInSeconds % 10 == 0 &&
    //         _lastSavedPosition != positionInSeconds) {
    //       _lastSavedPosition = positionInSeconds;
    //       widget.onSavePositionRequested?.call(positionInSeconds);
    //     }
    //   }
    // });

    // controller(context).player.stream.buffer.first.then((value) {
    //   setState(() {
    //     _videoLoaded = true;
    //   });
    // });

    super.didChangeDependencies();
  }

  void showOverlay() {
    if (!_visible) {
      _progressBarFocusNode.requestFocus();
      shiftSubtitles();
      setState(() {
        _visible = true;
      });
    }
    _visibilityTimer?.cancel();
  }

  void shiftSubtitles() {
    // Future.microtask(() => state(context).setSubtitleViewPadding(
    //       state(context).widget.subtitleViewConfiguration.padding +
    //           const EdgeInsets.only(bottom: 100.0),
    //     ));
  }

  void unshiftSubtitles() {
    // Future.microtask(() => state(context).setSubtitleViewPadding(
    //       state(context).widget.subtitleViewConfiguration.padding,
    //     ));
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    return Focus(
      autofocus: true,
      skipTraversal: true,
      onKey: (node, event) {
        // if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
        //     event.isKeyPressed(LogicalKeyboardKey.backspace)) {
        //   if (controller(context).player.state.playing) {
        //     controller(context).player.pause();
        //   } else {
        //     context.pop();
        //   }
        // }
        //
        // if (event.isKeyPressed(LogicalKeyboardKey.space)) {
        //   controller(context).player.playOrPause();
        // }

        showOverlay();

        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: () {
          showOverlay();
        },
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: kThemeAnimationDuration,
              curve: Curves.easeInOut,
              opacity: _visible ? 1.0 : 0.0,
              child: Stack(
                children: [
                  /// подложка
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            theme.colorScheme.surface,
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.36],
                        ),
                      ),
                    ),
                  ),

                  /// название
                  Positioned(
                    top: TvUi.navigationBarSize.height + TvUi.vPadding,
                    left: TvUi.hPadding,
                    right: TvUi.hPadding,
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TitleText(
                            widget.title,
                            fontSize: 32.0,
                          ),
                          _TitleText(
                            widget.subtitle,
                            fontSize: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// кнопка остановить/продолжить воспроизведение
                  Center(
                    child: ValueListenableBuilder(
                      valueListenable: isPlayingNotifier,
                      builder: (context, isPlaying, _) {
                        return PlayPauseButton(
                          isPlaying: isPlaying,
                          onTap: () {
                            if (isPlaying) {
                              widget.controller.pause();
                            } else {
                              widget.controller.play();
                            }
                          },
                        );
                      },
                    ),
                  ),

                  /// прогресс бар, дополнительные кнопки управления
                  // Positioned(
                  //   bottom: TvUi.vPadding,
                  //   left: TvUi.hPadding,
                  //   right: TvUi.hPadding,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       /// прогресс бар
                  //       PlayerProgressBar(
                  //         focusNode: _progressBarFocusNode,
                  //         onSkipNext: () {
                  //           if (!_menuOpened) {
                  //             /// ^ если нет открытого блокирующего меню
                  //
                  //             /// запускаем следующий эпизод
                  //             widget.onSkipNext?.call();
                  //           }
                  //         },
                  //       ),
                  //
                  //       const SizedBox(height: 24.0),
                  //
                  //       /// кнопки управления
                  //       Row(
                  //         children: [
                  //           if (widget.qualities.isNotEmpty)
                  //             KrsMenuButton(
                  //               items: widget.qualities,
                  //               textBuilder: (item) => item.toString(),
                  //               selectedValue: widget.quality,
                  //               onSelected: (value) {
                  //                 widget.onQualityChanged?.call(value);
                  //               },
                  //               icon: const Icon(
                  //                 Icons.videocam_outlined,
                  //                 size: 18.0,
                  //               ),
                  //               child: Text(
                  //                 widget.quality,
                  //               ),
                  //               onMenuOpen: () {
                  //                 _menuOpened = true;
                  //               },
                  //               onMenuClose: () {
                  //                 _menuOpened = false;
                  //               },
                  //             ),
                  //
                  //           /// кнопка включения субтитров
                  //           if (widget.hasSubtitles == false)
                  //             OutlinedButton.icon(
                  //               onPressed: () async {
                  //                 /// вызываем пользовательский обработчик включения
                  //                 /// субтитров
                  //                 widget.onSubtitlesChanged?.call(true);
                  //               },
                  //               icon: const Icon(
                  //                 Icons.subtitles,
                  //                 size: 18.0,
                  //               ),
                  //               label: Text(locale.enableSubtitles),
                  //             ),
                  //
                  //           /// кнопка выключения субтитров
                  //           if (widget.hasSubtitles == true)
                  //             OutlinedButton.icon(
                  //               onPressed: () async {
                  //                 /// вызываем пользовательский обработчик
                  //                 /// выключения субтитров
                  //                 widget.onSubtitlesChanged?.call(false);
                  //               },
                  //               icon: const Icon(
                  //                 Icons.subtitles_off,
                  //                 size: 18.0,
                  //               ),
                  //               label: Text(locale.disableSubtitles),
                  //             ),
                  //
                  //           const Expanded(
                  //             child: SizedBox(),
                  //           ),
                  //
                  //           /// кнопка перехода к предыдущему эпизоду
                  //           if (widget.onSkipPrevious != null)
                  //             OutlinedButton(
                  //               onPressed: () {
                  //                 widget.onSkipPrevious?.call();
                  //               },
                  //               child: const Icon(Icons.skip_previous_outlined),
                  //             ),
                  //
                  //           /// разделитель
                  //           if (widget.onSkipPrevious != null &&
                  //               widget.onSkipNext != null)
                  //             const SizedBox(width: 12.0),
                  //
                  //           /// кнопка перехода к следующему эпизоду
                  //           if (widget.onSkipNext != null)
                  //             OutlinedButton(
                  //               onPressed: () {
                  //                 widget.onSkipNext?.call();
                  //               },
                  //               child: const Icon(Icons.skip_next_outlined),
                  //             ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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

  const _TitleText(
    this.text, {
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shadowColor = theme.colorScheme.surface;

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: 4.0,
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
