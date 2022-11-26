import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../models/tskg/tskg_show.dart';
import '../../ui/pages/tskg/tskg_home_page_list_view.dart';

class TskgHomePage extends StatelessWidget {
  const TskgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TskgShowDetailsController(),
      child: Column(
        children: [
          /// детали фильма, при фокусе на каком-либо фильме
          /// или первый популярный фильм, если ничего не выбрано
          Expanded(
            child: BlocBuilder<TskgShowDetailsController, RequestState<TskgShow>>(
              builder: (context, state) {
                if (state.isSuccess) {
                  final show = state.data;

                  return SizedBox();
                  // if (movie.showPlayButton) {
                  //   return OckgMoviePopular(
                  //     movie: movie,
                  //   );
                  // } else {
                  //   return OckgMovieDetais(
                  //     movie: movie,
                  //   );
                  // }
                  
                }

                return const SizedBox();
              }
            ),
          ),

          /// список фильмов внизу страницы
          const SizedBox(
            height: 252.0,
            child: TskgHomePageListView(),
          ),
        ],
      ),
    );
  }
}