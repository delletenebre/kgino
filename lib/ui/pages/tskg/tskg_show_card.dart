import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../models/tskg/tskg_show.dart';
import '../../../resources/krs_theme.dart';

class TskgShowCard extends StatefulWidget {
  final FocusNode? focusNode;
  final bool autofocus;
  final TskgShow show;
  final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final bool showTitle;
  final void Function() onTap;

  const TskgShowCard({
    super.key,
    this.focusNode,
    this.autofocus = false,
    required this.show,
    this.posterSize = const Size(126.0, 102.0),
    this.onFocused,
    this.showTitle = true,
    required this.onTap,
  });

  @override
  State<TskgShowCard> createState() => _TskgShowCardState();
}

class _TskgShowCardState extends State<TskgShowCard> {
  bool _holded = false;
  Color? _glowColor;
  Color? _dominantColor;
  late final FocusNode _focusNode;

  /// обработчик выбора элемента
  void onTap() {

    /// вызывам пользовательский обработчик выбора элемента
    widget.onTap.call();
    
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
        widget.onFocused?.call(_focusNode);
      }
    });
    
    /// получаем цветовую палитру фильма
    widget.show.getPaletteGenerator().then((palette) {
      if (palette.lightVibrantColor != null) {
        if (mounted) {
          setState(() {
            _glowColor = palette.lightVibrantColor!.color;
            // _dominantColor = palette.dominantColor!.color;
          });
        }
      }
    });
    
  }

  @override
  void dispose() {
    //_focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
  
    /// получаем цвет свечения
    _glowColor ??= theme.colorScheme.primary;

    _dominantColor ??= theme.colorScheme.surface;

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
            /// при получении фокуса на сериале
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
                
                /// постер сериала
                SizedBox.fromSize(
                  size: widget.posterSize,
                  child: Center(
                    child: AnimatedScale(
                      duration: KrsTheme.fastAnimationDuration * 2,
                      scale: (_focusNode.hasFocus && !_holded) ? 1.15 : 1.0,
                      child: AnimatedContainer(
                        duration: KrsTheme.fastAnimationDuration * 2,
                        width: widget.posterSize.width,
                        height: widget.posterSize.height,
                        decoration: BoxDecoration(
                          boxShadow: [
                            if (_focusNode.hasFocus) BoxShadow(
                              color: _glowColor!.withOpacity(0.62),
                              blurRadius: 20.0,
                              spreadRadius: 4.0
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                          border: _focusNode.hasFocus
                            ? Border.all(
                                color: theme.colorScheme.onPrimaryContainer,
                                width: 3.0,
                              )
                            : null
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                            color: theme.scaffoldBackgroundColor,
                          ),
                          child: Image.network(widget.show.posterUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// название сериала
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
                    child: Text(widget.show.name,
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
