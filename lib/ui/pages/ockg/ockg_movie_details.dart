import 'package:flutter/material.dart';

import '../../../models/ockg/ockg_movie.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(movie.name,
          style: theme.textTheme.titleLarge,
        ),

        const SizedBox(height: 6.0),

        Row(
          children: [

            MovieRating(
              type: MovieRatingType.imdb,
              rating: movie.ratingImdbValue,
            ),

            const SizedBox(width: 12.0),

            MovieRating(
              type: MovieRatingType.kinopoisk,
              rating: movie.ratingKinopoiskValue,
            ),

            const SizedBox(width: 12.0),

            Text([ movie.year, ... movie.genres.take(3) ].join(', ')),

            const SizedBox(width: 12.0),

            Text(movie.countries.take(3).join(', ')),
            
          ],
        ),

        const SizedBox(height: 8.0),
        
        Text(movie.description,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
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