
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kgino/extensions/duration.dart';

import '../../../resources/krs_locale.dart';
import '../../models/kgino_item.dart';

class PlayButtonTooltip extends HookWidget {
  final KginoItem kginoItem;
  final bool showEpisodeNumber;

  const PlayButtonTooltip(this.kginoItem, {
    super.key,
    this.showEpisodeNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// сохранённый в базе данных элемент
    final dbItemStream = useStream(kginoItem.dbStream,
      initialData: kginoItem,
    );
    
    if (dbItemStream.hasData && dbItemStream.data != null) {
      final dbItem = dbItemStream.data!;

      /// запрашиваем последний просмотренный эпизод
      final lastSeenEpisode = dbItem.getLastSeenEpisode();

      if (lastSeenEpisode != null) {
        /// ^ если есть просмотренные эпизоды
      
        /// 
        final playableEpisode = kginoItem.getNextPlayableEpisode(lastSeenEpisode);

        final seenValue = playableEpisode.percentPosition;
        final remainTime = playableEpisode.duration - playableEpisode.position;
        final timeString = Duration(seconds: remainTime).formatted;

        /// показываем информацию о последнем просмотренном эпизоде
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${playableEpisode.seasonNumber} сезон, ${playableEpisode.episodeNumber} серия',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(playableEpisode.name.isNotEmpty
              ? playableEpisode.name
              : locale.continueWatching,
              
              style: const TextStyle(
                fontSize: 10.0,
              ),
            ),

            if (playableEpisode.position > 0) Padding(
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

                  Text('осталось $timeString',
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
      }
    }

    if (kginoItem.seasons.first.episodes.length > 1) {
      final episode = kginoItem.seasons.first.episodes.first;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${episode.seasonNumber} сезон, ${episode.episodeNumber} серия',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (episode.name.isNotEmpty) Text(episode.name,
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
        ],
      );
    }

    return const SizedBox();
    
  }
} 
