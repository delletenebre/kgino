import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/krs_theme.dart';

class EpisodeCard extends StatefulWidget {
  final String titleText;
  final String description;
  final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final bool showTitle;
  final Function()? onPressed;
  final KeyEventResult Function()? onArrowLeft;
  final KeyEventResult Function()? onArrowRight;
  final double seenValue;

  const EpisodeCard({
    super.key,
    required this.titleText,
    this.description = '',
    this.posterSize = const Size(200.0, 112.0),
    this.onFocused,
    this.showTitle = true,
    this.onPressed,
    this.onArrowLeft,
    this.onArrowRight,
    this.seenValue = 0.0,
  });

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> {
  bool _holded = false;
  Color? _dominantColor;
  late final FocusNode _focusNode;

  /// обработчик выбора элемента
  void onTap() {
    widget.onPressed?.call();
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

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onFocused?.call(_focusNode);
      }
    });
    
    /// получаем цветовую палитру фильма
    // widget.movie.getPaletteGenerator(widget.movie.coverUrl).then((palette) {
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
    //final zoomedPosterSize = widget.posterSize + const Offset(32.0, 18.0);
  
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
          onFocusChange: (hasFocus) {
            /// при получении фокуса на фильме
            setState(() {
              
            });
          },

          onKey: (node, event) {
            if (_selectKeysMap.contains(event.logicalKey)) {
              /// ^ если была нажата клавиша выбора элемента
              _updateHoldedState(event is KeyDownEvent);
              // if (event is KeyUpEvent) {
              //   onTap();
              // }
            } else {
              _updateHoldedState(false);
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              return widget.onArrowLeft?.call() ?? KeyEventResult.ignored;
            }

            if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              return widget.onArrowRight?.call() ?? KeyEventResult.ignored;
            }

            return KeyEventResult.ignored;
          },
          
          child: SizedBox(
            width: widget.posterSize.width,
            child: Stack(
              children: [
                Column(
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Center(
                                child: Icon(Icons.video_file_outlined,
                                  size: 64.0,
                                  color: _focusNode.hasFocus
                                    ? theme.colorScheme.onSecondaryContainer
                                    : theme.colorScheme.onSecondaryContainer.withOpacity(0.36),
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// название эпизода
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: AnimatedDefaultTextStyle(
                        duration: KrsTheme.animationDuration,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: (_focusNode.hasFocus)
                            ? theme.textTheme.bodyMedium?.color
                            : theme.textTheme.bodyMedium?.color?.withOpacity(0.62),
                        ),
                        child: Text(widget.titleText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    /// описание эпизода
                    if (widget.description.isNotEmpty) Text(widget.description,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: (_focusNode.hasFocus)
                            ? theme.textTheme.caption?.color
                            : theme.textTheme.caption?.color?.withOpacity(0.36),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),

                if (widget.seenValue > 0.0) Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: widget.posterSize.height - 12.0,
                  child: AnimatedContainer(
                    duration: KrsTheme.fastAnimationDuration * 2,
                    padding: EdgeInsets.symmetric(
                      horizontal: (_focusNode.hasFocus) ? 4.0 : 8.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: LinearProgressIndicator(
                        value: widget.seenValue,
                        color: (_focusNode.hasFocus) ? null : theme.colorScheme.primary.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
