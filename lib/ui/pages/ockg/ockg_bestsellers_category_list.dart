import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../models/ockg/ockg_bestsellers_category.dart';
import 'ockg_category_movie_card.dart';

class OckgBestsellersCategoryList extends StatefulWidget {
  final OckgBestsellersCategory category;

  const OckgBestsellersCategoryList({
    super.key,
    required this.category,
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
      return FocusNode();
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();

    for (final focusNode in _elementsFocusNodes) {
      focusNode.dispose();
    }

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

            },
            child: Text(widget.category.name),
          ),

          SizedBox.fromSize(
            size: const Size.fromHeight(140.0 + 12.0 + 48.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.category.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.category.movies[index];
                return OckgCategoryMovieCard(
                  focusNode: _elementsFocusNodes[index],
                  movie: movie,
                  height: 140.0,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 24.0);
              },
              
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ensureVisible(FocusNode focusNode) async {
    // Wait for the keyboard to come into view
    Future.delayed(const Duration(milliseconds: 50), () {
      
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
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    });
  }
}