import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api/tmdb_api_provider.dart';
import '../../../models/media_item.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/storage_provider.dart';
import '../../../ui/cards/item_card.dart';

part 'episode_card.g.dart';

@riverpod
class Details extends _$Details {
  @override
  Future<Map?> build(int? tvId, int season, int episode) => fetch();

  Future<Map?> fetch() async {
    final tmdbApi = ref.read(tmdbApiProvider);

    final item =
        await tmdbApi.tmdb.v3.tvEpisodes.getDetails(tvId ?? 0, season, episode);
    print('zzzz: item ${jsonEncode(item)}');
    return item;
  }

  bool get hasItem => state.valueOrNull != null;
}

class EpisodeCard extends HookConsumerWidget {
  final int? tmdbId;
  final MediaItemEpisode episode;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function(double position) onPressed;

  const EpisodeCard({
    super.key,
    this.tmdbId,
    required this.episode,
    this.onFocusChange,
    required this.onPressed,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = Locale.of(context);

    /// контроллер информации о сериале или фильме

    final seenEpisode = episode.saved(ref.read(storageProvider));

    final details = ref.watch(detailsProvider(
        tmdbId, seenEpisode.seasonNumber, seenEpisode.episodeNumber));

    String? episodeName;
    String imageUrl = '';

    details.whenData((data) {
      imageUrl = data?['still_path'] ?? '';
      if (imageUrl.isNotEmpty) {
        imageUrl = 'https://image.tmdb.org/t/p/w500$imageUrl';
      }

      episodeName = data?['name'];
    });

    return ItemCard(
      title: episodeName ??
          episode.nameOr('${locale.episode} ${episode.episodeNumber}'),
      imageUrl: imageUrl,
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
