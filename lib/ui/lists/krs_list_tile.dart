import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../resources/krs_theme.dart';

class KrsListTile extends StatefulWidget {
  final FocusNode? focusNode;
  final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final void Function() onTap;

  final String title;
  final String imageUrl;

  const KrsListTile({
    super.key,
    this.focusNode,
    this.posterSize = const Size(100.0, 140.0),
    this.onFocused,
    required this.onTap,

    this.title = '',
    this.imageUrl = '',

  });

  @override
  State<KrsListTile> createState() => _KrsListTileState();
}

class _KrsListTileState extends State<KrsListTile> {
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

  // TODO fix it or remove
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
    // widget.item.getPaletteGenerator().then((palette) {
    //   if (palette.lightVibrantColor != null) {
    //     if (mounted) {
    //       setState(() {
    //         _glowColor = palette.lightVibrantColor!.color;
    //         // _dominantColor = palette.dominantColor!.color;
    //       });
    //     }
    //   }
    // });
    
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
  
    /// получаем цвет свечения
    _glowColor ??= theme.colorScheme.primary;

    _dominantColor ??= theme.colorScheme.surface;

    // final child = AnimatedScale(
    //   duration: KrsTheme.animationDuration,
    //   scale: (_focusNode.hasFocus && !_holded) ? 1.15 : 1.0,
    //   child: AnimatedContainer(
    //     duration: KrsTheme.animationDuration,
    //     width: widget.posterSize.width,
    //     height: widget.posterSize.height,
    //     decoration: BoxDecoration(
    //       boxShadow: [
    //         if (_focusNode.hasFocus) BoxShadow(
    //           color: _glowColor!.withOpacity(0.62),
    //           blurRadius: 20.0,
    //           spreadRadius: 4.0
    //         ),
    //       ],
    //       borderRadius: BorderRadius.circular(12.0),
    //       border: _focusNode.hasFocus
    //         ? Border.all(
    //             color: theme.colorScheme.onPrimaryContainer,
    //             width: 3.0,
    //           )
    //         : null
    //     ),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(9.0),
    //         color: theme.scaffoldBackgroundColor,
    //       ),
    //     ),
    //   ),
    // );

    final child = AnimatedContainer(
      duration: KrsTheme.animationDuration,
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
          image: DecorationImage(
            image: widget.imageUrl.endsWith('.svg')
              ? Svg(widget.imageUrl, source: SvgSource.network) as ImageProvider<Object>
              : NetworkImage(widget.imageUrl),
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(
            LogicalKeyboardKey.enter, includeRepeats: false): onTap,
          const SingleActivator(
            LogicalKeyboardKey.select, includeRepeats: false): onTap,
        },

        child: Focus(
          focusNode: _focusNode,
          onFocusChange: (hasFocus) {
            /// при получении фокуса
            setState(() {
              
            });
          },

          onKeyEvent: (node, event) {
            if (_selectKeysMap.contains(event.logicalKey)) {
              /// ^ если была нажата клавиша выбора элемента
              _updateHoldedState(event is KeyDownEvent);
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
                    child: child,
                  ),
                ),

                /// название сериала
                if (widget.title.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: AnimatedDefaultTextStyle(
                    duration: KrsTheme.animationDuration,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: (_focusNode.hasFocus)
                        ? theme.textTheme.bodyMedium?.color
                        : theme.textTheme.bodyMedium?.color?.withOpacity(0.62)
                    ),
                    child: Text(widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // /// дополнительная информация
                // if (widget.item.subtitle.isNotEmpty) Text(widget.item.subtitle,
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     color: theme.colorScheme.outline.withOpacity(0.36),
                //   ),
                //   maxLines: 1,
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
