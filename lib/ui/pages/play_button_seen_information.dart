
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/seen_items_controller.dart';
import '../../models/movie_item.dart';
import '../../resources/krs_locale.dart';
import '../../utils.dart';

class PlayButtonSeenInformation extends StatelessWidget {
  final String itemKey;
  final MovieItem movieItem;
  final bool showEpisodeNumber;

  const PlayButtonSeenInformation({
    super.key,
    required this.itemKey,
    required this.movieItem,
    this.showEpisodeNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    /// контроллер просмотренных эпизодов
    final seenItemsController = GetIt.instance<SeenItemsController>();
    
    return ValueListenableBuilder(
      valueListenable: seenItemsController.listenable,
      builder: (context, box, child) {
        final seenItem = seenItemsController.findItemByKey(itemKey);

        /// если есть просмотренные эпизоды
        if (seenItem != null) {

          /// получаем последний просмотренный эпизод
          final seenEpisode = seenItem.getLastSeenEpisode();
          
          if (seenEpisode != null) {
            /// ^ если есть просмотренные эпизоды
            
            final playableEpisode = movieItem.getNextPlayableEpisode(seenEpisode);

            final seenValue = playableEpisode.percentPosition;
            final remainTime = playableEpisode.duration - playableEpisode.position;
            final timeString = Duration(seconds: remainTime).formatted;
          
            /// показываем информацию о последнем просмотренном эпизоде
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showEpisodeNumber) Text('${playableEpisode.seasonNumber} сезон, ${playableEpisode.episodeNumber} серия',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(playableEpisode.name.isNotEmpty
                  ? playableEpisode.name
                  : locale.continueWatching,
                  
                  style: const TextStyle(
                    fontSize: 12.0,
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

        return const SizedBox();
      },
    );
  }
}