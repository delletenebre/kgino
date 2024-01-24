import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FullscreenButton extends HookWidget {
  final bool isFullscreen;

  final void Function() onTap;
  const FullscreenButton({
    super.key,
    required this.isFullscreen,
    required this.onTap,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    /// размер иконки
    const iconSize = 64.0;

    return Tooltip(
      message: 'На весь экран',
      child: OutlinedButton(
        onPressed: () async {
          onTap.call();
        },
        child: Icon(isFullscreen
            ? Icons.fullscreen_exit_outlined
            : Icons.fullscreen_outlined),
      ),
    );
  }
}
