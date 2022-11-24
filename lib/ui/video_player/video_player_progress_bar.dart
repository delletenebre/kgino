import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProgressBar extends StatefulWidget {
  /// обработчик при перемотке видео
  final Function(Duration)? onSeek;

  /// контроллер видеоплеера
  final VideoPlayerController? playerController;
  
  const VideoPlayerProgressBar({
    super.key,
    this.onSeek,
    this.playerController,
  });

  @override
  State<VideoPlayerProgressBar> createState() => _VideoPlayerProgressBarState();
}

class _VideoPlayerProgressBarState extends State<VideoPlayerProgressBar> {

  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.playerController == null) {
      /// ^ если видео не инициализировано
      return const ProgressBar(
        progress: Duration.zero,
        total: Duration.zero,
        timeLabelTextStyle: TextStyle(
          fontSize: 16.0,
          fontFeatures: [
            FontFeature.tabularFigures(),
          ],
        ),
      );

    } else {
      
      return RawKeyboardListener(
        focusNode: focusNode,

        onKey: (event) {

          /// текущая позиция видео
          final position = widget.playerController!.value.position;
          
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
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
          valueListenable: widget.playerController!,
          builder: (context, video, child) {

            return ProgressBar(
              progress: video.position,
              total: video.duration,
              
              onSeek: (duration) {
                /// вызываем пользовательский обработчик перемотки видео
                widget.onSeek?.call(duration);
              },

              barHeight: 6,

              thumbRadius: focusNode.hasFocus ? 12.0 : 6.0,
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
}