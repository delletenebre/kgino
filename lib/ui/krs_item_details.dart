import 'package:flutter/material.dart';
import 'package:kgino/extensions/duration.dart';

import '../models/kgino_item.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';

class KrsItemDetails extends StatelessWidget {
  final KginoItem kginoItem;
  final bool expanded;

  const KrsItemDetails({
    super.key,
    required this.kginoItem,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      height: KrsTheme.movieDetailsHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// название фильма
          Text(kginoItem.name,
            style: theme.textTheme.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          /// оригинальное название фильма
          if (expanded && kginoItem.originalName.isNotEmpty) Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(kginoItem.originalName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4.0),
              child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.0,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8)
              ),
              child: Row(
                children: [

                  /// год выпуска, жанры (оставляем не более двух)
                  Text([ kginoItem.year, ...kginoItem.genres.take(2) ].join(', ')),

                  const SizedBox(width: 12.0),

                  /// продолжительность фильма (или общая для сериала)
                  if (kginoItem.seasons.isNotEmpty && kginoItem.seasons.first.episodes.length == 1) Text(
                    kginoItem.duration.formatted
                  ),

                  /// количество эпизодов (файлов), если сериал
                  if (kginoItem.seasons.isNotEmpty && kginoItem.seasons.first.episodes.length > 1) Text(
                    locale.episodesCount(kginoItem.seasons.first.episodes.length)
                  ),

                  const SizedBox(width: 12.0),

                  /// страны фильма (оставляем не более двух)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(kginoItem.countries.take(2).join(', ')),
                  ),

                  /// озвучка
                  if (kginoItem.voiceActing.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: KrsItemDetalsChip(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.mic),
                          ),
                          
                          Text(kginoItem.voiceActing),
                        ],
                      ),
                    ),
                  ),
                  
                  /// если звук 5.1
                  // if (movie.hasSixChannels) Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: KrsChip(
                  //     dense: true,
                  //     child: Row(
                  //       children: const [
                  //         Padding(
                  //           padding: EdgeInsets.only(right: 4.0),
                  //           child: Icon(Icons.volume_up),
                  //         ),
                          
                  //         Text('5.1'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  
                ],
              ),
            ),
          ),
          
          /// рейтинги фильма
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                
                /// рейтинг IMDb
                if (kginoItem.hasImdbRating) Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: KrsItemDetalsChip(
                    child: Row(
                      children: [
                        Text('${kginoItem.imdbRating}'),
                      ],
                    ),
                  ),
                ),

                /// рейтинг КиноПоиск
                if (kginoItem.hasKinopoiskRating) Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: KrsItemDetalsChip(
                    child: Row(
                      children: [
                        Text('${kginoItem.kinopoiskRating}'),
                      ],
                    ),
                  ),
                ),

                /// качество видео
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: KrsChip(
                //     child: Text(movie.quality),
                //   ),
                // ),

                /// ограничения к просмотру
                // if (movie.mpaa.isNotEmpty) Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: KrsChip(
                //     child: Text(movie.mpaa),
                //   ),
                // ),
              ],
            ),
          ),

          /// описание фильма
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(kginoItem.description,
              maxLines: expanded ? 10 : 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        ],
      ),
    );
  }
}


class KrsItemDetalsChip extends StatelessWidget {
  final Widget child;

  const KrsItemDetalsChip({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      label: child,
      labelStyle: const TextStyle(
        fontSize: 12.0,
      ),
    );
  }
}