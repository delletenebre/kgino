import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/tskg/tskg_news_controller.dart';
import '../../../models/tskg/tskg_show.dart';
import '../../loading_indicator.dart';
import 'tskg_shows_list_view.dart';

class TskgHomePageListView extends StatelessWidget {
  const TskgHomePageListView({
    super.key,
  });

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => TskgNewsController(),
      child: BlocBuilder<TskgNewsController, RequestState<List<TskgShow>>>(
        builder: (context, state) {
          if (state.isSuccess) {

            return SizedBox.fromSize(
              size: const Size.fromHeight(104.0 + 12.0 + 4.0 + 28.0 + 20.0),
              child: TskgShowsListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                // focusNodes: _elementsFocusNodes,
                shows: state.data,
                onShowFocused: (movie) {
                  //widget.onShowFocused.call(movie);
                },
                onScrollEnd: () {

                },
              ),
            );

            // return ListView.separated(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 32.0,
            //   ),
            //   itemCount: state.data.length,
            //   itemBuilder: (context, index) {
            //     final news = state.data[index];

            //     // return OckgBestsellersCategoryList(
            //     //   category: bestsellersCategory,
            //     //   onMovieFocused: (movie) {
            //     //     final controller = context.read<OckgMovieDetailsController>();
            //     //     controller.getMovieById(movie.movieId);
            //     //   },
            //     //   onTitleFocused: () {
            //     //     if (index == 0) {
            //     //       /// ^ когда в фокусе первый заголовок списка бестселлеров
                      
            //     //       /// показываем популярный фильм
            //     //       context.read<OckgMovieDetailsController>().showPopularMovies();
            //     //     }
                    
            //     //   },
            //     // );

            //     return SizedBox.fromSize(
            //       size: const Size.fromHeight(140.0 + 12.0 + 4.0 + 28.0 + 20.0),
            //       child: TskgShowsListView(
            //         padding: null,
            //         // focusNodes: _elementsFocusNodes,
            //         shows: state.data,
            //         onShowFocused: (movie) {
            //           widget.onShowFocused.call(movie);
            //         },
            //         onScrollEnd: () {

            //         },
            //       ),
            //     );
                
            //   },
            //   separatorBuilder: (context, index) {
            //     return const SizedBox(height: 12.0);
            //   },
            // );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}