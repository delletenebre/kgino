import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:kgino/extensions/duration.dart';

import '../../../resources/krs_locale.dart';
import '../../models/media_item.dart';
import '../../providers/providers.dart';

class PlayButton extends HookConsumerWidget {
  final MediaItem mediaItem;
  // final String routeName;
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

    final query = storage.db.mediaItemEpisodes
        .where()
        .idStartsWith('${mediaItem.isarId}@')
        .sortByUpdatedAtDesc();

    /// сохранённый в базе данных элемент
    final seenEpisodesStream = useStream<List<MediaItemEpisode>>(
      query.watch(),
      initialData: query.findAll(),
    );

    final seenEpisodes = seenEpisodesStream.data ?? <MediaItemEpisode>[];
    MediaItemEpisode playingEpisode = mediaItem.episodes().first;
    if (seenEpisodes.isNotEmpty) {
      /// ^ если у сериала есть просмотреные серии

      /// получаем эпизод, с которого нужно продолжить просмотр
      playingEpisode = seenEpisodes.first;
      if (playingEpisode.isSeen) {
        final episodes = mediaItem.episodes();
        final episodeIndex =
            episodes.indexWhere((element) => element.id == playingEpisode.id);

        if (episodeIndex < episodes.length - 2) {
          playingEpisode = episodes[episodeIndex + 1];
        }
      }
    }

    /// кнопка начала просмотра
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -40.0 - ((playingEpisode.position > 0) ? 16.0 : 0.0),
          child: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: focused.value
                ? PlayButtonTooltip(
                    episode: playingEpisode,
                  )
                : null,
          ),
        ),
        FilledButton.icon(
          autofocus: true,
          onFocusChange: (hasFocus) {
            focused.value = hasFocus;
          },
          onPressed: () {
            /// переходим на страницу плеера фильма
            context.pushNamed(
              'player',
              queryParameters: {},
              extra: mediaItem,
            );
          },
          icon: const Icon(Icons.play_arrow),
          label: Text(locale.play),
        )
      ],
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
    return Column(
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
      ],
    );

    // if (kginoItem.seasons.first.episodes.length > 1) {
    //   final episode = kginoItem.seasons.first.episodes.first;
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Text(
    //         '${episode.seasonNumber} сезон, ${episode.episodeNumber} серия',
    //         style: const TextStyle(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       if (episode.name.isNotEmpty)
    //         Text(
    //           episode.name,
    //           style: const TextStyle(
    //             fontSize: 10.0,
    //           ),
    //         ),
    //     ],
    //   );
    // }

    return const SizedBox();
  }
}
