import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../controllers/ockg/ockg_catalog_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_catalog.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_list_item_card.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';
import '../../ui/pages/ockg/ockg_movies_list_view.dart';

class OckgCatalogPage extends StatelessWidget {
  final String titleText;
  final int genreId;

  const OckgCatalogPage({
    super.key,
    this.titleText = '',
    this.genreId = 0,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => OckgMovieDetailsController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 32.0,
                right: 32.0,
              ),
              child: SizedBox(
                height: 40.0,
                child: Text(titleText,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovie>>(
                builder: (context, state) {
                  if (state.isSuccess) {
                    final movie = state.data;

                    return OckgMovieDetais(
                      movie: movie,
                    );
                  }

                  return const SizedBox();
                }
              ),
            ),

            /// список фильмов внизу страницы
            SizedBox(
              height: 140.0 + 12.0 + 4.0 + 28.0 + 20.0,
              child: BlocProvider(
                create: (context) => OckgCatalogController(
                  genreId: genreId,
                ),
                child: BlocBuilder<OckgCatalogController, OckgCatalog>(
                  builder: (context, catalog) {
                    // TODO check and fix if needed
                    return KrsHorizontalListView(
                      itemCount: catalog.movies.length,
                      itemBuilder: (context, focusNode, index) {
                        final movie = catalog.movies[index];

                        return KrsListItemCard(
                          focusNode: focusNode,
                          posterSize: ockgPosterSize,
                          
                          /// данные о фильме
                          item: movie,

                          /// при выб оре элемента
                          onTap: () {
                            /// переходим на страницу деталей о фильме
                            context.goNamed('ockgMovieDetails', params: {
                              'id': '${movie.movieId}',
                            });

                          },

                          // onFocused: (focusNode) {
                          //   /// ^ при смене фокуса на этот фильм
                            
                          //   // /// прокручиваем контент к текущему элементу
                          //   // _autoScrollController.scrollToIndex(index,
                          //   //   preferPosition: AutoScrollPosition.begin,
                          //   //   duration: const Duration(milliseconds: 50),
                          //   // ).then((_) {
                          //   //   /// ^ после окончания прокрутки
                              
                          //   //   if (mounted) {
                          //   //     /// ^ если виджет ещё жив
                                
                          //   //     /// вызываем пользовательский обработчик
                          //   //     widget.onMovieFocused.call(movie);
                          //   //   }
                          //   // });
                          // },
                        );
                      },
                    );

                    //return SizedBox();
                    
                    // return OckgMoviesListView(
                    //   autofocus: true,
                    //   movies: catalog.movies,
                    //   onMovieFocused: (movie) {
                    //     final controller = context.read<OckgMovieDetailsController>();
                    //     controller.getMovieById(movie.movieId);
                    //   },
                    //   onScrollEnd: () {
                    //     context.read<OckgCatalogController>().fetchMovies();
                    //   }
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
