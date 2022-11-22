import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../models/ockg/ockg_movie.dart';
import '../../../resources/krs_theme.dart';

class OckgMovieCard extends StatefulWidget {
  final FocusNode? focusNode;
  final bool autofocus;
  final OckgMovie movie;
  // final double height;
  final Size posterSize;
  final void Function(OckgMovie movie, FocusNode focusNode)? onMovieFocused;

  const OckgMovieCard({
    super.key,
    this.focusNode,
    this.autofocus = false,
    required this.movie,
    this.posterSize = const Size(100.0, 140.0),
    //this.height = 140.0,
    this.onMovieFocused,
  });

  @override
  State<OckgMovieCard> createState() => _OckgMovieCardState();
}

class _OckgMovieCardState extends State<OckgMovieCard> {
  bool _holded = false;
  Color? _dominantColor;
  late final FocusNode _focusNode;

  /// обработчик выбора элемента
  void onTap() {
    context.go('/ockg/movie/${widget.movie.movieId}');
  }

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

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onMovieFocused?.call(widget.movie, _focusNode);
      }
    });
    
    /// получаем цветовую палитру фильма
    widget.movie.getPaletteGenerator(widget.movie.coverUrl).then((palette) {
      if (palette.lightVibrantColor != null) {
        if (mounted) {
          setState(() {
            _dominantColor = palette.lightVibrantColor!.color;
          });
        }
      }
    });
    
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// вычисляем размер постера, на который наведён фокус
    final zoomedPosterSize = widget.posterSize + const Offset(10.0, 12.0);
  
    /// получаем основной цвет постера
    _dominantColor ??= theme.colorScheme.primary;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.enter, includeRepeats: false): onTap,
          const SingleActivator(LogicalKeyboardKey.select, includeRepeats: false): onTap,
        },
        child: Focus(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus) {
            /// при получении фокуса на фильме
            setState(() {
              
            });
          },

          onKeyEvent: (node, event) {
            if (_selectKeysMap.contains(event.logicalKey)) {
              /// ^ если была нажата клавиша выбора элемента
              _updateHoldedState(event is KeyDownEvent);
              // if (event is KeyUpEvent) {
              //   onTap();
              // }
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
                      duration: const Duration(milliseconds: 100),
                      width: (_focusNode.hasFocus && !_holded)
                          ? zoomedPosterSize.width : widget.posterSize.width,
                      height: (_focusNode.hasFocus && !_holded)
                          ? zoomedPosterSize.height : widget.posterSize.height,
                      decoration: BoxDecoration(
                        boxShadow: [
                          if (_focusNode.hasFocus) BoxShadow(
                            color: _dominantColor!.withOpacity(0.62),
                            blurRadius: 20.0,
                            spreadRadius: 4.0
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                        border: _focusNode.hasFocus
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
                    horizontal: (zoomedPosterSize.width - widget.posterSize.width) / 2,
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: KrsTheme.animationDuration,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: (_focusNode.hasFocus)
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
      ),
    );
  }
}
