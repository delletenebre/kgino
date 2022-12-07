import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kgino/constants.dart';

import '../../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../../models/ockg/ockg_bestsellers_category.dart';
import '../../lists/krs_vertical_list_view.dart';
import '../../lists/krs_horizontal_list_view.dart';
import '../../lists/krs_list_item_card.dart';
import '../../loading_indicator.dart';

class OckgHomePageListView extends StatelessWidget {
  const OckgHomePageListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
      builder: (context, state) {
        if (state.isSuccess) {
          final categories = state.data;

          return KrsVerticalListView(
            itemCount: state.data.length,
            itemBuilder: (context, focusNode, index) {
              final bestsellersCategory = categories[index];

              return SizedBox.fromSize(
                size: const Size.fromHeight(ockgListViewHeight),
                child: KrsHorizontalListView(
                  focusNode: focusNode,
                  onItemFocused: (index) {
                    context.read<OckgMovieDetailsController>().getMovieById(
                      bestsellersCategory.movies.elementAt(index).movieId,
                    );
                  },
                  titleText: bestsellersCategory.name,
                  itemCount: bestsellersCategory.movies.length,
                  itemBuilder: (context, focusNode, index) {
                    final movie = bestsellersCategory.movies[index];

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
                    );
                  },
                ),
              );
            },
          );
        }

        return const LoadingIndicator();
      }
    );
  }
}