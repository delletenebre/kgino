import 'package:flutter/material.dart';
import 'package:kgino/models/ockg/ockg_movie.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'ockg_category_movie_card.dart';

class OckgMoviesListView extends StatefulWidget {
  // final PagingController<int, OckgMovie> pagingController;
  final List<OckgMovie> movies;
  final void Function(OckgMovie movie) onMovieFocused;

  const OckgMoviesListView({
    super.key,
    // required this.pagingController,
    required this.movies,
    required this.onMovieFocused,
  });

  @override
  State<OckgMoviesListView> createState() => _OckgMoviesListViewState();
}

class _OckgMoviesListViewState extends State<OckgMoviesListView> {
  final _autoScrollController = AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(24.0, 0.0, 24.0, 0.0),
    axis: Axis.horizontal,
  );
  
  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox.fromSize(
      size: const Size.fromHeight(140.0),
      child: ListView.separated(
        clipBehavior: Clip.none,
        controller: _autoScrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          return AutoScrollTag(
            key: ValueKey(index), 
            controller: _autoScrollController,
            index: index,
            child: OckgCategoryMovieCard(
              
              movie: movie,
              onMovieFocused: (movie) {
                // ^ при смене фокуса
                
                /// прокручиваем контент к текущему элементу
                _autoScrollController.scrollToIndex(index,
                  preferPosition: AutoScrollPosition.begin,
                  duration: const Duration(milliseconds: 50),
                ).then((_) {
                  // ^ после окончания прокрутки
                  
                  if (mounted) {
                    // ^ если виджет ещё жив
                    
                    // вызываем пользовательский обработчик
                    widget.onMovieFocused.call(movie);
                  }
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 24.0);
        },
        
      ),
    );

    // return SizedBox.fromSize(
    //     size: const Size.fromHeight(140.0),
    //     child: PagedListView.separated(
    //       scrollDirection: Axis.horizontal,
    //       pagingController: pagingController,
    //       padding: const EdgeInsets.all(16),
    //       separatorBuilder: (context, index) => const SizedBox(
    //         width: 16,
    //       ),
    //       builderDelegate: PagedChildBuilderDelegate<OckgMovie>(
    //         itemBuilder: (context, movie, index) {
    //           return OckgCategoryMovieCard(
    //             movie: movie,
    //             height: 140.0,
    //             onMovieFocused: (movie) {
    //               onMovieFocused.call(movie);
    //             }
    //           );
    //         },
    //         // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
    //         //   error: _pagingController.error,
    //         //   onTryAgain: () => _pagingController.refresh(),
    //         // ),
    //         // noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
    //       ),
    //     ),
    // );
  }
}

  //   if (widget.movies.isEmpty) {
  //     return const LoadingIndicator();
  //   }
    
  //   return Focus(
  //     skipTraversal: true,
  //     onFocusChange: (hasFocus) {
  //       // if (hasFocus) {
  //       //   _ensureVisible(_moviesFocusNodes.first);
  //       // }
  //     },

  //     // onKey: (node, event) {
  //     //   if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
  //     //     /// ^ если нажали вверх
          
  //     //     if (!_titleFocusNode.hasFocus) {
  //     //       /// ^ если название категории не в фокусе
            
  //     //       /// ставим фокус на название категории
  //     //       _titleFocusNode.requestFocus();
  //     //       _ensureVisible(_moviesFocusNodes.first);
            
  //     //       /// останавливаем обработку нажатия
  //     //       return KeyEventResult.handled;

  //     //     }

  //     //   }

  //     //   if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)
  //     //       || event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
  //     //     /// ^ если нажали вниз или вправо
          
  //     //     if (_titleFocusNode.hasFocus) {
  //     //       /// ^ если название категории уже в фокусе

  //     //       /// ставим фокус на первый элемент в категории
  //     //       _moviesFocusNodes.first.requestFocus();
  //     //       _ensureVisible(_moviesFocusNodes.first);

  //     //       /// останавливаем обработку нажатия
  //     //       return KeyEventResult.handled;
  //     //     }

  //     //   }

  //     //   return KeyEventResult.ignored;
  //     // },
  //     child: SizedBox.fromSize(
  //       size: const Size.fromHeight(140.0),
  //       child: ListView.separated(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: widget.movies.length,
  //         itemBuilder: (context, index) {
  //           final movie = widget.movies[index];

  //           return OckgCategoryMovieCard(
  //             movie: movie,
  //             height: 140.0,
  //             onMovieFocused: (movie) {
  //               print('onMovieFocused: $movie');
  //               widget.onMovieFocused.call(movie);
  //             }
  //           );
  //         },
  //         separatorBuilder: (context, index) {
  //           return const SizedBox(width: 24.0);
  //         },
          
  //       ),
  //     ),
  //   );
  // }

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