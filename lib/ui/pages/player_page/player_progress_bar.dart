import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlayerProgressBar extends StatefulWidget {
  /// обработчик при перемотке видео
  final Function(Duration)? onSeek;

  final VideoPlayerController? playerController;
  
  const PlayerProgressBar({
    Key? key,
    this.onSeek,
    this.playerController,
  }) : super(key: key);

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {

  final focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    if (widget.playerController == null) {
      /// ^ если видео не инициализировано

      return const ProgressBar(
        progress: Duration.zero,
        total: Duration.zero,
      );

    } else {
      
      return RawKeyboardListener(
        focusNode: focusNode,

        onKey: (event) {

          /// текущая позиция видео
          final position = widget.playerController!.value.position;
          
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            
            
            /// вызываем пользовательский обработчик перемотки видео
            widget.onSeek?.call(Duration(seconds: position.inSeconds - 10));

          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            
            
            /// вызываем пользовательский обработчик перемотки видео
            widget.onSeek?.call(Duration(seconds: position.inSeconds + 10));

          }
          
        },
        child: ValueListenableBuilder(
          valueListenable: widget.playerController!,
          builder: (context, VideoPlayerValue video, child) {
            return ProgressBar(
              progress: video.position,
              total: video.duration,
              onSeek: (duration) {
                /// вызываем пользовательский обработчик перемотки видео
                widget.onSeek?.call(duration);
              },

              barHeight: 6,

              thumbRadius: focusNode.hasFocus ? 12 : 6,
              thumbGlowRadius: 24,

              timeLabelType: TimeLabelType.remainingTime,
              timeLabelLocation: TimeLabelLocation.sides,

              timeLabelTextStyle: const TextStyle(
                fontSize: 22.0
              ),

            );
          },
        ),
      );
    }
  }
}