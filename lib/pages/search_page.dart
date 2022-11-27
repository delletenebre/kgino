import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgino/ui/loading_indicator.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/ockg/ockg_search_controller.dart';
import '../models/ockg/ockg_movie.dart';
import '../resources/krs_locale.dart';
import '../resources/krs_theme.dart';
import '../ui/pages/ockg/ockg_movie_card.dart';

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
          child: BlocBuilder<OckgSearchController, RequestState<List<OckgMovie>>>(
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingIndicator();
              }

              if (state.isSuccess) {
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
                      children: state.data.mapIndexed((index, movie) {
                        return AutoScrollTag(
                          key: ValueKey(index), 
                          controller: _autoScrollController,
                          index: index,
                          child: OckgMovieCard(
                            movie: movie,
                            onMovieFocused: (movie, focusNode) {
                              _autoScrollController.scrollToIndex(index,
                                // preferPosition: AutoScrollPosition.begin,
                                duration: KrsTheme.fastAnimationDuration,
                              );
                            },
                          ),
                        );
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