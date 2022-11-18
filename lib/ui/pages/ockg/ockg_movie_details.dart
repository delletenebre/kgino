import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/ui/loading_indicator.dart';

import '../../../models/ockg/ockg_movie.dart';
import '../../../utils.dart';
import '../../movie_rating.dart';

class OckgMovieDetais extends StatelessWidget {
  final OckgMovie movie;

  const OckgMovieDetais({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    /// определяем ширину постера на фоне
    final width = (size.width < 480.0) ? size.width + (size.width * 0.1) : 480.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox(width: double.maxFinite),

        Positioned(
          top: -52.0,
          right: 0,

          /// "смягчаем" границы постера
          child: ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (rect) {
              return RadialGradient(
                center: Alignment.topRight,
                radius: 1.0,
                colors: [
                  Colors.transparent,
                  theme.colorScheme.surface,
                ],
                stops: const [0.25, 1.0],
              ).createShader(rect);
            },

            /// постер фильма
            child: CachedNetworkImage(
              width: width,
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return const LoadingIndicator();
              },
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),

        ),

        // Positioned.fill(
        //   child: AnimatedContainer(
        //     duration: const Duration(seconds: 1),
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomCenter,
        //         stops: const [0, 0.5, 1],
        //         colors: [
        //           // _imageColors[0].withOpacity(0.2),
        //           // _imageColors[1].withOpacity(0.5),
        //           // _imageColors[2].withOpacity(0.5),
        //         ],
        //       )
        //     ),

        //     /// информация о сериале
        //     //child: ShowDetails(widget.id),
            
        //   ),
        // ),


        // FutureBuilder(
        //   future: movie.getPaletteGenerator(movie.coverUrl),
        //   builder: (context, snapshot) {
        //     Color colorFirst = theme.colorScheme.surface;
        //     Color colorSecond = theme.colorScheme.surface;
            
        //     if (snapshot.hasData) {
        //       final paletteGenerator = snapshot.data as PaletteGenerator;
        //       colorFirst = paletteGenerator.dominantColor?.color ?? colorFirst;
        //       colorSecond = paletteGenerator.vibrantColor?.color ?? colorSecond;
        //     }
            
        //     return AnimatedContainer(
        //       duration: KrsTheme.animationDuration,
        //       decoration: BoxDecoration(
        //         color: Colors.transparent,
        //         // gradient: LinearGradient(
        //         //   colors: [
        //         //     colorFirst,
        //         //     colorSecond,
        //         //   ]
        //         // )
        //       ),
        //     );
        //   }
        // ),

        Container(
          padding: const EdgeInsets.all(12.0),
          width: size.width * 0.62,
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
              if (movie.ratingImdbValue > 0.0 || movie.ratingImdbValue > 0.0) Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    /// рейтинг IMDb
                    if (movie.ratingImdbValue > 0.0) Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: MovieRating(
                        type: MovieRatingType.imdb,
                        rating: movie.ratingImdbValue,
                      ),
                    ),

                    /// рейтинг КиноПоиск
                    if (movie.ratingImdbValue > 0.0) MovieRating(
                      type: MovieRatingType.kinopoisk,
                      rating: movie.ratingKinopoiskValue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),
              
              /// описание фильма
              Text(movie.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}


// class GradientRotation extends GradientTransform {
//   /// Constructs a [GradientRotation] for the specified angle.
//   ///
//   /// The angle is in radians in the clockwise direction.
//   const GradientRotation(this.radians);

//   /// The angle of rotation in radians in the clockwise direction.
//   final double radians;

//   @override
//   Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
//     assert(bounds != null);
//     final double sinRadians = math.sin(radians);
//     final double oneMinusCosRadians = 1 - math.cos(radians);
//     final Offset center = bounds.center;
//     final double originX = sinRadians * center.dy + oneMinusCosRadians * center.dx;
//     final double originY = -sinRadians * center.dx + oneMinusCosRadians * center.dy;

//     return Matrix4.identity()
//       ..translate(originX, originY)
//       ..rotateZ(radians);
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) {
//       return true;
//     }
//     if (other.runtimeType != runtimeType) {
//       return false;
//     }
//     return other is GradientRotation
//         && other.radians == radians;
//   }

//   @override
//   int get hashCode => radians.hashCode;

//   @override
//   String toString() {
//     return '${objectRuntimeType(this, 'GradientRotation')}(radians: ${debugFormatDouble(radians)})';
//   }
// }