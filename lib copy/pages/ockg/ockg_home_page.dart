import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgino/constants.dart';

import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/movie_item.dart';
import '../../ui/pages/movie_details_view.dart';
import '../../ui/pages/ockg/ockg_home_page_list_view.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OckgMovieDetailsController(),//..showPopularMovies()
      child: Column(
        children: [
          /// детали фильма, при фокусе на каком-либо фильме
          /// или первый популярный фильм, если ничего не выбрано
          Expanded(
            child: BlocBuilder<OckgMovieDetailsController, RequestState<OckgMovieItem>>(
              builder: (context, state) {
                if (state.isSuccess) {
                  final movieItem = state.data;

                  return MovieDetaisView(movieItem,
                    posterOffset: const Offset(0.0, -400),
                  );
                  
                }

                return const SizedBox();
              }
            ),
          ),

          /// список фильмов внизу страницы
          SizedBox(
            height: ockgListViewHeight + 24.0,
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
