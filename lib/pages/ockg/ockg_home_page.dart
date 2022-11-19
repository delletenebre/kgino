import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../models/ockg/ockg_bestsellers_category.dart';
import '../../models/ockg/ockg_movie.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/ockg/ockg_bestsellers_category_list.dart';
import '../../ui/pages/ockg/ockg_movie_details.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OckgMovieDetailsController(),
      child: Column(
        children: [
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

                //return const LoadingIndicator();
              }
            ),
          ),

          SizedBox(
            height: 252.0,
            child: BlocProvider(
              create: (context) => OckgBestsellersController(),
              child: BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
                builder: (context, state) {
                  if (state.isSuccess) {
                    return ListView.separated(
                      clipBehavior: Clip.none,
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
                            controller.getMovie(movie);
                          }
                        );
                        
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24.0);
                      },
                      
                    );
                  }

                  return const LoadingIndicator(
                    color: Colors.lightBlueAccent
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
