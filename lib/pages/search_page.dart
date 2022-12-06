import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controllers/ockg/ockg_search_controller.dart';
import '../controllers/tskg/tskg_search_controller.dart';
import '../resources/krs_locale.dart';
import '../ui/lists/category_list_item.dart';
import '../ui/lists/home_page_vertical_list_view.dart';
import '../ui/lists/krs_horizontal_list_view.dart';
import '../ui/lists/krs_list_item_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    final ockgSearch = context.watch<OckgSearchController>().state;
    final tskgSearch = context.watch<TskgSearchController>().state;

    final items = <CategoryListItem>[];
    if (ockgSearch.isSuccess) {
      items.add(
        CategoryListItem(
          title: locale.movies,
          items: ockgSearch.data,
        )
      );
    }
    if (tskgSearch.isSuccess) {
      items.add(
        CategoryListItem(
          title: locale.shows,
          items: tskgSearch.data,
        )
      );
    }

    // if (ockgSearch.isLoading) {
    //   return const LoadingIndicator();
    // }

    if (items.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: HomePageVerticalListView(
          itemCount: items.length,
          itemBuilder: (context, focusNode, index) {
            final item = items[index];

            return SizedBox.fromSize(
              size: const Size.fromHeight(200.0),
              child: KrsHorizontalListView(
                focusNode: focusNode,
                onItemFocused: (index) {
                  // context.read<TskgShowDetailsController>().getShowById(
                  //   showItem.items.elementAt(index).showId,
                  // );
                },
                titleText: item.title,
                itemCount: item.items.length,
                itemBuilder: (context, focusNode, index) {
                  final show = item.items.elementAt(index);
                  
                  return KrsListItemCard(
                    focusNode: focusNode,
                    item: show,
                    
                    /// при выб оре элемента
                    onTap: () {
                      /// переходим на страницу деталей о сериале
                      context.goNamed('tskgShowDetails',
                        params: {
                          'id': show.showId,
                        },
                      );

                    },
                  );
                },
              ),
            );
          },
          
        )
      );

      // return SingleChildScrollView(
      //   controller: _autoScrollController,
      //   padding: const EdgeInsets.all(32.0),
      //   child: SizedBox(
      //     width: double.maxFinite,
      //     child: Wrap(
      //       clipBehavior: Clip.none,
      //       alignment: WrapAlignment.center,
      //       spacing: 24.0,
      //       runSpacing: 24.0,
      //       // children: items.mapIndexed((index, item) {
      //       //   if (item is OckgMovie) {
      //       //     return AutoScrollTag(
      //       //       key: ValueKey(index), 
      //       //       controller: _autoScrollController,
      //       //       index: index,
      //       //       child: OckgMovieCard(
      //       //         movie: item,
      //       //         onMovieFocused: (movie, focusNode) {
      //       //           _autoScrollController.scrollToIndex(index,
      //       //             // preferPosition: AutoScrollPosition.begin,
      //       //             duration: KrsTheme.fastAnimationDuration,
      //       //           );
      //       //         },
      //       //       ),
      //       //     );
      //       //   } else {
      //       //     return TskgShowCard(
      //       //       show: item,
      //       //       onTap: () {
      //       //         /// переходим на страницу деталей о фильме
      //       //         context.goNamed('tskgShowDetails', params: {
      //       //           'id': item.showId,
      //       //         });
      //       //       },
      //       //     );
      //       //   }
              
      //       // }).toList(),
      //     ),
      //   ),
      // );
    }

    return const SizedBox();

    // return Column(
    //   children: [
    //     Expanded(
    //       child: Builder(
    //         builder: (context) {
              
    //         },
    //       ),
    //     ),

    //   ],
    // );
  }
}