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

    Widget child = const Icon(Icons.play_arrow,
      key: ValueKey(1),
      size: 48.0,
    );

    if (!isPlaying) {
      child = const Icon(Icons.pause,
        key: ValueKey(2),
        size: 48.0,
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