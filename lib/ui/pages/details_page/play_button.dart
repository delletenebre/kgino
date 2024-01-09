import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../extensions/duration_extensions.dart';
import '../../../models/media_item.dart';
import '../../../providers/providers.dart';
import '../../../resources/krs_locale.dart';

class PlayButton extends HookConsumerWidget {
  final MediaItem mediaItem;
  final void Function(bool)? onFocusChange;

  const PlayButton(
    this.mediaItem, {
    super.key,
    // required this.routeName,
    this.onFocusChange,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// хранилище данных
    final storage = ref.read(storageProvider);

    final focused = useState(false);

    /// список эпизодов
    final episodes = mediaItem.episodes;
    final seenEpisodes = storage.db.mediaItemEpisodes
        .where()
        .idStartsWith('${mediaItem.isarId}@')
        .sortByUpdatedAtDesc()
        .findAll();

    if (mediaItem.episodes.isEmpty) {
      return const SizedBox();
    }

    MediaItemEpisode playingEpisode = mediaItem.episodes.first;
    if (seenEpisodes.isNotEmpty) {
      /// ^ если у сериала есть просмотренные серии

      /// получаем эпизод, с которого нужно продолжить просмотр
      playingEpisode = seenEpisodes.first;

      if (playingEpisode.isSeen) {
        /// ^ если эпизод был просмотрен

        /// находим его индекс в общем списке эпизодов
        final episodeIndex =
            episodes.indexWhere((element) => element.id == playingEpisode.id);

        if (episodeIndex < episodes.length - 1) {
          /// ^ если есть следующий эпизод

          /// продолжаем просмотр со следующего эпизода
          playingEpisode = episodes[episodeIndex + 1];
        }
      }
    }
    final episodeIndex =
        episodes.indexWhere((element) => element.id == playingEpisode.id);

    final overlayController = OverlayPortalController();
    final layerLink = LayerLink();

    print('playingEpisode.position ${playingEpisode.position}');

    /// кнопка начала просмотра
    return CompositedTransformTarget(
      link: layerLink,
      child: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: layerLink,
            targetAnchor: Alignment.topLeft,
            followerAnchor: Alignment.bottomLeft,
            child: PlayButtonTooltip(episode: playingEpisode),
          );
        },
        child: FilledButton.icon(
          autofocus: true,
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              overlayController.show();
            } else {
              overlayController.hide();
            }
            focused.value = hasFocus;
          },
          onPressed: () {
            /// переходим на страницу плеера
            context.pushNamed(
              'player',
              queryParameters: {
                'episodeIndex': '$episodeIndex',
                'initialPosition': '${playingEpisode.position}',
              },
              extra: mediaItem,
            );
          },
          icon: const Icon(Icons.play_arrow),
          label: Text(locale.play),
        ),
      ),
    );
  }
}

class PlayButtonTooltip extends HookWidget {
  final MediaItemEpisode episode;
  final bool isNotMovie;

  const PlayButtonTooltip({
    super.key,
    required this.episode,
    this.isNotMovie = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final seenValue = episode.viewed;
    final remainTime = episode.duration - episode.position;
    final timeString = Duration(seconds: remainTime).formatted;

    /// показываем информацию о последнем просмотренном эпизоде
    return Container(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (episode.hasShowNumbers)
                ? '${episode.seasonNumber} сезон, ${episode.episodeNumber} серия'
                : ' ',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            episode.name.isNotEmpty ? episode.name : locale.continueWatching,
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
          if (episode.position > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 3.0),
                    width: 128.0,
                    height: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: LinearProgressIndicator(
                        value: seenValue,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'осталось $timeString',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
