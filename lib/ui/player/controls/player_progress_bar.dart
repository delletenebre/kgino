import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../extensions/video_player_controller_extensions.dart';

class PlayerProgressBar extends StatefulWidget {
  final VideoPlayerController controller;
  final FocusNode? focusNode;
  final void Function()? onSkipNext;

  const PlayerProgressBar({
    super.key,
    required this.controller,
    this.focusNode,
    this.onSkipNext,
  });

  @override
  PlayerProgressBarState createState() => PlayerProgressBarState();
}

class PlayerProgressBarState extends State<PlayerProgressBar> {
  bool _focused = false;

  bool tapped = false;
  double slider = 0.0;
  int _seekRepeatDelta = 10;
  int fiveMinutes = 60 * 5;

  late bool playing = widget.controller.value.isPlaying;
  late Duration position = widget.controller.value.position;
  late Duration duration = widget.controller.value.duration;
  late DurationRange buffer = DurationRange(
    Duration.zero,
    widget.controller.value.position,
  );

  /// слушатель состояния видео-плеера
  void videoPlayerListener() {
    final value = widget.controller.value;

    if (value.isInitialized) {
      /// обновляем продолжительность
      if (duration != value.duration) {
        setState(() {
          duration = value.duration;
        });
      }

      /// обновляем состояние воспроизведения
      if (playing != value.isPlaying) {
        setState(() {
          playing = value.isPlaying;
        });
      }

      /// если видео было завершено, то вызываем следующее видео из плейлиста
      if (value.isCompleted && value.position > Duration.zero) {
        widget.onSkipNext?.call();
      }

      /// обновляем позицию воспроизведения
      setState(() {
        if (!tapped) {
          position = value.position;
        }
      });

      /// обновляем продолжительность загруженного буфера
      if (buffer != value.buffered.last) {
        setState(() {
          buffer = value.buffered.last;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    /// добавляем слушателя событий видео-контроллера
    widget.controller.addListener(videoPlayerListener);
  }

  @override
  void dispose() {
    /// удаляем слушателя событий видео-контроллера
    widget.controller.removeListener(videoPlayerListener);
    super.dispose();
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (hasFocus) {
        setState(() {
          _focused = hasFocus;
        });
      },
      onKey: (node, event) {
        // if (event is RawKeyDownEvent &&
        //         event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
        //     event.isKeyPressed(LogicalKeyboardKey.arrowRight) &&
        //         widget.controller.value.isPlaying) {
        //   widget.controller.pause();
        // } else if (event is RawKeyUpEvent &&
        //         event.data.logicalKey == LogicalKeyboardKey.arrowLeft ||
        //     event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
        //   print('play');
        //   widget.controller.play();
        // }

        if (event.isKeyPressed(LogicalKeyboardKey.select) ||
            event.isKeyPressed(LogicalKeyboardKey.enter)) {
          /// ^ если нажата кнопка выбора

          widget.controller.playOrPause();

          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          /// ^ если нажата кнопка "влево"

          _seekRepeatDelta += 5;

          if (_seekRepeatDelta > fiveMinutes) {
            _seekRepeatDelta = fiveMinutes;
          }

          /// перематываем видео
          Duration duration =
              Duration(seconds: position.inSeconds - _seekRepeatDelta);
          if (duration < Duration.zero) {
            duration = Duration.zero;
          }
          widget.controller.seekTo(duration);

          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          /// ^ если нажата кнопка "вправо"

          _seekRepeatDelta += 5;

          if (_seekRepeatDelta > fiveMinutes) {
            _seekRepeatDelta = fiveMinutes;
          }

          /// перематываем видео
          widget.controller
              .seekTo(Duration(seconds: position.inSeconds + _seekRepeatDelta));

          return KeyEventResult.handled;
        }
        _seekRepeatDelta = 10;

        return KeyEventResult.ignored;
      },
      child: ProgressBar(
        progress: position,
        total: duration,
        buffered: buffer.end,
        onSeek: (duration) {
          /// перематываем видео
          widget.controller.seekTo(duration);
        },
        barHeight: 6.0,
        thumbRadius: 8.0,
        timeLabelType: TimeLabelType.remainingTime,
        timeLabelLocation: TimeLabelLocation.sides,
        progressBarColor:
            _focused ? theme.colorScheme.primary : theme.colorScheme.outline,
        thumbColor:
            _focused ? theme.colorScheme.primary : theme.colorScheme.outline,
        timeLabelTextStyle: const TextStyle(
          fontSize: 16.0,
          fontFeatures: [
            FontFeature.tabularFigures(),
          ],
        ),
        timeLabelPadding: 12.0,
      ),
    );
  }
}
