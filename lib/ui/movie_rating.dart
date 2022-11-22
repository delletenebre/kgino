import 'package:flutter/material.dart';

import '../resources/krs_locale.dart';

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

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        // color: const Color(0xffF5C518),
        border: Border.all(
          width: 1.0,
          color: ratingColor ?? theme.colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          Text(typeText,
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),

          const SizedBox(width: 4.0),

          Text(rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 12.0,
              color: ratingColor,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  offset: const Offset(0.0, 1.0),
                  color: theme.colorScheme.shadow.withOpacity(0.36),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}