import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/empty_item_message.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';


class OckgMovieDetailsPage extends StatelessWidget {
  final int movieId;

  const OckgMovieDetailsPage(this.movieId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => OckgMovieDetailsController(
          movieId: movieId,
        ),
        child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovie>>(
          builder: (context, state) {
            return EmptyItemMessage();

            if (state.isError || state.isEmpty) {
              final movie = state.data;

              return EmptyItemMessage();
            }
            
            if (state.isSuccess) {
              final movie = state.data;

              return OckgMovieDetais(
                movie: movie,
              );
            }

            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
