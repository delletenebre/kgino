import 'package:decorated_icon/decorated_icon.dart';
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
    final theme = Theme.of(context);

    /// размер иконки
    const iconSize = 64.0;

    late Widget child;

    if (isPlaying) {
      /// ^ если видео проигрывается

      child = DecoratedIcon(Icons.pause,
        /// для правильной работы анимации, необходим параметр key
        key: const ValueKey(1),
        size: iconSize,
        shadows: [
          BoxShadow(
            blurRadius: 12.0,
            color: theme.scaffoldBackgroundColor,
          ),
        ],
      );
      
    } else {
      /// ^ если видео на паузе
      
      child = DecoratedIcon(Icons.play_arrow,
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