import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayPauseButton extends StatefulWidget {
  final Function() onPressed;
  final bool isPlaying;
  final FocusNode? focusNode;

  const PlayPauseButton({
    super.key,
    required this.onPressed,
    this.isPlaying = false,
    this.focusNode,
  });

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// размер иконки
    const iconSize = 64.0;

    late Widget child;

    if (widget.isPlaying) {
      /// ^ если видео проигрывается
      child = Icon(Icons.pause,
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
      
      child = Icon(Icons.play_arrow,
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

    return Focus(
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          return KeyEventResult.handled;
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: IconButton(
        focusNode: widget.focusNode,
        onPressed: widget.onPressed,
        icon: AnimatedSwitcher(
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
      ),
    );
  }
}