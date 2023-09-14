import 'package:flutter/material.dart';

class VideoPlayerControlsButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  final Widget child;

  const VideoPlayerControlsButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(theme.colorScheme.outline),
      side: MaterialStateProperty.resolveWith((state) {
        if (state.contains(MaterialState.focused)) {
          return BorderSide(
            color: theme.colorScheme.primary,
            width: 4.0,
          );
        }
        
        return BorderSide(
          color: theme.colorScheme.outline,
          width: 1.0,
        );
      }),
    );

    if (icon != null) {
      return OutlinedButton.icon(
        style: buttonStyle,

        onPressed: () {
          onPressed?.call();
        },

        icon: icon!,
        label: child,
      );
    }

    return OutlinedButton(
      style: buttonStyle,

      onPressed: () {
        onPressed?.call();
      },

      child: child,
    );
  }
}