import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgino/ui/forms/krs_text_field.dart';
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
  final _focusNode = FocusNode();
  final _firstFocusNode = FocusNode();

  final _autoScrollController = AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(32.0, 32.0, 32.0, 32.0),
    axis: Axis.vertical,
  );

  @override
  void initState() {
    // _focusNode.onKey = (node, event) {
    //   if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
    //     node.previousFocus();
    //   }

    //   if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
    //     node.nextFocus();
    //   }

    //   return KeyEventResult.ignored;
    // };

  _focusNode.addListener(() {
    print(_focusNode.hasFocus);
  });

    super.initState();
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = KrsLocale.of(context);

    return BlocProvider(
      create: (context) => OckgSearchController(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 32.0,
                ),
                child: KrsTextField(
                  focusNode: _focusNode,
                  
                  name: 'searchQuery',
                  
                  //labelText: locale.search,
                  hintText: 'Введите название фильма или сериала',
                  selectTextOnFocus: false,
                  textInputAction: TextInputAction.search,

                  onTextChange: (searchQuery) {
                    final runes = searchQuery.runes.map((r) {
                      return '%u${r.toRadixString(16).padLeft(4, '0')}';
                    }).toList();
                    for (final item in runes) {
                      print(item);
                    }
                    if (searchQuery.length > 2) {
                      context.read<OckgSearchController>().searchMovies(searchQuery);
                    }
                  },

                  // onSubmitted: (searchQuery) {
                  //   if (searchQuery.length > 2) {
                  //     context.read<OckgSearchController>().searchMovies(searchQuery);
                  //   }
                  //   _firstFocusNode.requestFocus();
                  // },
                ),
              ),

              Focus(
                focusNode: _firstFocusNode,
                child: const SizedBox(),
              ),

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
        },
      ),
    );
  }

}