import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../../models/ockg/ockg_bestsellers_category.dart';
import '../../loading_indicator.dart';
import 'ockg_bestsellers_category_list.dart';

class OckgHomePageListView extends StatefulWidget {
  const OckgHomePageListView({
    super.key,
  });

  @override
  State<OckgHomePageListView> createState() => _OckgHomePageListViewState();
}

class _OckgHomePageListViewState extends State<OckgHomePageListView> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
      builder: (context, state) {
        if (state.isSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final bestsellersCategory = state.data[index];

              return OckgBestsellersCategoryList(
                category: bestsellersCategory,
                onMovieFocused: (movie) {
                  final controller = context.read<OckgMovieDetailsController>();
                  controller.getMovieById(movie.movieId);
                },
                onTitleFocused: () {
                  if (index == 0) {
                    /// ^ когда в фокусе первый заголовок списка бестселлеров
                    
                    /// показываем популярный фильм
                    context.read<OckgMovieDetailsController>().showPopularMovies();
                  }
                  
                },
              );
              
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12.0);
            },
          );
        }

        return const LoadingIndicator();
      }
    );
  }
}