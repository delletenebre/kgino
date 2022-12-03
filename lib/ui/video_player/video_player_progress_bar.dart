import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProgressBar extends StatefulWidget {
  final FocusNode focusNode;

  /// обработчик при перемотке видео
  final Function(Duration)? onSeek;

  /// обработчик при перемотке видео
  final Function() onEnter;

  /// контроллер видеоплеера
  final VideoPlayerController playerController;
  
  const VideoPlayerProgressBar({
    super.key,
    this.onSeek,
    required this.focusNode,
    required this.onEnter,
    required this.playerController,
  });

  @override
  State<VideoPlayerProgressBar> createState() => _VideoPlayerProgressBarState();
}

class _VideoPlayerProgressBarState extends State<VideoPlayerProgressBar> {

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      focusNode: widget.focusNode,

      onFocusChange: (hasFocus) {
        setState(() {
          
        });
      },

      onKey: (node, event) {

        /// текущая позиция видео
        final position = widget.playerController.value.position;

        if (event.isKeyPressed(LogicalKeyboardKey.select) || event.isKeyPressed(LogicalKeyboardKey.enter)) {
          /// ^ если нажата кнопка выбора
          
          widget.onEnter.call();

          return KeyEventResult.handled;

        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          /// ^ если нажата кнопка "влево"
          
          /// вызываем пользовательский обработчик перемотки видео
          widget.onSeek?.call(Duration(seconds: position.inSeconds - 10));

          return KeyEventResult.handled;

        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          /// ^ если нажата кнопка "вправо"
          
          /// вызываем пользовательский обработчик перемотки видео
          widget.onSeek?.call(Duration(seconds: position.inSeconds + 10));
          
          return KeyEventResult.handled;

        }

        return KeyEventResult.ignored;
        
      },

      child: ValueListenableBuilder(
        valueListenable: widget.playerController,
        builder: (context, video, child) {
          return ProgressBar(
            progress: video.position,
            total: video.duration,
            buffered: video.buffered.isNotEmpty ? video.buffered.last.end : null,
            
            onSeek: (duration) {
              /// вызываем пользовательский обработчик перемотки видео
              widget.onSeek?.call(duration);
            },

            barHeight: 6.0,

            thumbRadius: 8.0,

            timeLabelType: TimeLabelType.remainingTime,
            timeLabelLocation: TimeLabelLocation.sides,

            progressBarColor: widget.focusNode.hasFocus
              ? theme.colorScheme.primary : theme.colorScheme.outline,
            thumbColor: widget.focusNode.hasFocus
              ? theme.colorScheme.primary : theme.colorScheme.outline,
            

            timeLabelTextStyle: const TextStyle(
              fontSize: 16.0,
              fontFeatures: [
                FontFeature.tabularFigures(),
              ],
            ),
            timeLabelPadding: 12.0,

          );
        },
      ),
    );
  }
}