import 'dart:async';
import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

class PlayerProgressBar extends StatefulWidget {
  final FocusNode? focusNode;

  const PlayerProgressBar({
    super.key,
    this.focusNode,
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

  late bool playing = controller(context).player.state.playing;
  late Duration position = controller(context).player.state.position;
  late Duration duration = controller(context).player.state.duration;
  late Duration buffer = controller(context).player.state.buffer;

  final List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (subscriptions.isEmpty) {
      subscriptions.addAll(
        [
          controller(context).player.stream.playing.listen((event) {
            setState(() {
              playing = event;
            });
          }),
          controller(context).player.stream.completed.listen((event) {
            setState(() {
              position = Duration.zero;
            });
          }),
          controller(context).player.stream.position.listen((event) {
            setState(() {
              if (!tapped) {
                position = event;
              }
            });
          }),
          controller(context).player.stream.duration.listen((event) {
            setState(() {
              duration = event;
            });
          }),
          controller(context).player.stream.buffer.listen((event) {
            setState(() {
              buffer = event;
            });
          }),
        ],
      );
    }
  }

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
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
        if (event.isKeyPressed(LogicalKeyboardKey.select) ||
            event.isKeyPressed(LogicalKeyboardKey.enter)) {
          /// ^ если нажата кнопка выбора

          controller(context).player.playOrPause();

          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          /// ^ если нажата кнопка "влево"

          _seekRepeatDelta += 5;

          if (_seekRepeatDelta > fiveMinutes) {
            _seekRepeatDelta = fiveMinutes;
          }

          /// вызываем пользовательский обработчик перемотки видео
          controller(context)
              .player
              .seek(Duration(seconds: position.inSeconds - _seekRepeatDelta));

          return KeyEventResult.handled;
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          /// ^ если нажата кнопка "вправо"

          _seekRepeatDelta += 5;

          if (_seekRepeatDelta > fiveMinutes) {
            _seekRepeatDelta = fiveMinutes;
          }

          /// вызываем пользовательский обработчик перемотки видео
          controller(context)
              .player
              .seek(Duration(seconds: position.inSeconds + _seekRepeatDelta));

          return KeyEventResult.handled;
        }

        _seekRepeatDelta = 10;

        return KeyEventResult.ignored;
      },
      child: ProgressBar(
        progress: position,
        total: duration,
        buffered: buffer,
        onSeek: (duration) {
          /// вызываем пользовательский обработчик перемотки видео
          controller(context).player.seek(duration);
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
