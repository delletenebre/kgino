import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../../models/ockg/ockg_bestsellers_category.dart';
import '../../lists/krs_horizontal_list_view2.dart';
import '../../loading_indicator.dart';
import 'ockg_bestsellers_category_list.dart';
import 'ockg_movie_card.dart';

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
              horizontal: 32.0,
            ),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final bestsellersCategory = state.data[index];

              return SizedBox.fromSize(
                size: const Size.fromHeight(300 + 16.0),
                child: KrsHorizontalListView2(
                  titleText: bestsellersCategory.name,
                  itemCount: bestsellersCategory.movies.length,
                  itemBuilder: (context, focusNode, index) {
                    final movie = bestsellersCategory.movies[index];

                    return OckgMovieCard(
                      focusNode: focusNode,
                      
                      /// данные о фильме
                      movie: movie,

                      onMovieFocused: (movie, focusNode) {
                        /// ^ при смене фокуса на этот фильм
                        
                        // /// прокручиваем контент к текущему элементу
                        // _autoScrollController.scrollToIndex(index,
                        //   preferPosition: AutoScrollPosition.begin,
                        //   duration: const Duration(milliseconds: 50),
                        // ).then((_) {
                        //   /// ^ после окончания прокрутки
                          
                        //   if (mounted) {
                        //     /// ^ если виджет ещё жив
                            
                        //     /// вызываем пользовательский обработчик
                        //     widget.onMovieFocused.call(movie);
                        //   }
                        // });
                      },
                    );
                  },
                ),
              );
              // return OckgBestsellersCategoryList(
              //   category: bestsellersCategory,
              //   onMovieFocused: (movie) {
              //     final controller = context.read<OckgMovieDetailsController>();
              //     controller.getMovieById(movie.movieId);
              //   },
              //   onTitleFocused: () {
              //     if (index == 0) {
              //       /// ^ когда в фокусе первый заголовок списка бестселлеров
                    
              //       /// показываем популярный фильм
              //       context.read<OckgMovieDetailsController>().showPopularMovies();
              //     }
                  
              //   },
              // );
              
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