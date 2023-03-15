// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kgino/constants.dart';

// import '../../../models/ockg/ockg_movie.dart';
// import '../../../resources/krs_locale.dart';
// import '../../../utils.dart';
// import '../../lists/krs_list_item_card.dart';
// import '../../movie_rating.dart';

// class OckgMoviePopular extends StatelessWidget {
//   final OckgMovie movie;

//   const OckgMoviePopular({
//     super.key,
//     required this.movie,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: Row(
//         children: [
//           /// постер фильма
//           KrsListItemCard(
//             item: movie,
//             titleEnabled: false,
//             posterSize: ockgPosterSize,
//             onTap: () {
//               /// переходим на страницу деталей о фильме
//               context.goNamed('ockgMovieDetails', params: {
//                 'id': '${movie.movieId}',
//               });
//             },
//           ),

//           const SizedBox(width: 24.0),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// название фильма
//                 Text(movie.name,
//                   style: theme.textTheme.titleLarge,
//                 ),

//                 const SizedBox(height: 4.0),

//                 Row(
//                   children: [

//                     /// год выпуска, жанры (оставляем не более двух)
//                     Text([ movie.year, ... movie.genres.take(2) ].join(', ')),

//                     const SizedBox(width: 8.0),

//                     /// продолжительность фильма (или общая для сериала)
//                     Text(Utils.formatDuration(movie.playtimeDuration)),

//                     const SizedBox(width: 8.0),

//                     /// страны фильма (оставляем не более двух)
//                     Text(movie.countries.take(2).join(', ')),
                    
//                   ],
//                 ),
                
//                 /// рейтинги фильма
//                 if (movie.hasImdbRating || movie.hasKinopoiskRating) Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Row(
//                     children: [
//                       /// рейтинг IMDb
//                       if (movie.hasImdbRating) Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: MovieRating(
//                           type: MovieRatingType.imdb,
//                           rating: movie.ratingImdbValue,
//                         ),
//                       ),

//                       /// рейтинг КиноПоиск
//                       if (movie.hasKinopoiskRating) MovieRating(
//                         type: MovieRatingType.kinopoisk,
//                         rating: movie.ratingKinopoiskValue,
//                       ),
//                     ],
//                   ),
//                 ),

//                 /// описание фильма
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(movie.description,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],

//       ),
//     );
//   }
// }
