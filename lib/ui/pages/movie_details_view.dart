import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../models/movie_item.dart';
import '../../../resources/krs_locale.dart';
import '../../../utils.dart';
import '../krs_chip.dart';
import '../movie_rating.dart';

class MovieDetaisView extends StatelessWidget {
  final MovieItem movieItem;
  final bool expanded;
  final Offset posterOffset;

  const MovieDetaisView(this.movieItem, {
    super.key,
    this.expanded = false,
    this.posterOffset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    final size = MediaQuery.of(context).size;

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [

          /// постер фильма
          Positioned(
            /// отступ вверх, на размер навигационной панели
            top: -72.0 + posterOffset.dy,
            left: posterOffset.dx,
            right: posterOffset.dx,

            child: ExtendedImage.network(
              movieItem.posterUrl,
              fit: BoxFit.fill,
              cache: true,
              colorBlendMode: BlendMode.dstOut,
              color: theme.scaffoldBackgroundColor.withOpacity(0.95),
            ),

          ),

          Positioned(
            top: 0.0,
            left: 0.0,

            /// размер описания на 62% от ширины экрана
            width: size.width * 0.62,
            
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// название фильма
                  Text(movieItem.name,
                    style: theme.textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// оригинальное название фильма
                  if (expanded && movieItem.originalName.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(movieItem.originalName,
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
                          Text([ movieItem.year, ... movieItem.genres.take(2) ].join(', ')),

                          const SizedBox(width: 12.0),

                          /// продолжительность фильма (или общая для сериала)
                          if (movieItem.seasons.first.episodes.length == 1) Text(
                            movieItem.duration.formatted
                          ),

                          /// количество эпизодов (файлов), если сериал
                          if (movieItem.seasons.first.episodes.length > 1) Text(
                            locale.episodesCount(movieItem.seasons.first.episodes.length)
                          ),

                          const SizedBox(width: 12.0),

                          /// страны фильма (оставляем не более двух)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(movieItem.countries.take(2).join(', ')),
                          ),

                          /// озвучка
                          if (movieItem.voiceActing.isNotEmpty) Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: KrsChip(
                              dense: true,
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Icon(Icons.mic),
                                  ),
                                  
                                  Text(movieItem.voiceActing),
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
                        if (movieItem.hasImdbRating) Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MovieRating(
                            type: MovieRatingType.imdb,
                            rating: movieItem.ratingImdb,
                          ),
                        ),

                        /// рейтинг КиноПоиск
                        if (movieItem.hasKinopoiskRating) Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MovieRating(
                            type: MovieRatingType.kinopoisk,
                            rating: movieItem.ratingKinopoisk,
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
                    child: Text(movieItem.description,
                      maxLines: expanded ? 10 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
