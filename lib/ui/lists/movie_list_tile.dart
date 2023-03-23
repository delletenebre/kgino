import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/krs_theme.dart';

class MovieListTile extends StatefulWidget {
  final FocusNode? focusNode;
  // final MovieItem item;
  final Size posterSize;
  final void Function(FocusNode focusNode)? onFocused;
  final bool titleEnabled;
  final void Function() onTap;

  const MovieListTile({
    super.key,
    this.focusNode,
    // required this.item,
    this.posterSize = const Size(126.0, 102.0),
    this.onFocused,
    this.titleEnabled = true,
    required this.onTap,
  });

  @override
  State<MovieListTile> createState() => _MovieListTileState();
}

class _MovieListTileState extends State<MovieListTile> {
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
    // final settingsBox = Hive.box('settings');

    /// включены ли в настройках визуальные эффекты
    // final animationsEnabled = settingsBox.get('animations', defaultValue: true);
  
    /// получаем цвет свечения
    _glowColor ??= theme.colorScheme.primary;

    _dominantColor ??= theme.colorScheme.surface;

    final child = AnimatedScale(
      duration: KrsTheme.animationDuration,
      scale: (_focusNode.hasFocus && !_holded) ? 1.15 : 1.0,
      child: AnimatedContainer(
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
          ),
          
// ExtendedImage.network(
//             widget.item.posterUrl,
//             width: widget.posterSize.width,
//             height: widget.posterSize.height,
//             fit: BoxFit.fill,
//             cache: true,
//             shape: BoxShape.rectangle,
//             borderRadius: const BorderRadius.all(Radius.circular(9.0)),
//           ),
          // child: CachedNetworkImage(
          //   imageUrl: widget.item.posterUrl,
          //   memCacheWidth: widget.posterSize.width.toInt(),
          //   memCacheHeight: widget.posterSize.height.toInt(),
          //   fit: BoxFit.cover,
          //   imageBuilder: (context, imageProvider) => Container(
          //     decoration: BoxDecoration(
          //       borderRadius: const BorderRadius.all(Radius.circular(9.0)),
          //       image: DecorationImage(
          //         image: imageProvider,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   errorWidget: (context, url, error) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         color: theme.colorScheme.secondaryContainer,
          //         borderRadius: BorderRadius.circular(9.0),
          //       ),
          //       child: Center(
          //         child: Icon(Icons.video_file_outlined,
          //           size: 64.0,
          //           color: _focusNode.hasFocus
          //             ? theme.colorScheme.onSecondaryContainer
          //             : theme.colorScheme.onSecondaryContainer.withOpacity(0.36),
          //         ),
          //       )
          //     );
          //   },
          // ),
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
                    child: child,
                  ),
                ),

                /// название сериала
                if (widget.titleEnabled) Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: AnimatedDefaultTextStyle(
                    duration: KrsTheme.animationDuration,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: (_focusNode.hasFocus)
                        ? theme.textTheme.bodyMedium?.color
                        : theme.textTheme.bodyMedium?.color?.withOpacity(0.62)
                    ),
                    child: Text('widget.item.name',
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
