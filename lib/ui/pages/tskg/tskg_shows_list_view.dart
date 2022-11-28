import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../constants.dart';
import '../../../models/tskg/tskg_show.dart';
import '../../lists/krs_list_view.dart';
import 'tskg_show_card.dart';

class TskgShowsListView extends StatefulWidget {
  final bool autofocus;
  final List<TskgShow> shows;
  final List<FocusNode>? focusNodes;
  final void Function(TskgShow show) onShowFocused;
  final void Function() onScrollEnd;
  final EdgeInsetsGeometry? padding;
  final String titleText;

  const TskgShowsListView({
    super.key,
    this.autofocus = false,
    this.focusNodes,
    required this.shows,
    required this.onShowFocused,
    required this.onScrollEnd,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
    this.titleText = '',
  });

  @override
  State<TskgShowsListView> createState() => _TskgShowsListViewState();
}

class _TskgShowsListViewState extends State<TskgShowsListView> {
  final _autoScrollController = AutoScrollController(
    axis: Axis.horizontal,
    viewportBoundaryGetter: () => const Rect.fromLTRB(32.0, 0.0, 32.0, 0.0),
  );

  bool _needToLoadMore = false;
  int _lastFocusedIndex = 0;
  bool _scrollToLastIndex = false;

  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _focusNodes = widget.focusNodes ?? List.generate(widget.shows.length, (index) {
      return FocusNode();
    });

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
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        if (hasFocus && !_scrollToLastIndex) {
          _scrollToLastIndex = true;
        } else {
          _scrollToLastIndex = false;
        }
      },
      child: SizedBox.fromSize(
        size: const Size.fromHeight(tskgListViewHeight),
        child: KrsListView(
          titleText: widget.titleText,
          itemCount: widget.shows.length,
          itemBuilder: (context, index) {
            final show = widget.shows[index];

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
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     if (widget.titleText.isNotEmpty) Padding(
        //       padding: const EdgeInsets.only(
        //         left: 32.0,
        //         right: 32.0,
        //         bottom: 24.0,
        //       ),
        //       child: Text(widget.titleText,
        //         style: const TextStyle(
        //           fontSize: 16.0,
        //         ),
        //       ),
        //     ),
            
        //     Expanded(
        //       // child: RawScrollbar(
        //       //   thumbColor: theme.colorScheme.primary.withOpacity(0.5),
        //       //   controller: _autoScrollController,
        //       //   thickness: 2.0,
        //       //   radius: const Radius.circular(2.0),
        //       //   thumbVisibility: true,
        //         child: ListView.separated(
        //           clipBehavior: Clip.none,
        //           controller: _autoScrollController,
        //           padding: widget.padding,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: widget.shows.length,
                  
        //           /// разделитель
        //           separatorBuilder: (context, index) {
        //             return const SizedBox(width: 32.0);
        //           },

        //           /// основной контент
        //           itemBuilder: (context, index) {
        //             final show = widget.shows[index];

        //             return AutoScrollTag(
        //               key: ValueKey(index), 
        //               controller: _autoScrollController,
        //               index: index,
        //               child: TskgShowCard(
        //                 /// поставить ли фокус на первый фильм в списке
        //                 autofocus: (index == 0 && widget.autofocus),
        //                 focusNode: _focusNodes[index],
                        
        //                 /// данные о сериале
        //                 show: show,

        //                 /// при выборе элемента
        //                 onTap: () {
        //                   /// переходим на страницу деталей о фильме
        //                   context.goNamed('tskgShowDetails', params: {
        //                     'id': show.showId,
        //                   });

        //                 },

        //                 /// при получении фокуса на этот сериал
        //                 onFocused: (focusNode) {
        //                   final currentIndex = _scrollToLastIndex
        //                     ? _lastFocusedIndex : index;
        //                   final show = widget.shows[currentIndex];
                          
        //                   /// обновляем индекс последнего элемента, на котором был
        //                   /// фокус
        //                   _focusNodes[currentIndex].requestFocus();
        //                   /// небольшая задержка, когда происходит быстрая прокрутка
        //                   Future.delayed(const Duration(milliseconds: 100), () {
        //                     if (mounted && _focusNodes[currentIndex].hasFocus) {
        //                       /// прокручиваем контент к текущему элементу
        //                       _autoScrollController.scrollToIndex(currentIndex,
        //                         preferPosition: AutoScrollPosition.begin,
        //                         duration: const Duration(milliseconds: 50),
        //                       );

        //                       /// ^ если виджет ещё жив
        //                       /// вызываем пользовательский обработчик
        //                       widget.onShowFocused.call(show);

        //                       _lastFocusedIndex = currentIndex;
        //                       _scrollToLastIndex = false;
        //                     }
        //                   });
                          
        //                 },
        //               ),
        //             );
        //           },
        //         // ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
