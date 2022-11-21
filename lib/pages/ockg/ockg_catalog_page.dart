import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/ockg/ockg_catalog_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';
import '../../ui/pages/ockg/ockg_movies_list_view.dart';

class OckgCatalogPage extends StatelessWidget {
  final int genreId;

  const OckgCatalogPage({
    super.key,
    this.genreId = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OckgMovieDetailsController(),
        child: Column(
          children: [
            Text('Название категории $genreId'),

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
                // child: BlocBuilder<OckgCatalogController, List<OckgMovie>>(
                //   builder: (context, movies) {
                //     final catalogController = context.read<OckgCatalogController>();
                //     return OckgMoviesListView(
                //       pagingController: catalogController.pagingController,
                //       onMovieFocused: (movie) {
                //         final controller = context.read<OckgMovieDetailsController>();
                //         controller.getMovieById(movie.movieId);
                //       },
                //     );
                //   },
                // ),
                child: BlocBuilder<OckgCatalogController, List<OckgMovie>>(
                  builder: (context, movies) {
                    // final catalogController = context.read<OckgCatalogController>();
                    return OckgMoviesListView(
                      movies: movies,
                      onMovieFocused: (movie) {
                        final controller = context.read<OckgMovieDetailsController>();
                        controller.getMovieById(movie.movieId);
                      },
                    );
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
