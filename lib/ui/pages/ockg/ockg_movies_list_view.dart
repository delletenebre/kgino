import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kgino/models/ockg/ockg_movie.dart';

import '../../../api/ockg_api_provider.dart';
import '../../loading_indicator.dart';
import 'ockg_category_movie_card.dart';

class OckgMoviesListView extends StatefulWidget {
  final List<OckgMovie> movies;
  final void Function(OckgMovie movie) onMovieFocused;

  const OckgMoviesListView({
    super.key,
    required this.movies,
    required this.onMovieFocused,
  });

  @override
  State<OckgMoviesListView> createState() => _OckgMoviesListViewState();
}

class _OckgMoviesListViewState extends State<OckgMoviesListView> {
  final _api = GetIt.instance<OckgApiProvider>();
  
  final _pagingController = PagingController<int, OckgMovie>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
  try {
    final newPage = await _api.getCatalog(
      genreId: 4,
      offset: pageKey * 20,
    );

    final previouslyFetchedItemsCount =
        _pagingController.itemList?.length ?? 0;

    final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
    final newItems = newPage.movies;

    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  } catch (error) {
    
    _pagingController.error = error;
  }
}

  @override
  Widget build(BuildContext context) {


    return SizedBox.fromSize(
        size: const Size.fromHeight(140.0),
        child: PagedListView.separated(
          scrollDirection: Axis.horizontal,
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(
            width: 16,
          ),
          builderDelegate: PagedChildBuilderDelegate<OckgMovie>(
            itemBuilder: (context, movie, index) {
              return OckgCategoryMovieCard(
                movie: movie,
                height: 140.0,
                onMovieFocused: (movie) {
                  print('onMovieFocused: $movie');
                  widget.onMovieFocused.call(movie);
                }
              );
            },
            // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            //   error: _pagingController.error,
            //   onTryAgain: () => _pagingController.refresh(),
            // ),
            // noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
          ),
        ),
    );

    if (widget.movies.isEmpty) {
      return const LoadingIndicator();
    }
    
    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        // if (hasFocus) {
        //   _ensureVisible(_moviesFocusNodes.first);
        // }
      },

      // onKey: (node, event) {
      //   if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      //     /// ^ если нажали вверх
          
      //     if (!_titleFocusNode.hasFocus) {
      //       /// ^ если название категории не в фокусе
            
      //       /// ставим фокус на название категории
      //       _titleFocusNode.requestFocus();
      //       _ensureVisible(_moviesFocusNodes.first);
            
      //       /// останавливаем обработку нажатия
      //       return KeyEventResult.handled;

      //     }

      //   }

      //   if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)
      //       || event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      //     /// ^ если нажали вниз или вправо
          
      //     if (_titleFocusNode.hasFocus) {
      //       /// ^ если название категории уже в фокусе

      //       /// ставим фокус на первый элемент в категории
      //       _moviesFocusNodes.first.requestFocus();
      //       _ensureVisible(_moviesFocusNodes.first);

      //       /// останавливаем обработку нажатия
      //       return KeyEventResult.handled;
      //     }

      //   }

      //   return KeyEventResult.ignored;
      // },
      child: SizedBox.fromSize(
        size: const Size.fromHeight(140.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            final movie = widget.movies[index];

            return OckgCategoryMovieCard(
              movie: movie,
              height: 140.0,
              onMovieFocused: (movie) {
                print('onMovieFocused: $movie');
                widget.onMovieFocused.call(movie);
              }
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 24.0);
          },
          
        ),
      ),
    );
  }

  // Future<void> _ensureVisible(FocusNode focusNode) async {
  //   // Wait for the keyboard to come into view
  //   Future.delayed(KrsTheme.fastAnimationDuration, () {
      
  //     if (!mounted) { // || !focusNode.hasFocus) {
  //       /// ^ если виджет не существует или нет фокуса на элементе
        
  //       /// останавливаем выполнение
  //       return;
  //     }

  //     /// находим объект, который находится в фокусе
  //     final object = context.findRenderObject()!;
  //     final viewport = RenderAbstractViewport.of(object);

  //     if (viewport == null) {
  //       /// ^ если прокрутки нет
        
  //       /// останавливаем выполнение
  //       return;
  //     }

  //     // Get the Scrollable state (in order to retrieve its offset)
  //     final scrollableState = Scrollable.of(context)!;

  //     /// получаем смещение
  //     final position = scrollableState.position;
  //     late double alignment;

  //     if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
  //       // Move down to the top of the viewport
  //       alignment = 0.0;
  //     } else if (position.pixels <
  //         viewport.getOffsetToReveal(object, 1.0).offset) {
  //       // Move up to the bottom of the viewport
  //       alignment = 1.0;
  //     } else {
  //       // No scrolling is necessary to reveal the child
  //       return;
  //     }

  //     position.ensureVisible(
  //       object,
  //       alignment: alignment,
  //       duration: KrsTheme.animationDuration,
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }
}