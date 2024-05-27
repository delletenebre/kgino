import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/media_item.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/storage_provider.dart';
import '../../../ui/cards/item_card.dart';

class EpisodeCard extends ConsumerWidget {
  final MediaItemEpisode episode;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function(double position) onPressed;

  const EpisodeCard({
    super.key,
    required this.episode,
    this.onFocusChange,
    required this.onPressed,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);

    final seenEpisode = episode.saved(ref.read(storageProvider));

    return ItemCard(
      title: episode.nameOr('${locale.episode} ${episode.episodeNumber}'),
      //imageUrl: episode.position.toString(),
      onFocusChange: onFocusChange,
      onPressed: () {
        onPressed.call(seenEpisode.viewed);
        return KeyEventResult.handled;
      },
      endWidget: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${episode.seasonNumber}x${episode.episodeNumber}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            if (seenEpisode.viewed != 0.0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  value: seenEpisode.viewed,
                  minHeight: 2.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
