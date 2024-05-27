import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class EndedAt extends HookWidget {
  final VideoPlayerController controller;

  const EndedAt(this.controller, {super.key});

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    final video = useValueListenable(controller);

    if (video.duration.inMinutes == 0) {
      return const SizedBox.shrink();
    }

    final endAt = DateTime.now().add(video.duration - video.position);

    return Text(
      'закончится в ${DateFormat('HH:mm').format(endAt)}',
      style: TextStyle(
        color: theme.colorScheme.onSurfaceVariant,
        fontFeatures: const [
          FontFeature.tabularFigures(),
        ],
        shadows: [
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 4.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 8.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 12.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 24.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 48.0,
          ),
        ],
      ),
    );
  }
}
