import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kgino/utils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../../controllers/seen_items_controller.dart';
import '../../../controllers/tskg/tskg_favorites_controller.dart';
import '../../../controllers/tskg/tskg_news_controller.dart';
import '../../../controllers/tskg/tskg_show_details_controller.dart';
import '../../../models/seen_item.dart';
import '../../../models/tskg/tskg_show.dart';
import '../../../resources/krs_locale.dart';
import '../../lists/krs_horizontal_list_view.dart';
import '../../lists/krs_vertical_list_view.dart';
import '../../loading_indicator.dart';
import 'tskg_loading_card.dart';
import 'tskg_show_card.dart';

class TskgHomePageListView extends StatelessWidget {
  const TskgHomePageListView({
    super.key,
  });

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);
    final tskgFavoritesController = GetIt.instance<TskgFavoritesController>();
    final seenItemsController = GetIt.instance<SeenItemsController>();
    

    return ValueListenableBuilder(
      valueListenable: seenItemsController.listenable,
      builder: (context, seenItemsBox, _) {
        
        /// список последних просмотренных сериалов
        final seenShows = seenItemsController.findByTag(SeenItem.tskgTag)
            .map((seenItem) {
              return TskgShow(
                showId: seenItem.id,
                name: seenItem.name,
              );
            });
        
        return ValueListenableBuilder(
          valueListenable: tskgFavoritesController.listenable!,
          builder: (context, favoritesBox, _) {
            
            /// список избранных сериалов
            final favoriteShows = tskgFavoritesController.sorted.map((favoriteShow) {
              return TskgShow(
                showId: favoriteShow.showId,
                name: favoriteShow.name,
              );
            });

            return BlocProvider<TskgNewsController>(
              create: (context) => TskgNewsController(),
              child: BlocBuilder<TskgNewsController, RequestState<List<TskgShow>>>(
                builder: (context, state) {
                  final showList = [];

                  if (seenShows.isNotEmpty) {
                    showList.add({
                      'titleText': locale.continueWatching,
                      'shows': seenShows,
                    });
                  }

                  if (state.isLoading) {
                    showList.add({
                      'titleText': locale.addedDate('today'),
                      'shows': [],
                    });
                  }

                  if (state.isSuccess) {
                    final news = state.data;

                    /// за сколько дней показывать последние добавления
                    const lastAddedDays = 2;
                    
                    /// сериалы сгруппированные по дате добавления
                    final showsGroupedByDate = groupBy(
                      news,
                      (item) => item.date,
                    );

                    for (int index = 0; index < lastAddedDays; index++) {
                      final date = showsGroupedByDate.keys.elementAt(index)!;
                        
                      late final String titleText;
                      if (date.isToday) {
                        titleText = locale.addedDate('today');
                      } else if (date.isYesterday) {
                        titleText = locale.addedDate('yesterday');
                      } else {
                        titleText = locale.addedDate(Jiffy(date).MMMMd);
                      }

                      final shows = showsGroupedByDate.values.elementAt(index);

                      showList.add({
                        'titleText': titleText,
                        'shows': shows
                      });

                    }
                  }

                  if (favoriteShows.isNotEmpty) {
                    showList.add({
                      'titleText': locale.favorites,
                      'shows': favoriteShows,
                    });
                  }

                  if (showList.isNotEmpty) {
                    return KrsVerticalListView(
                      key: ValueKey(showList.length),
                      itemCount: showList.length,
                      itemBuilder: (context, index) {
                        final showItem = showList[index];

                        if (showItem['shows'].isEmpty) {
                          return SizedBox.fromSize(
                            size: const Size.fromHeight(tskgListViewHeight + 16.0),
                            child: KrsHorizontalListView(
                              titleText: showItem['titleText'],
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return const TskgLoadingCard();
                              }
                            ),
                          );
                        }

                        return SizedBox.fromSize(
                          size: const Size.fromHeight(tskgListViewHeight + 16.0),
                          child: KrsHorizontalListView(
                            onItemFocused: (index) {
                              context.read<TskgShowDetailsController>().getShowById(
                                showItem['shows'].elementAt(index).showId,
                              );
                            },
                            titleText: showItem['titleText'],
                            itemCount: showItem['shows'].length,
                            itemBuilder: (context, index) {
                              final show = showItem['shows'].elementAt(index);
                              
                              return TskgShowCard(
                                show: show,
                                
                                /// при выб оре элемента
                                onTap: () {
                                  /// переходим на страницу деталей о фильме
                                  context.goNamed('tskgShowDetails', params: {
                                    'id': show.showId,
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
                },
              ),
            );
          },
        );
      },
    );
    
  }
}