import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kgino/utils.dart';

import '../../../constants.dart';
import '../../../controllers/seen_items_controller.dart';
import '../../../controllers/tskg/tskg_favorites_controller.dart';
import '../../../controllers/tskg/tskg_news_controller.dart';
import '../../../controllers/tskg/tskg_show_details_controller.dart';
import '../../../models/movie_item.dart';
import '../../../resources/krs_locale.dart';
import '../../lists/category_list_item.dart';
import '../../lists/krs_vertical_list_view.dart';
import '../../lists/krs_horizontal_list_view.dart';
import '../../lists/krs_list_item_card.dart';
import '../../loading_indicator.dart';

class TskgHomePageListView extends HookWidget {
  const TskgHomePageListView({
    super.key,
  });

  @override
  Widget build(context) {
    final locale = KrsLocale.of(context);
    
    /// контроллер последних просмотренных сериалов
    final seenItemsController = GetIt.instance<SeenItemsController>();
    /// hook для подписки на изменения
    useValueListenable(seenItemsController.listenable);
    /// список последних просмотренных сериалов
    final seenShows = seenItemsController.find(MovieItemType.tskg, count: 50);

    // /// контроллер избранных сериалов
    // final favoritesController = GetIt.instance<TskgFavoritesController>();
    // /// hook для подписки на изменения
    // useValueListenable(favoritesController.listenable);
    /// список избранных сериалов
    final favoriteShows = seenItemsController.takeFavoritesOf(MovieItemType.tskg);

    return BlocProvider(
      create: (context) => TskgNewsController(),
      child: Builder(
        builder: (context) {
          final state = context.watch<TskgNewsController>().state;

          if (state.isLoading) {
            return const LoadingIndicator();
          }

          final showList = <CategoryListItem<MovieItem>>[];

          if (seenShows.isNotEmpty) {
            showList.add(
              CategoryListItem<MovieItem>(
                title: locale.continueWatching,
                items: seenShows,
              )
            );
          }

          if (favoriteShows.isNotEmpty) {
            showList.add(
              CategoryListItem<MovieItem>(
                title: locale.favorites,
                items: favoriteShows,
              )
            );
          }

          if (state.isSuccess) {
            final news = state.data;

            /// за сколько дней показывать последние добавления
            const lastAddedDays = 2;
            
            /// сериалы сгруппированные по дате добавления
            final showsGroupedByDate = groupBy(
              news,
              (item) => item.updatedAt,
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

              showList.add(
                CategoryListItem<MovieItem>(
                  title: titleText,
                  items: shows,
                )
              );

            }
          }

          if (showList.isNotEmpty) {
            return KrsVerticalListView(
              itemCount: showList.length,
              itemBuilder: (context, focusNode, index) {
                final showItem = showList[index];

                return SizedBox.fromSize(
                  size: const Size.fromHeight(tskgListViewHeight + 16.0),
                  child: KrsHorizontalListView(
                    focusNode: focusNode,
                    onItemFocused: (index) {
                      context.read<TskgShowDetailsController>().getShowById(
                        showItem.items[index].id,
                      );
                    },
                    titleText: showItem.title,
                    itemCount: showItem.items.length,
                    itemBuilder: (context, focusNode, index) {
                      final show = showItem.items.elementAt(index);
                      
                      return KrsListItemCard(
                        focusNode: focusNode,
                        item: show,
                        
                        /// при выб оре элемента
                        onTap: () {
                          /// переходим на страницу деталей о сериале
                          context.goNamed('tskgShowDetails',
                            params: {
                              'id': show.id,
                            },
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
