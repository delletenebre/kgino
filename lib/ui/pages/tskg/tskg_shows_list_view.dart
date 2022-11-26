import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../models/tskg/tskg_show.dart';
import 'tskg_show_card.dart';

class TskgShowsListView extends StatefulWidget {
  final bool autofocus;
  final List<TskgShow> shows;
  final List<FocusNode>? focusNodes;
  final void Function(TskgShow show) onShowFocused;
  final void Function() onScrollEnd;
  final EdgeInsetsGeometry? padding;

  const TskgShowsListView({
    super.key,
    this.autofocus = false,
    this.focusNodes,
    required this.shows,
    required this.onShowFocused,
    required this.onScrollEnd,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
  });

  @override
  State<TskgShowsListView> createState() => _TskgShowsListViewState();
}

class _TskgShowsListViewState extends State<TskgShowsListView> {
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
    final theme = Theme.of(context);

    return RawScrollbar(
        thumbColor: theme.colorScheme.primary.withOpacity(0.5),
        controller: _autoScrollController,
        thickness: 1.0,
        radius: const Radius.circular(2.0),
        thumbVisibility: true,
        child: ListView.separated(
          clipBehavior: Clip.none,
          controller: _autoScrollController,
          padding: widget.padding,
          scrollDirection: Axis.horizontal,
          itemCount: widget.shows.length,
          itemBuilder: (context, index) {
            final show = widget.shows[index];

            return AutoScrollTag(
              key: ValueKey(index), 
              controller: _autoScrollController,
              index: index,
              child: TskgShowCard(
                /// поставить ли фокус на первый фильм в списке
                autofocus: (index == 0 && widget.autofocus),
                focusNode: widget.focusNodes?[index],
                /// данные о фильме
                show: show,

                onShowFocused: (movie, focusNode) {
                  /// ^ при смене фокуса на этот фильм
                  
                  if (!_autoScrollController.isAutoScrolling) {
                    /// прокручиваем контент к текущему элементу
                    _autoScrollController.scrollToIndex(index,
                      preferPosition: AutoScrollPosition.begin,
                      duration: const Duration(milliseconds: 50),
                    ).then((_) {
                      /// ^ после окончания прокрутки
                      
                      if (mounted && focusNode.hasFocus) {
                        /// ^ если виджет ещё жив
                        
                        /// вызываем пользовательский обработчик
                        widget.onShowFocused.call(movie);
                      }
                    });
                  }
                  
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
