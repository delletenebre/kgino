import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/movie_item.dart';
import '../../../resources/krs_locale.dart';
import '../../../utils.dart';
import '../../movie_rating.dart';

class OckgMovieDetais extends StatelessWidget {
  final OckgMovieItem movie;
  final bool expanded;

  const OckgMovieDetais({
    super.key,
    required this.movie,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);
    final size = MediaQuery.of(context).size;

    /// определяем ширину постера на фоне
    final width = (size.width < 420.0) ? size.width + (size.width * 0.1) : 420.0;

    /// TODO fix it
    // final audioSixChannels = movie.seasons.first.episodes.where((file) {
    //   final audios = file.metainfo.audio;
    //   return audios.where((audio) => audio.info.contains('6ch')).isNotEmpty;
    // }).isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [

        /// постер фильма
        Positioned(
          /// отступ вверх, на размер навигационной панели
          top: -72.0,
          right: 0.0,

          width: width,
          // странный хак, без этого ShaderMask режет картинку
          // либо убрать верхний отступ
          height: size.height - 32.0,

          child: ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (rect) {
              return const RadialGradient(
                center: Alignment.topRight,
                radius: 1.0,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [0.25, 1.0],
              ).createShader(rect);
            },

            /// постер фильма
            child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
            ),
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
                Text(movie.name,
                  style: theme.textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                /// оригинальное название фильма
                if (expanded && movie.originalName.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(movie.originalName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                    children: [

                      /// год выпуска, жанры (оставляем не более двух)
                      Text([ movie.year, ... movie.genres.take(2) ].join(', ')),

                      const SizedBox(width: 12.0),

                      /// продолжительность фильма (или общая для сериала)
                      if (movie.seasons.first.episodes.length == 1) Text(
                        Utils.formatDuration(Duration(
                          seconds: movie.seasons.first.episodes.first.duration,
                        ))
                      ),

                      /// количество эпизодов (файлов), если сериал
                      if (movie.seasons.first.episodes.length > 1) Text(
                        locale.episodesCount(movie.seasons.first.episodes.length)
                      ),

                      const SizedBox(width: 12.0),

                      /// страны фильма (оставляем не более двух)
                      Text(movie.countries.take(2).join(', ')),
                      
                    ],
                  ),
                ),
                
                /// рейтинги фильма
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      
                      /// рейтинг IMDb
                      if (movie.hasImdbRating) Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MovieRating(
                          type: MovieRatingType.imdb,
                          rating: movie.ratingImdb,
                        ),
                      ),

                      // /// рейтинг КиноПоиск
                      if (movie.hasKinopoiskRating) Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MovieRating(
                          type: MovieRatingType.kinopoisk,
                          rating: movie.ratingKinopoisk,
                        ),
                      ),

                      /// качество видео
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 8.0),
                      //   child: KrsChip(
                      //     child: Text(movie.quality),
                      //   ),
                      // ),

                      /// TODO fix it
                      /// если звук 5.1
                      // if (audioSixChannels) Padding(
                      //   padding: const EdgeInsets.only(right: 8.0),
                      //   child: KrsChip(
                      //     child: Row(
                      //       children: const [
                      //         Padding(
                      //           padding: EdgeInsets.only(right: 4.0),
                      //           child: Icon(Icons.volume_up),
                      //         ),
                              
                      //         Text('5.1')
                      //       ],
                      //     ),
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
                  child: Text(movie.description,
                    maxLines: expanded ? 10 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),
          ),
        ),
        
      ],
    );
  }
}
