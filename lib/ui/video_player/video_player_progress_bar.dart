import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProgressBar extends StatefulWidget {
  /// обработчик при перемотке видео
  final Function(Duration)? onSeek;

  /// обработчик при перемотке видео
  final Function() onEnter;

  /// контроллер видеоплеера
  final VideoPlayerController playerController;
  
  const VideoPlayerProgressBar({
    super.key,
    this.onSeek,
    required this.onEnter,
    required this.playerController,
  });

  @override
  State<VideoPlayerProgressBar> createState() => _VideoPlayerProgressBarState();
}

class _VideoPlayerProgressBarState extends State<VideoPlayerProgressBar> {

  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return RawKeyboardListener(
      focusNode: _focusNode,

      onKey: (event) {

        /// текущая позиция видео
        final position = widget.playerController.value.position;

        if (event.isKeyPressed(LogicalKeyboardKey.select) || event.isKeyPressed(LogicalKeyboardKey.enter)) {
          /// ^ если нажата кнопка выбора
          
          widget.onEnter?.call();

        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          /// ^ если нажата кнопка "влево"
          
          /// вызываем пользовательский обработчик перемотки видео
          widget.onSeek?.call(Duration(seconds: position.inSeconds - 10));

        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          /// ^ если нажата кнопка "вправо"
          
          /// вызываем пользовательский обработчик перемотки видео
          widget.onSeek?.call(Duration(seconds: position.inSeconds + 10));

        }
        
      },
      child: ValueListenableBuilder(
        valueListenable: widget.playerController,
        builder: (context, video, child) {
          return ProgressBar(
            progress: video.position,
            total: video.duration,
            buffered: video.buffered.last.end,
            
            onSeek: (duration) {
              /// вызываем пользовательский обработчик перемотки видео
              widget.onSeek?.call(duration);
            },

            barHeight: 6,

            thumbRadius: _focusNode.hasFocus ? 12.0 : 6.0,
            thumbGlowRadius: 24,

            timeLabelType: TimeLabelType.remainingTime,
            timeLabelLocation: TimeLabelLocation.sides,

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