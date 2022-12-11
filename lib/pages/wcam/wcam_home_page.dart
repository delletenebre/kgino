import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../controllers/wcam_controller.dart';
import '../../models/category_list_item.dart';
import '../../models/movie_item.dart';
import '../../ui/lists/krs_horizontal_list_view.dart';
import '../../ui/lists/krs_list_item_card.dart';
import '../../ui/lists/krs_vertical_list_view.dart';
import '../../ui/loading_indicator.dart';

class WcamHomePage extends StatelessWidget {
  const WcamHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WcamController(),
      child: BlocBuilder<WcamController, RequestState<List<MovieItem>>>(
        builder: (context, state) {

          if (state.isLoading) {
            return const LoadingIndicator();
          }

          final categories = <CategoryListItem<MovieItem>>[];

          // if (seenShows.isNotEmpty) {
          //   showList.add(
          //     CategoryListItem<MovieItem>(
          //       title: locale.continueWatching,
          //       items: seenShows,
          //     )
          //   );
          // }

          if (state.isSuccess) {
            categories.add(
              CategoryListItem(
                title: 'Elcat.kg',
                items: state.data,
              )
            );
          }

          if (categories.isNotEmpty) {
            return KrsVerticalListView(
              itemCount: categories.length,
              itemBuilder: (context, focusNode, index) {
                final category = categories[index];

                return SizedBox.fromSize(
                  size: const Size.fromHeight(tskgListViewHeight + 16.0),
                  child: KrsHorizontalListView(
                    focusNode: focusNode,
                    onItemFocused: (index) {
                      // context.read<WcamController>().getShowById(
                      //   category.items[index].id,
                      // );
                    },
                    titleText: category.title,
                    itemCount: category.items.length,
                    itemBuilder: (context, focusNode, index) {
                      final item = category.items.elementAt(index);
                      
                      return KrsListItemCard(
                        focusNode: focusNode,
                        item: item,
                        
                        /// при выб оре элемента
                        onTap: () {
                          /// переходим на страницу деталей о сериале
                          context.goNamed('wcamPlayer',
                            extra: item.seasons.first.episodes.first,
                          );

                        },
                      );
                    },
                  ),
                );
              },
              
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}