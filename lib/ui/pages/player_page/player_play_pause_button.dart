import 'package:flutter/material.dart';
import 'package:kgino/ui/buttons/rounded_button.dart';

class PlayerPlayPauseButton extends StatelessWidget {
  final Function() onPressed;
  final bool isPlaying;
  final FocusNode? focusNode;

  const PlayerPlayPauseButton({
    Key? key,
    required this.onPressed,
    this.isPlaying = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// размер иконки
    const iconSize = 64.0;

    late Widget child;

    if (isPlaying) {
      /// ^ если видео проигрывается

      child = const Icon(Icons.pause,
        /// для правильной работы анимации, необходим параметр key
        key: ValueKey(1),
        size: iconSize,
      );
      
    } else {
      /// ^ если видео на паузе
      
      child = const Icon(Icons.play_arrow,
        /// для правильной работы анимации, необходим параметр key
        key: ValueKey(2),
        size: iconSize,
      );

    }

    return RoundedButton(
      focusNode: focusNode,
      onPressed: onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        reverseDuration: Duration.zero,
        
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 2.5,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
        
        child: child,
      ),
    );
  }
}