import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../controllers/ockg/ockg_catalog_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/movie_item.dart';
import '../../models/ockg/ockg_catalog.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_horizontal_list_view_2.dart';
import '../../ui/lists/krs_list_item_card.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';

class OckgCatalogPage extends StatelessWidget {
  final MovieItem item;

  const OckgCatalogPage({
    super.key,
    required this.item,
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
                child: Text(item.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovieItem>>(
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
              height: ockgListViewHeight,
              child: BlocProvider(
                create: (context) => OckgCatalogController(
                  genreId: item.id,
                ),
                child: BlocBuilder<OckgCatalogController, OckgCatalog>(
                  builder: (context, catalog) {
                    return KrsHorizontalListView2<OckgMovie>(
                      onItemFocused: (item) {
                        context.read<OckgMovieDetailsController>().getMovieById(
                          item.movieId.toString(),
                        );
                      },
                      onLoadNextPage: (page, loadedCount) async {
                        return context.read<OckgCatalogController>().getMovies(page, loadedCount);
                      },
                      items: catalog.movies,
                      itemBuilder: (context, focusNode, index, ockgMovie) {
                        final movie = MovieItem(
                          type: MovieItemType.ockg,
                          id: '${ockgMovie.movieId}',
                          name: ockgMovie.name,
                          posterUrl: ockgMovie.posterUrl,
                        );

                        return KrsListItemCard(
                          focusNode: focusNode,
                          posterSize: ockgPosterSize,
                          
                          /// данные о фильме
                          item: movie,

                          /// при выборе элемента
                          onTap: () {
                            /// переходим на страницу деталей о фильме
                            context.goNamed('ockgMovieDetails', params: {
                              'id': movie.id,
                            });

                          },

                        );
                      },
                    );

                  },
                ),
                // child: BlocBuilder<OckgCatalogController, OckgCatalog>(
                //   builder: (context, catalog) {
                //     return KrsHorizontalListView(
                //       onItemFocused: (index) {
                //         final ockgMovie = catalog.movies[index];
                //         context.read<OckgMovieDetailsController>().getMovieById(
                //           ockgMovie.movieId.toString(),
                //         );
                //       },
                //       onLoadNextPage: () async {
                //         context.read<OckgCatalogController>().fetchMovies();
                //       },
                //       itemCount: catalog.movies.length,
                //       itemBuilder: (context, focusNode, index) {
                //         final ockgMovie = catalog.movies[index];
                //         final movie = MovieItem(
                //           type: MovieItemType.ockg,
                //           id: '${ockgMovie.movieId}',
                //           name: ockgMovie.name,
                //           posterUrl: ockgMovie.posterUrl,
                //         );

                //         return KrsListItemCard(
                //           focusNode: focusNode,
                //           posterSize: ockgPosterSize,
                          
                //           /// данные о фильме
                //           item: movie,

                //           /// при выборе элемента
                //           onTap: () {
                //             /// переходим на страницу деталей о фильме
                //             context.goNamed('ockgMovieDetails', params: {
                //               'id': movie.id,
                //             });

                //           },

                //         );
                //       },
                //     );

                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
