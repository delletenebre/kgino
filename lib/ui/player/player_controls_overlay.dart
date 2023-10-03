import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

import '../../resources/constants.dart';
import '../../resources/krs_locale.dart';
import '../details_page/krs_menu_button.dart';
import 'controls/play_pause_button.dart';
import 'controls/player_progress_bar.dart';

class PlayerControlsOverlay extends StatefulHookConsumerWidget {
  final String title;
  final String subtitle;
  final Function()? onSkipNext;
  final Function()? onSkipPrevious;
  final Function(int quality)? onQualityChanged;
  final Function(bool enabled)? onSubtitlesChanged;

  final Function(int position)? onSavePositionRequested;

  final List<int> qualities;
  final int quality;

  /// null - нет субтитров, true - включены, false - выключены
  final bool? hasSubtitles;

  const PlayerControlsOverlay({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.onSkipNext,
    this.onSkipPrevious,
    this.onSubtitlesChanged,
    this.onSavePositionRequested,
    this.qualities = const [],
    this.quality = 0,
    this.onQualityChanged,
    this.hasSubtitles,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    playingSubscription?.cancel();
    _visibilityTimer?.cancel();
    _progressBarFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    showOverlay();
    playingSubscription ??=
        controller(context).player.stream.position.listen((position) {
      final playing = controller(context).player.state.playing;
      if (_visible && playing && !_menuOpened) {
        if (_visibilityTimer == null || _visibilityTimer!.isActive == false) {
          _visibilityTimer?.cancel();
          _visibilityTimer = Timer(const Duration(seconds: 5), () {
            _progressBarFocusNode.requestFocus();
            setState(() {
              _visible = false;
            });
          });
        }
      } else {
        _visibilityTimer?.cancel();
      }

      if (playing) {
        final positionInSeconds = position.inSeconds;
        if (positionInSeconds % 10 == 0 &&
            _lastSavedPosition != positionInSeconds) {
          _lastSavedPosition = positionInSeconds;
          widget.onSavePositionRequested?.call(positionInSeconds);
        }
      }
    });

    super.didChangeDependencies();
  }

  void showOverlay() {
    if (!_visible) {
      _progressBarFocusNode.requestFocus();
      setState(() {
        _visible = true;
      });
    }
    _visibilityTimer?.cancel();
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
          if (controller(context).player.state.playing) {
            controller(context).player.pause();
          } else {
            context.pop();
          }
        }

        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          controller(context).player.playOrPause();
        }

        showOverlay();

        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: () {
          showOverlay();
        },
        child: AnimatedOpacity(
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
              const Center(
                child: PlayPauseButton(),
              ),

              /// прогресс бар, дополнительные кнопки управления
              Positioned(
                bottom: TvUi.vPadding,
                left: TvUi.hPadding,
                right: TvUi.hPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// прогресс бар
                    PlayerProgressBar(
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
                              '${widget.quality}',
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
                            icon: const Icon(Icons.subtitles),
                            label: Text(locale.enableSubtitles),
                          ),
                        if (widget.hasSubtitles == true)
                          OutlinedButton.icon(
                            onPressed: () async {
                              /// вызываем пользовательский обработчик
                              /// выключения субтитров
                              widget.onSubtitlesChanged?.call(false);
                            },
                            icon: const Icon(Icons.subtitles_off),
                            label: Text(locale.disableSubtitles),
                          ),
                        //   VideoPlayerControlsButton(
                        //     onPressed: () {
                        //       /// вызываем пользовательский обработчик включения
                        //       /// субтитров
                        //       widget.onSubtitleToggle(true);
                        //     },
                        //     icon: const Icon(Icons.subtitles),
                        //     child: Text(locale.enableSubtitles),
                        //   ),

                        // /// кнопка выключения субтитров
                        // if (hasSubtitles && widget.subtitlesEnabled)
                        //   VideoPlayerControlsButton(
                        //     onPressed: () {
                        //       /// вызываем пользовательский обработчик выключения
                        //       /// субтитров
                        //       widget.onSubtitleToggle.call(false);
                        //     },
                        //     icon: const Icon(Icons.subtitles_off),
                        //     child: Text(locale.disableSubtitles),
                        //   ),

                        const Expanded(
                          child: SizedBox(),
                        ),

                        /// кнопка перехода к предыдущему эпизоду
                        if (widget.onSkipPrevious != null)
                          OutlinedButton(
                            onPressed: () {
                              widget.onSkipPrevious?.call();
                            },
                            child: const Icon(Icons.skip_previous_outlined),
                          ),

                        /// разделитель
                        if (widget.onSkipPrevious != null &&
                            widget.onSkipNext != null)
                          const SizedBox(width: 12.0),

                        /// кнопка перехода к следующему эпизоду
                        if (widget.onSkipNext != null)
                          OutlinedButton(
                            onPressed: () {
                              widget.onSkipNext?.call();
                            },
                            child: const Icon(Icons.skip_next_outlined),
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
