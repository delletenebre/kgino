import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kgino/ui/loading_indicator.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/ockg/ockg_search_controller.dart';
import '../controllers/tskg/tskg_search_controller.dart';
import '../models/ockg/ockg_movie.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/pages/ockg/ockg_movie_card.dart';
import '../ui/pages/tskg/tskg_show_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _autoScrollController = AutoScrollController(
    axis: Axis.vertical,
    viewportBoundaryGetter: () => const Rect.fromLTRB(32.0, 32.0, 32.0, 32.0),
  );

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    return Column(
      children: [
        Expanded(
          child: Builder(
            builder: (context) {
              final ockgSearch = context.watch<OckgSearchController>().state;
              final tskgSearch = context.watch<TskgSearchController>().state;

              final items = [];
              if (ockgSearch.isSuccess) {
                items.addAll(ockgSearch.data);
              }
              if (tskgSearch.isSuccess) {
                items.addAll(tskgSearch.data);
              }

              // if (ockgSearch.isLoading) {
              //   return const LoadingIndicator();
              // }

              if (items.isNotEmpty) {
                return SingleChildScrollView(
                  controller: _autoScrollController,
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Wrap(
                      clipBehavior: Clip.none,
                      alignment: WrapAlignment.center,
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: items.mapIndexed((index, item) {
                        print('123: $item');
                        if (item is OckgMovie) {
                          return AutoScrollTag(
                            key: ValueKey(index), 
                            controller: _autoScrollController,
                            index: index,
                            child: OckgMovieCard(
                              movie: item,
                              onMovieFocused: (movie, focusNode) {
                                _autoScrollController.scrollToIndex(index,
                                  // preferPosition: AutoScrollPosition.begin,
                                  duration: KrsTheme.fastAnimationDuration,
                                );
                              },
                            ),
                          );
                        } else {
                          return TskgShowCard(
                            show: item,
                            onTap: () {
                              /// переходим на страницу деталей о фильме
                              context.goNamed('tskgShowDetails', params: {
                                'id': item.showId,
                              });
                            },
                          );
                        }
                        
                      }).toList(),
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),

      ],
    );
  }

}