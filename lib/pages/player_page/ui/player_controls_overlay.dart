import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// import '../../../../providers/locale_provider.dart';
import '../../../extensions/video_player_controller_extensions.dart';
import '../../../resources/kika_theme.dart';
import '../../../ui/buttons/kika_menu_button.dart';
import 'controls/ended_at.dart';
import 'controls/play_pause_button.dart';
import 'controls/player_progress_bar.dart';
import 'controls/subtitles_button.dart';

class PlayerControlsOverlay extends StatefulHookConsumerWidget {
  final VideoPlayerController controller;
  final String title;
  final String subtitle;
  final Function()? onSkipNext;
  final Function()? onSkipPrevious;
  final Function(String quality)? onQualityChanged;
  final Function(bool enabled)? onSubtitlesChanged;

  final Function(int position)? onSavePositionRequested;

  final Function() onReload;

  final List<String> qualities;
  final String quality;

  /// null - нет субтитров, true - включены, false - выключены
  final bool? hasSubtitles;

  /// позиция последнего  просмотра
  final int initialPosition;

  final bool menuOpened;

  /// нужно ли показывать ProgressBar (скрыть для live-stream)
  final bool progressBarEnabled;

  const PlayerControlsOverlay({
    super.key,
    required this.controller,
    this.title = '',
    this.subtitle = '',
    this.onSkipNext,
    this.onSkipPrevious,
    this.onSubtitlesChanged,
    this.onSavePositionRequested,
    required this.onReload,
    this.qualities = const [],
    this.quality = '',
    this.onQualityChanged,
    this.hasSubtitles,
    this.initialPosition = 0,
    this.menuOpened = false,
    this.progressBarEnabled = true,
  });

  @override
  ConsumerState<PlayerControlsOverlay> createState() =>
      _PlayerControlsOverlayState();
}

class _PlayerControlsOverlayState extends ConsumerState<PlayerControlsOverlay> {
  Timer? _visibilityTimer;
  bool _visible = false;
  final _progressBarFocusNode = FocusNode();
  final _reloadButtonFocusNode = FocusNode();

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
    _reloadButtonFocusNode.dispose();

    super.dispose();
  }

  @override
  void deactivate() {
    Future.microtask(() {
      widget.controller.pause();
    });
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
    if (mounted) {
      final value = widget.controller.value;

      /// событие о начале или остановке просмотра
      final isPlaying = value.isPlaying;

      Future.microtask(() {
        /// уведомляем о состоянии загрузки буфера
        isBufferingNotifier.value = value.isBuffering;

        /// уведомляем, если начали или остановили просмотр
        isPlayingNotifier.value = isPlaying;
      });

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
    // final locale = Locale.of(context);

    return Focus(
      autofocus: true,
      skipTraversal: true,
      onKeyEvent: (node, event) {
        if (HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.escape) ||
            HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.backspace)) {
          if (widget.controller.value.isPlaying == true) {
            widget.controller.pause();
          } else {
            context.pop();
          }
        }

        if (HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.space)) {
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
                  // /// надложка
                  // Positioned.fill(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.center,
                  //         colors: [
                  //           theme.colorScheme.surface,
                  //           theme.colorScheme.surface.withOpacity(0.0),
                  //         ],
                  //         stops: const [0.0, 0.3],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  /// подложка
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            theme.colorScheme.surface,
                            Colors.transparent,
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),

                  /// во сколько закочится просмотр
                  Positioned(
                    right: 12.0,
                    top: 32.0,
                    child: EndedAt(widget.controller),
                  ),

                  Builder(
                    builder: (context) => widget.controller.value.hasError
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Ошибка загрузки видео'),
                                const SizedBox(height: 12.0),
                                Builder(builder: (context) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    _reloadButtonFocusNode.requestFocus();
                                  });
                                  return OutlinedButton(
                                    focusNode: _reloadButtonFocusNode,
                                    onPressed: widget.onReload,
                                    child: Text('Перезагрузить'),
                                  );
                                }),
                              ],
                            ),
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
                      horizontal: TvUi.hPadding,
                      vertical: TvUi.vPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget.controller.playOrPause();
                            },
                          ),
                        ),

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
                        if (widget.progressBarEnabled)
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
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: KikaMenuButton(
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
                              ),

                            /// кнопка включения/выключения субтитров
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: SubtitlesButton(
                                hasSubtitles: widget.hasSubtitles,
                                onSubtitlesChanged: (enabled) {
                                  widget.onSubtitlesChanged?.call(enabled);
                                },
                              ),
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
                          ],
                        ),
                      ],
                    ),
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

  const _TitleText(
    this.text, {
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
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
