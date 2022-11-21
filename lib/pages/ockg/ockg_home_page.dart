import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/pages/ockg/ockg_home_page_list_view.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';
import '../../ui/pages/ockg/ockg_movie_popular.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OckgMovieDetailsController()..showPopularMovies(),
      child: Column(
        children: [
          /// детали фильма, при фокусе на каком-либо фильме
          /// или первый популярный фильм, если ничего не выбрано
          Expanded(
            child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovie>>(
              builder: (context, state) {
                if (state.isSuccess) {
                  final movie = state.data;

                  if (movie.showPlayButton) {
                    return OckgMoviePopular(
                      movie: movie,
                    );
                  } else {
                    return OckgMovieDetais(
                      movie: movie,
                    );
                  }
                  
                }

                return const SizedBox();
              }
            ),
          ),

          /// список фильмов внизу страницы
          SizedBox(
            height: 252.0,
            child: BlocProvider(
              create: (context) => OckgBestsellersController(),
              child: const OckgHomePageListView(),
            ),
          ),
        ],
      ),
    );
  }
}
