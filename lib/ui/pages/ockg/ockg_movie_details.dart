import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/ockg/ockg_movie.dart';
import '../../../utils.dart';
import '../../movie_rating.dart';

class OckgMovieDetais extends StatelessWidget {
  final OckgMovie movie;
  final bool expanded;

  const OckgMovieDetais({
    super.key,
    required this.movie,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    /// определяем ширину постера на фоне
    final width = (size.width < 480.0) ? size.width + (size.width * 0.1) : 480.0;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [

        /// постер фильма
        Positioned(
          /// отступ вверх, на размер навигационной панели
          top: -52.0,
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// название фильма
                Text(movie.name,
                  style: theme.textTheme.titleLarge,
                ),

                const SizedBox(height: 8.0),

                Row(
                  children: [

                    /// год выпуска, жанры (оставляем не более двух)
                    Text([ movie.year, ... movie.genres.take(2) ].join(', ')),

                    const SizedBox(width: 8.0),

                    /// продолжительность фильма (или общая для сериала)
                    Text(Utils.formatDuration(movie.playtimeDuration)),

                    const SizedBox(width: 8.0),

                    /// страны фильма (оставляем не более двух)
                    Text(movie.countries.take(2).join(', ')),
                    
                  ],
                ),
                
                /// рейтинги фильма
                if (movie.hasImdbRating || movie.hasKinopoiskRating) Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      /// рейтинг IMDb
                      if (movie.hasImdbRating) Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MovieRating(
                          type: MovieRatingType.imdb,
                          rating: movie.ratingImdbValue,
                        ),
                      ),

                      /// рейтинг КиноПоиск
                      if (movie.hasKinopoiskRating) MovieRating(
                        type: MovieRatingType.kinopoisk,
                        rating: movie.ratingKinopoiskValue,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12.0),
                
                /// описание фильма
                Text(movie.description,
                  maxLines: expanded ? 12 : 5,
                  overflow: TextOverflow.ellipsis,
                ),
                
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}
