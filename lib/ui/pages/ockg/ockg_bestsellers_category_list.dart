import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kgino/models/ockg/ockg_movie.dart';

import '../../../models/ockg/ockg_bestsellers_category.dart';
import '../../../resources/krs_theme.dart';
import 'ockg_movies_list_view.dart';

class OckgBestsellersCategoryList extends StatefulWidget {
  final OckgBestsellersCategory category;
  final Function(OckgMovie) onMovieFocused;
  final Function()? onTitleFocused;

  const OckgBestsellersCategoryList({
    super.key,
    required this.category,
    required this.onMovieFocused,
    this.onTitleFocused,
  });

  @override
  State<OckgBestsellersCategoryList> createState() => _OckgBestsellersCategoryListState();
}

class _OckgBestsellersCategoryListState extends State<OckgBestsellersCategoryList> {
  final _titleFocusNode = FocusNode();
  late final List<FocusNode> _elementsFocusNodes;

  @override
  void initState() {
    /// инициализируем [FocusNode] для карточек фильмов
    _elementsFocusNodes = List.generate(widget.category.movies.length, (index) {
      final focusNode = FocusNode();

      return focusNode;
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();

    // for (final focusNode in _elementsFocusNodes) {
    //   focusNode.dispose();
    // }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _ensureVisible(_elementsFocusNodes.first);
        }
      },

      onKey: (node, event) {
        if (_titleFocusNode.hasFocus && event is RawKeyUpEvent) {
          widget.onTitleFocused?.call();
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          /// ^ если нажали вверх
          
          if (!_titleFocusNode.hasFocus) {
            /// ^ если название категории не в фокусе
            
            /// ставим фокус на название категории
            _titleFocusNode.requestFocus();
            _ensureVisible(_elementsFocusNodes.first);
            
            /// останавливаем обработку нажатия
            return KeyEventResult.handled;

          }

        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)
            || event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          /// ^ если нажали вниз или вправо
          
          if (_titleFocusNode.hasFocus) {
            /// ^ если название категории уже в фокусе

            /// ставим фокус на первый элемент в категории
            _elementsFocusNodes.first.requestFocus();
            _ensureVisible(_elementsFocusNodes.first);

            /// останавливаем обработку нажатия
            return KeyEventResult.handled;
          }

        }

        return KeyEventResult.ignored;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            focusNode: _titleFocusNode,
            onPressed: () {
              // переходим на страницу с каталогом фильмов по выбранному жанру
              context.push('/ockg/genre/${widget.category.getGenreId()}',
                extra: widget.category.name,
              );
            },
            child: Text(widget.category.name),
          ),

          SizedBox.fromSize(
            size: const Size.fromHeight(140.0 + 12.0 + 4.0 + 28.0 + 20.0),
            child: OckgMoviesListView(
              padding: null,
              focusNodes: _elementsFocusNodes,
              movies: widget.category.movies,
              onMovieFocused: (movie) {
                widget.onMovieFocused.call(movie);
              },
              onScrollEnd: () {

              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ensureVisible(FocusNode focusNode) async {
    // Wait for the keyboard to come into view
    Future.delayed(KrsTheme.fastAnimationDuration, () {
      
      if (!mounted) { // || !focusNode.hasFocus) {
        /// ^ если виджет не существует или нет фокуса на элементе
        
        /// останавливаем выполнение
        return;
      }

      /// находим объект, который находится в фокусе
      final object = context.findRenderObject()!;
      final viewport = RenderAbstractViewport.of(object);

      if (viewport == null) {
        /// ^ если прокрутки нет
        
        /// останавливаем выполнение
        return;
      }

      // Get the Scrollable state (in order to retrieve its offset)
      final scrollableState = Scrollable.of(context)!;

      /// получаем смещение
      final position = scrollableState.position;
      late double alignment;

      if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
        // Move down to the top of the viewport
        alignment = 0.0;
      } else if (position.pixels <
          viewport.getOffsetToReveal(object, 1.0).offset) {
        // Move up to the bottom of the viewport
        alignment = 1.0;
      } else {
        // No scrolling is necessary to reveal the child
        return;
      }

      position.ensureVisible(
        object,
        alignment: alignment,
        duration: KrsTheme.animationDuration,
        curve: Curves.easeIn,
      );
    });
  }
}