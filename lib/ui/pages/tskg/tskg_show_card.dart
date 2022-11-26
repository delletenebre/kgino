import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../models/tskg/tskg_show.dart';
import '../../../resources/krs_theme.dart';

class TskgShowCard extends StatefulWidget {
  final FocusNode? focusNode;
  final bool autofocus;
  final TskgShow show;
  // final double height;
  final Size posterSize;
  final void Function(TskgShow show, FocusNode focusNode)? onShowFocused;
  final bool showTitle;

  const TskgShowCard({
    super.key,
    this.focusNode,
    this.autofocus = false,
    required this.show,
    this.posterSize = const Size(126.0, 102.0),
    //this.height = 140.0,
    this.onShowFocused,
    this.showTitle = true,
  });

  @override
  State<TskgShowCard> createState() => _TskgShowCardState();
}

class _TskgShowCardState extends State<TskgShowCard> {
  bool _holded = false;
  Color? _dominantColor;
  late final FocusNode _focusNode;

  /// обработчик выбора элемента
  void onTap() {

    /// переходим на страницу деталей о фильме
    context.goNamed('ockgMovieDetails', params: {
      'id': '${widget.show.showId}',
    });
    
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
        widget.onShowFocused?.call(widget.show, _focusNode);
      }
    });
    
    /// получаем цветовую палитру фильма
    // widget.show.getPaletteGenerator(widget.show).then((palette) {
    //   if (palette.lightVibrantColor != null) {
    //     if (mounted) {
    //       setState(() {
    //         _dominantColor = palette.lightVibrantColor!.color;
    //       });
    //     }
    //   }
    // });
    
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
            width: widget.posterSize.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                /// постер фильма
                SizedBox.fromSize(
                  size: widget.posterSize,
                  child: Center(
                    child: AnimatedScale(
                      duration: KrsTheme.fastAnimationDuration * 2,
                      scale: (_focusNode.hasFocus && !_holded) ? 1.1 : 1.0,
                      child: AnimatedContainer(
                        duration: KrsTheme.fastAnimationDuration * 2,
                        width: widget.posterSize.width,
                        height: widget.posterSize.height,
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
                          child: Image.network(widget.show.posterUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// название фильма
                if (widget.showTitle) Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: AnimatedDefaultTextStyle(
                    duration: KrsTheme.animationDuration,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: (_focusNode.hasFocus)
                        ? theme.textTheme.bodyMedium?.color
                        : theme.textTheme.bodyMedium?.color?.withOpacity(0.62)
                    ),
                    child: Text(widget.show.title,
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
