import 'package:flutter/material.dart';

import '../resources/krs_locale.dart';
import 'krs_chip.dart';

enum MovieRatingType {
  imdb,
  kinopoisk,
}


class MovieRating extends StatelessWidget {
  final MovieRatingType type;
  final double rating;

  const MovieRating({
    super.key,
    required this.type,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    late final String typeText;
    switch (type) {
      case MovieRatingType.imdb:
        typeText = 'IMDb';
        break;
      case MovieRatingType.kinopoisk:
        typeText = locale.kinopoisk;
        break;
    }

    Color? ratingColor;
    if (rating >= 7.0) {
      ratingColor = Colors.green.shade700;
    } else if (rating < 5.0) {
      ratingColor = theme.colorScheme.error;
    }

    return KrsChip(
      child: Row(
        children: [
          Text(typeText),

          const SizedBox(width: 4.0),

          Text(rating.toStringAsFixed(1),
            style: TextStyle(
              color: ratingColor,
              fontWeight: FontWeight.bold,
              // shadows: [
              //   Shadow(
              //     blurRadius: 2.0,
              //     offset: const Offset(0.0, 1.0),
              //     color: theme.colorScheme.shadow.withOpacity(0.36),
              //   )
              // ]
            ),
          ),
        ],
      ),
    );
  }
}