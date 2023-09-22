import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

class PlayPauseButton extends HookWidget {
  const PlayPauseButton({
    super.key,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    /// размер иконки
    const iconSize = 64.0;

    return GestureDetector(
      onTap: () {
        controller(context).player.playOrPause();
      },
      child: SizedBox.square(
        dimension: 256.0,
        child: StreamBuilder(
          stream: controller(context).player.stream.playing,
          builder: (context, playing) {
            late Widget child;

            final isPlaying = playing.data ?? false;

            if (isPlaying) {
              /// ^ если видео проигрывается
              child = Icon(
                Icons.pause,

                /// для правильной работы анимации, необходим параметр key
                key: const ValueKey(1),
                size: iconSize,
                shadows: [
                  BoxShadow(
                    blurRadius: 12.0,
                    color: theme.colorScheme.surface,
                  ),
                ],
              );
            } else {
              /// ^ если видео на паузе

              child = Icon(
                Icons.play_arrow,

                /// для правильной работы анимации, необходим параметр key
                key: const ValueKey(2),
                size: iconSize,
                shadows: [
                  BoxShadow(
                    blurRadius: 12.0,
                    color: theme.scaffoldBackgroundColor,
                  ),
                ],
              );
            }

            return AnimatedSwitcher(
              duration: kThemeAnimationDuration * 2,
              reverseDuration: Duration.zero,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: Tween<double>(
                    begin: isPlaying ? 1.0 : 0.0,
                    end: isPlaying ? 0.0 : 1.0,
                  ).animate(animation),
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: isPlaying ? 1.0 : 3.0,
                      end: isPlaying ? 3.0 : 1.0,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
