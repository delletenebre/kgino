import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/ockg/ockg_movie.dart';

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
        Row(
          children: [

            SvgPicture.asset('assets/images/kinopoisk-logo-colored-on-whitebackground-rus.svg',
              height: 20.0,
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffF5C518),
              ),
              child: Row(
                children: [
                  const Text('IMDb',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),

                  const SizedBox(width: 4.0),

                  Text(movie.ratingImdbValue.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12.0),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffff5500).withOpacity(0.62),
                // gradient: RadialGradient(
                //   center: Alignment.centerLeft,
                //   colors: [
                //     Color(0xffff5500),
                //     Color(0xffbbff00),
                //   ],
                //   radius: 5.5,
                //   stops: [0.5, 1.0],
                //   transform: GradientRotation(0.9),
                // ),
              ),
              
              child: Row(
                children: [
                  const Text('КиноПоиск',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),

                  const SizedBox(width: 4.0),

                  Text(movie.ratingKinopoiskValue.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(movie.year),
        Text(movie.description),
        
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