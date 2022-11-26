import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../models/ockg/ockg_movie.dart';
import 'ockg_movie_card.dart';

class OckgMoviesListView extends StatefulWidget {
  final bool autofocus;
  final List<OckgMovie> movies;
  final List<FocusNode>? focusNodes;
  final void Function(OckgMovie movie) onMovieFocused;
  final void Function() onScrollEnd;
  final EdgeInsetsGeometry? padding;

  const OckgMoviesListView({
    super.key,
    this.autofocus = false,
    this.focusNodes,
    required this.movies,
    required this.onMovieFocused,
    required this.onScrollEnd,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
  });

  @override
  State<OckgMoviesListView> createState() => _OckgMoviesListViewState();
}

class _OckgMoviesListViewState extends State<OckgMoviesListView> {
  final _autoScrollController = AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(32.0, 0.0, 32.0, 0.0),
    axis: Axis.horizontal,
  );

  bool _needToLoadMore = false;

  @override
  void initState() {
    _autoScrollController.addListener(() {
      if (!_autoScrollController.isAutoScrolling) {
        double maxScroll = _autoScrollController.position.maxScrollExtent;
        double currentScroll = _autoScrollController.position.pixels;
        double delta = 200.0;

        if (maxScroll - currentScroll <= delta) {
          if (!_needToLoadMore) {
            _needToLoadMore = true;
            widget.onScrollEnd();
          }
        } else {
          _needToLoadMore = false;
        }
      }
      
    });
    super.initState();
  }
  
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
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          return AutoScrollTag(
            key: ValueKey(index), 
            controller: _autoScrollController,
            index: index,
            child: OckgMovieCard(
              /// поставить ли фокус на первый фильм в списке
              autofocus: (index == 0 && widget.autofocus),
              focusNode: widget.focusNodes?[index],
              /// данные о фильме
              movie: movie,

              onMovieFocused: (movie, focusNode) {
                /// ^ при смене фокуса на этот фильм
                
                /// прокручиваем контент к текущему элементу
                _autoScrollController.scrollToIndex(index,
                  preferPosition: AutoScrollPosition.begin,
                  duration: const Duration(milliseconds: 50),
                ).then((_) {
                  /// ^ после окончания прокрутки
                  
                  if (mounted) {
                    /// ^ если виджет ещё жив
                    
                    /// вызываем пользовательский обработчик
                    widget.onMovieFocused.call(movie);
                  }
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 32.0);
        },
        
      ),
    );
  }
}
