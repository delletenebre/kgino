import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kgino/utils.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../constants.dart';
import '../../../controllers/seen_items_controller.dart';
import '../../../controllers/tskg/tskg_favorites_controller.dart';
import '../../../controllers/tskg/tskg_news_controller.dart';
import '../../../controllers/tskg/tskg_show_details_controller.dart';
import '../../../models/seen_item.dart';
import '../../../models/tskg/tskg_show.dart';
import '../../../resources/krs_locale.dart';
import '../../lists/krs_list_view.dart';
import '../../loading_indicator.dart';
import 'tskg_show_card.dart';

class TskgHomePageListView extends StatefulWidget {
  const TskgHomePageListView({
    super.key,
  });

  @override
  State<TskgHomePageListView> createState() => _TskgHomePageListViewState();
}

class _TskgHomePageListViewState extends State<TskgHomePageListView> {
  final _autoScrollController = AutoScrollController(
    axis: Axis.vertical,
    viewportBoundaryGetter: () => const Rect.fromLTRB(0.0, 0.0, 0.0, 32.0),
  );

  @override
  void dispose() {
    _autoScrollController.dispose();

    super.dispose();
  }

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
            final favoriteShows = tskgFavoritesController.sorted;

            return BlocProvider<TskgNewsController>(
              create: (context) => TskgNewsController(),
              child: BlocBuilder<TskgNewsController, RequestState<List<TskgShow>>>(
                builder: (context, state) {

                  if (state.isSuccess) {
                    final news = state.data;
                    
                    /// сериалы сгруппированные по дате добавления
                    final showsGroupedByDate = groupBy(
                      news,
                      (item) => item.date,
                    );

                    /// общее количество разделов
                    int itemsCount = 1;

                    /// добавляем последние добавления за два дня
                    const lastAddedDays = 2;
                    itemsCount += lastAddedDays;

                    /// если есть просмотренные сериалы
                    if (seenShows.isNotEmpty) {
                      itemsCount++;
                    }

                    /// если есть избранные
                    if (favoriteShows.isNotEmpty) {
                      itemsCount++;
                    }

                    return ListView.separated(
                      controller: _autoScrollController,
                      itemCount: itemsCount,
                      
                      /// разделитель
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 24.0);
                      },

                      itemBuilder: (context, index) {
                        /// последний элемент в списке - отступ для красоты
                        if (index == itemsCount - 1) {
                          return const SizedBox(height: 40.0);
                        }

                        /// первый элемент и если есть просмотренные сериалы
                        if (seenShows.isNotEmpty && index == 0) {
                          return Focus(
                            skipTraversal: true,
                            onFocusChange: (hasFocus) {
                              if (hasFocus) {
                                _autoScrollController.scrollToIndex(index,
                                  preferPosition: AutoScrollPosition.begin,
                                );
                              }
                            },
                            child: AutoScrollTag(
                              key: ValueKey(index),
                              controller: _autoScrollController,
                              index: index,
                              child: SizedBox.fromSize(
                                size: const Size.fromHeight(tskgListViewHeight + 16.0),
                                child: KrsListView(
                                  /// TODO check remove all favorites and add two
                                  /// RangeError (index): Invalid value: Only valid value is 0: 1
                                  /// in KrsListView -> focusNode: _itemFocusNodes[index],
                                  key: ValueKey('seenShows ${seenShows.length}'),
                                  onItemFocused: (index) {
                                    context.read<TskgShowDetailsController>().getShowById(
                                      seenShows.elementAt(index).showId,
                                    );
                                  },
                                  titleText: 'Продолжить просмотр',
                                  itemCount: seenShows.length,
                                  itemBuilder: (context, index) {
                                    final show = seenShows.elementAt(index);

                                    return TskgShowCard(
                                      show: show,
                                      
                                      /// при выборе элемента
                                      onTap: () {
                                        /// переходим на страницу деталей о фильме
                                        context.goNamed('tskgShowDetails', params: {
                                          'id': show.showId,
                                        });

                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }

                        if (favoriteShows.isNotEmpty && index >= itemsCount - 2) {
                          return Focus(
                            skipTraversal: true,
                            onFocusChange: (hasFocus) {
                              if (hasFocus) {
                                _autoScrollController.scrollToIndex(index,
                                  preferPosition: AutoScrollPosition.begin,
                                );
                              }
                            },
                            child: AutoScrollTag(
                              key: ValueKey(index),
                              controller: _autoScrollController,
                              index: index,
                              child: SizedBox.fromSize(
                                size: const Size.fromHeight(tskgListViewHeight + 16.0),
                                child: KrsListView(
                                  /// TODO check remove all favorites and add two
                                  /// RangeError (index): Invalid value: Only valid value is 0: 1
                                  /// in KrsListView -> focusNode: _itemFocusNodes[index],
                                  key: ValueKey('favoriteShows ${favoriteShows.length}'),
                                  onItemFocused: (index) {
                                    context.read<TskgShowDetailsController>().getShowById(
                                      favoriteShows.elementAt(index).showId,
                                    );
                                  },
                                  titleText: locale.favorites,
                                  itemCount: favoriteShows.length,
                                  itemBuilder: (context, index) {
                                    final favoriteShow = favoriteShows.elementAt(index);

                                    return TskgShowCard(
                                      show: TskgShow(
                                        showId: favoriteShow.showId,
                                        name: favoriteShow.name,
                                      ),
                                      
                                      /// при выборе элемента
                                      onTap: () {
                                        /// переходим на страницу деталей о фильме
                                        context.goNamed('tskgShowDetails', params: {
                                          'id': favoriteShow.showId,
                                        });

                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }

                        // TODO fix index if seenShows.isNotEmpty
                        
                        /// дата добавления сериала
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

                        return Focus(
                          skipTraversal: true,
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              _autoScrollController.scrollToIndex(index,
                                preferPosition: AutoScrollPosition.begin,
                              );
                            }
                          },
                          child: AutoScrollTag(
                            key: ValueKey(index), 
                            controller: _autoScrollController,
                            index: index,
                            child: SizedBox.fromSize(
                              size: const Size.fromHeight(tskgListViewHeight + 16.0),
                              child: KrsListView(
                                onItemFocused: (index) {
                                  context.read<TskgShowDetailsController>().getShowById(
                                    shows[index].showId,
                                  );
                                },
                                titleText: titleText,
                                itemCount: shows.length,
                                itemBuilder: (context, index) {
                                  final show = shows[index];

                                  return TskgShowCard(
                                    show: show,
                                    
                                    /// при выборе элемента
                                    onTap: () {
                                      /// переходим на страницу деталей о фильме
                                      context.goNamed('tskgShowDetails', params: {
                                        'id': show.showId,
                                      });

                                    },
                                  );
                                },
                              ),
                            ),
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