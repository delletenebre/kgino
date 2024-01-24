import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../extensions/video_player_controller_extensions.dart';
// import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

import '../../resources/krs_locale.dart';
import '../../resources/krs_theme.dart';
import '../buttons/krs_menu_button.dart';
import 'controls/fullscreen_button.dart';
import 'controls/play_pause_button.dart';
import 'controls/player_progress_bar.dart';

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

  /// последняя время просмотра в секундах
  int _lastSavedPosition = -1;

  StreamSubscription? playingSubscription;

  /// какое-либо меню, которое запрещает убирать интерфейс с экрана
  /// например, выбор качества видео
  bool _menuOpened = false;
  //
  // /// завершена ли загрузка видео
  // bool _videoLoaded = false;
  //
  // /// нужно ли запрашивать продолжение просмотра
  // bool _requestInitialPositionChange = false;

  @override
  void initState() {
    // /// нужно ли запрашивать продолжение просмотра
    // _requestInitialPositionChange = widget.initialPosition > 0;

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

  @override
  void deactivate() {
    widget.controller.pause();
    exitFullScreen();
    super.deactivate();
  }

  /// уведомитель о состоянии воспроизведения
  final isPlayingNotifier = ValueNotifier<bool>(false);

  /// уведомитель о состоянии буферизации видео
  final isBufferingNotifier = ValueNotifier<bool>(true);

  /// уведомитель о состоянии перехода на весь экран
  final isFullscreenNotifier = ValueNotifier<bool>(false);

  /// слушатель состояния видео-плеера
  void videoPlayerListener() {
    final value = widget.controller.value;
    isBufferingNotifier.value = value.isBuffering;

    /// уведомляем, если начали или остановили просмотр
    final isPlaying = value.isPlaying;
    isPlayingNotifier.value = isPlaying;

    if (_visible && isPlaying && !_menuOpened) {
      if (_visibilityTimer == null || _visibilityTimer!.isActive == false) {
        _visibilityTimer?.cancel();
        _visibilityTimer = Timer(const Duration(seconds: 5), () {
          if (isPlaying && !_menuOpened) {
            _progressBarFocusNode.requestFocus();
            unshiftSubtitles();
            setState(() {
              _visible = false;
            });
          }
        });
      }
    } else {
      _visibilityTimer?.cancel();
    }

    if (isPlaying) {
      /// чтобы экран не переходил в режим сна
      WakelockPlus.enable();

      final positionInSeconds = value.position.inSeconds;
      if (positionInSeconds > 10 &&
          positionInSeconds % 5 == 0 &&
          _lastSavedPosition != positionInSeconds) {
        _lastSavedPosition = positionInSeconds;
        widget.onSavePositionRequested?.call(positionInSeconds);
      }
    } else {
      /// позволяем экрану перейти в режим сна
      WakelockPlus.disable();
    }
  }

  void enterFullScreen() {
    if (kIsWeb) {
      html.document.documentElement?.requestFullscreen();
      isFullscreenNotifier.value = true;
    }
  }

  void exitFullScreen() {
    if (kIsWeb) {
      html.document.exitFullscreen();
      isFullscreenNotifier.value = false;
    }
  }

  @override
  void didChangeDependencies() {
    showOverlay();

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
        if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
            event.isKeyPressed(LogicalKeyboardKey.backspace)) {
          if (widget.controller.value.isPlaying == true) {
            widget.controller.pause();
          } else {
            context.pop();
          }
        }

        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          widget.controller.playOrPause();
        }

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
                          stops: const [0.0, 0.5],
                        ),
                      ),
                    ),
                  ),

                  Builder(
                    builder: (context) => widget.controller.value.hasError
                        ? const Center(
                            child: Text('Ошибка загрузки видео'),
                          )
                        : Center(
                            child: ValueListenableBuilder(
                              valueListenable: isBufferingNotifier,
                              builder: (context, isBuffering, _) {
                                return ValueListenableBuilder(
                                  valueListenable: isPlayingNotifier,
                                  builder: (context, isPlaying, _) {
                                    return PlayPauseButton(
                                      isPlaying: isPlaying,
                                      isBuffering: isBuffering,
                                      onTap: () {
                                        widget.controller.playOrPause();
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TvUi.hPadding, vertical: TvUi.vPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),

                        /// название фильма или сериала
                        _TitleText(
                          widget.title,
                          fontSize: 24.0,
                        ),

                        const SizedBox(height: 4.0),

                        /// дополнительная информация (номер сезона и серии)
                        _TitleText(
                          widget.subtitle,
                          fontSize: 14.0,
                        ),

                        const SizedBox(height: 32.0),

                        /// прогресс бар
                        PlayerProgressBar(
                          controller: widget.controller,
                          focusNode: _progressBarFocusNode,
                          onSkipNext: () {
                            if (!_menuOpened) {
                              /// ^ если нет открытого блокирующего меню

                              /// запускаем следующий эпизод
                              widget.onSkipNext?.call();
                            }
                          },
                        ),

                        const SizedBox(height: 24.0),

                        /// кнопки управления
                        Row(
                          children: [
                            if (widget.qualities.isNotEmpty)
                              KrsMenuButton(
                                items: widget.qualities,
                                textBuilder: (item) => item.toString(),
                                selectedValue: widget.quality,
                                onSelected: (value) {
                                  widget.onQualityChanged?.call(value);
                                },
                                icon: const Icon(
                                  Icons.videocam_outlined,
                                  size: 18.0,
                                ),
                                child: Text(
                                  widget.quality,
                                ),
                                onMenuOpen: () {
                                  _menuOpened = true;
                                },
                                onMenuClose: () {
                                  _menuOpened = false;
                                },
                              ),

                            /// кнопка включения субтитров
                            if (widget.hasSubtitles == false)
                              OutlinedButton.icon(
                                onPressed: () async {
                                  /// вызываем пользовательский обработчик включения
                                  /// субтитров
                                  widget.onSubtitlesChanged?.call(true);
                                },
                                icon: const Icon(
                                  Icons.subtitles,
                                  size: 18.0,
                                ),
                                label: Text(locale.enableSubtitles),
                              ),

                            /// кнопка выключения субтитров
                            if (widget.hasSubtitles == true)
                              OutlinedButton.icon(
                                onPressed: () async {
                                  /// вызываем пользовательский обработчик
                                  /// выключения субтитров
                                  widget.onSubtitlesChanged?.call(false);
                                },
                                icon: const Icon(
                                  Icons.subtitles_off,
                                  size: 18.0,
                                ),
                                label: Text(locale.disableSubtitles),
                              ),

                            const Expanded(
                              child: SizedBox(),
                            ),

                            /// кнопка перехода к предыдущему эпизоду
                            if (widget.onSkipPrevious != null)
                              Tooltip(
                                message: 'Предыдущий эпизод',
                                child: OutlinedButton(
                                  onPressed: () {
                                    widget.onSkipPrevious?.call();
                                  },
                                  child:
                                      const Icon(Icons.skip_previous_outlined),
                                ),
                              ),

                            /// разделитель
                            if (widget.onSkipPrevious != null &&
                                widget.onSkipNext != null)
                              const SizedBox(width: 12.0),

                            /// кнопка перехода к следующему эпизоду
                            if (widget.onSkipNext != null)
                              Tooltip(
                                message: 'Следующий эпизод',
                                child: OutlinedButton(
                                  onPressed: () {
                                    widget.onSkipNext?.call();
                                  },
                                  child: const Icon(Icons.skip_next_outlined),
                                ),
                              ),

                            if (kIsWeb)
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12.0),
                                child: ValueListenableBuilder(
                                  valueListenable: isFullscreenNotifier,
                                  builder: (context, isFullscreen, _) {
                                    return FullscreenButton(
                                      isFullscreen: isFullscreen,
                                      onTap: () {
                                        if (isFullscreen) {
                                          exitFullScreen();
                                        } else {
                                          enterFullScreen();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// название
                  // Positioned(
                  //   top: TvUi.vPadding,
                  //   left: TvUi.hPadding,
                  //   right: TvUi.hPadding,
                  //   child: Material(
                  //     color: Colors.transparent,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         _TitleText(
                  //           widget.title,
                  //           fontSize: 24.0,
                  //         ),
                  //         _TitleText(
                  //           widget.subtitle,
                  //           fontSize: 16.0,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // /// прогресс бар, дополнительные кнопки управления
                  // Positioned(
                  //   bottom: TvUi.vPadding,
                  //   left: TvUi.hPadding,
                  //   right: TvUi.hPadding,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       /// прогресс бар
                  //       PlayerProgressBar(
                  //         controller: widget.controller,
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
    const shadowColor = Colors.black;

    return Text(
      text,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: shadowColor,
            blurRadius: fontSize,
          ),
        ],
      ),
    );
  }
}
