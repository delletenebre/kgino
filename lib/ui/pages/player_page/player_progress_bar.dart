import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlayerProgressBar extends StatelessWidget {
  /// обработчик при перемотке видео
  final Function(Duration)? onSeek;

  final VideoPlayerController? playerController;
  
  const PlayerProgressBar({
    Key? key,
    this.onSeek,
    this.playerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    

    if (playerController == null) {

      return const ProgressBar(
        progress: Duration.zero,
        total: Duration.zero,
      );

    } else {
      final focusNode = FocusNode();

      return RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          debugPrint('event: $event');

          /// текущая позиция видео
          final position = playerController!.value.position;
          
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            /// вызываем пользовательский обработчик перемотки видео
            onSeek?.call(Duration(seconds: position.inSeconds - 10));
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            /// вызываем пользовательский обработчик перемотки видео
            onSeek?.call(Duration(seconds: position.inSeconds + 10));
          }
          
        },
        child: ValueListenableBuilder(
          valueListenable: playerController!,
          builder: (context, VideoPlayerValue video, child) {
            return ProgressBar(
              progress: video.position,
              total: video.duration,
              onSeek: (duration) {
                debugPrint('User selected a new time: $duration');

                /// вызываем пользовательский обработчик перемотки видео
                onSeek?.call(duration);
              },
            );
          },
        ),
      );
    }
  }
}