import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayPauseButton extends HookWidget {
  final bool isPlaying;

  final void Function() onTap;
  const PlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    /// размер иконки
    const iconSize = 64.0;

    late Widget child;

    if (isPlaying) {
      /// ^ если видео проигрывается
      child = Icon(
        Icons.pause,

        /// для правильной работы анимации, необходим параметр key
        key: const ValueKey('pause'),
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
        key: const ValueKey('play'),
        size: iconSize,
        shadows: [
          BoxShadow(
            blurRadius: 12.0,
            color: theme.scaffoldBackgroundColor,
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox.square(
        dimension: 256.0,
        child: AnimatedSwitcher(
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
        ),
      ),
    );
  }
}
