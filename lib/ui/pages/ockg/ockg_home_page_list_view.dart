import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kgino/constants.dart';

import '../../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../../controllers/ockg/ockg_movie_details_controller.dart';
import '../../../controllers/seen_items_controller.dart';
import '../../../models/movie_item.dart';
import '../../../models/ockg/ockg_bestsellers_category.dart';
import '../../../resources/krs_locale.dart';
import '../../../models/category_list_item.dart';
import '../../lists/krs_vertical_list_view.dart';
import '../../lists/krs_horizontal_list_view.dart';
import '../../lists/krs_list_item_card.dart';
import '../../loading_indicator.dart';

class OckgHomePageListView extends HookWidget {
  const OckgHomePageListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

     /// контроллер последних просмотренных сериалов
    final seenItemsController = GetIt.instance<SeenItemsController>();
    /// hook для подписки на изменения
    useValueListenable(seenItemsController.listenable);
    /// список последних просмотренных сериалов
    final seenMovies = seenItemsController.find(MovieItemType.ockg, count: 50);

    return BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
      builder: (context, state) {

        final categories = <CategoryListItem>[];

        if (seenMovies.isNotEmpty) {
          categories.add(
            CategoryListItem<MovieItem>(
              title: locale.continueWatching,
              items: seenMovies,
            )
          );
        }


        if (state.isSuccess) {
          categories.addAll(
            state.data.map((item) {
              return CategoryListItem<MovieItem>(
                title: item.name,
                items: item.movies.map((movie) {
                  return MovieItem(
                    type: MovieItemType.ockg,
                    id: '${movie.movieId}',
                    name: movie.name,
                    posterUrl: movie.posterUrl,
                  );
                }).toList(),
              );
            })
          );

          return KrsVerticalListView(
            itemCount: categories.length,
            itemBuilder: (context, focusNode, index) {
              final category = categories[index];

              return SizedBox.fromSize(
                size: const Size.fromHeight(ockgListViewHeight),
                child: KrsHorizontalListView(
                  focusNode: focusNode,
                  onItemFocused: (index) {
                    context.read<OckgMovieDetailsController>().getMovieById(
                      category.items[index].id,
                    );
                  },
                  titleText: category.title,
                  itemCount: category.items.length,
                  itemBuilder: (context, focusNode, index) {
                    final movie = category.items[index];

                    return KrsListItemCard(
                      focusNode: focusNode,
                      posterSize: ockgPosterSize,
                      
                      /// данные о фильме
                      item: movie,

                      /// при выб оре элемента
                      onTap: () {
                        /// переходим на страницу деталей о фильме
                        context.goNamed('ockgMovieDetails', params: {
                          'id': '${movie.id}',
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