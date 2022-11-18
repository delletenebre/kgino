import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/ockg/ockg_movie.dart';
import '../../../resources/krs_theme.dart';

class OckgCategoryMovieCard extends StatefulWidget {
  final FocusNode focusNode;
  final OckgMovie movie;
  final double height;

  const OckgCategoryMovieCard({
    super.key,
    required this.focusNode,
    required this.movie,
    this.height = 140.0,
  });

  @override
  State<OckgCategoryMovieCard> createState() => _OckgCategoryMovieCardState();
}

class _OckgCategoryMovieCardState extends State<OckgCategoryMovieCard> {
  bool _holded = false;
  Color? _dominantColor;
  late final Size _posterSize;

  /// обработчик выбора элемента
  VoidCallback onTap = () {
    //print('TApppperd ');
  };

  /// кнопки, которые могут отвечать за выбор элемента
  final _selectKeysMap = [
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.numpadEnter,
    LogicalKeyboardKey.select,
  ];

  void _updateHoldedState(bool state) {
    if (_holded != state) {
      setState(() {
        _holded = state;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    /// вычисляем размер постера
    _posterSize = Size(widget.height * 0.7, widget.height);
    
    /// получаем цветовую палитру фильма
    widget.movie.getPaletteGenerator(widget.movie.coverUrl).then((palette) {
      if (palette.lightVibrantColor != null) {
        setState(() {
          _dominantColor = palette.lightVibrantColor!.color;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// вычисляем размер постера, на который наведён фокус
    final zoomedPosterSize = _posterSize * 1.1;

    /// получаем основной цвет постера
    _dominantColor ??= theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      // onTapDown: (details) {
      //   _updateHoldedState(true);
      // },
      // onTapUp: (details) {
      //   _updateHoldedState(false);
      // },
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (hasFocus) {
          /// при получении фокуса на фильме
          setState(() {
            
          });
        },
        
        onKey: (node, event) {
          if (_selectKeysMap.contains(event.logicalKey)) {
            /// ^ если была нажата клавиша выбора элемента
            
            _updateHoldedState(event is RawKeyDownEvent);
            if (event is RawKeyUpEvent) {
              onTap();
            }
          } else {
            _updateHoldedState(false);
          }

          return KeyEventResult.ignored;
        },
        child: SizedBox(
          width: zoomedPosterSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              /// постер фильма
              SizedBox.fromSize(
                size: zoomedPosterSize,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: (widget.focusNode.hasFocus && !_holded)
                        ? zoomedPosterSize.width : _posterSize.width,
                    height: (widget.focusNode.hasFocus && !_holded)
                        ? zoomedPosterSize.height : _posterSize.height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        if (widget.focusNode.hasFocus) BoxShadow(
                          color: _dominantColor!.withOpacity(0.62),
                          blurRadius: 48.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                      border: widget.focusNode.hasFocus
                        ? Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.72),
                            width: 3.0,
                          )
                        : null
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9.0),
                      child: Image.network(widget.movie.coverUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4.0),
              
              /// название фильма
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _posterSize.width * 0.05,
                ),
                child: AnimatedDefaultTextStyle(
                  duration: KrsTheme.animationDuration,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: (widget.focusNode.hasFocus)
                      ? theme.textTheme.bodyMedium?.color
                      : theme.textTheme.bodyMedium?.color?.withOpacity(0.62)
                  ),
                  child: Text(widget.movie.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              /// описание фильма
              // Text('description',
              //   style: TextStyle(
              //     fontSize: 12.0,
              //     color: theme.textTheme.caption?.color?.withOpacity(0.36),
              //   ),
              //   maxLines: 2,
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
