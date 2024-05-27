import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extensions/string_extensions.dart';
import '../../resources/kika_theme.dart';
import '../text/scrollable_text.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final String imageUrl;
  final KeyEventResult Function()? onPressed;
  final KeyEventResult Function()? onLongPress;
  final void Function(bool hasFocus)? onFocusChange;
  final Widget? endWidget;

  const ItemCard({
    super.key,
    required this.title,
    this.width = kCardWidth,
    this.height = kCardHeight,
    this.imageUrl = 'assets/icons/sun.svg',
    this.onPressed,
    this.onLongPress,
    this.onFocusChange,
    this.endWidget,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _focused = false;
  bool _pressed = false;
  int _pressedAt = 0;

  /// цвет свечения
  Color? glowColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Center(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus && glowColor == null) {
            () async {
              try {
                /// получаем цветовую палитру изображения
                ColorScheme.fromImageProvider(
                        provider:
                            widget.imageUrl.toProxyImageProvider(maxWidth: 16))
                    .then((colorScheme) {
                  /// обновляем цвет свечения
                  setState(() {
                    glowColor = colorScheme.primary.withOpacity(0.62);
                  });
                });
              } catch (exception) {
                debugPrint('PaletteGenerator FAIL');
              }
            }.call();
          }
          setState(() {
            _focused = hasFocus;
          });
          widget.onFocusChange?.call(hasFocus);
        },
        onKeyEvent: (node, event) {
          bool pressed = _pressed;
          if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.select]
              .contains(event.logicalKey)) {
            pressed =
                [KeyRepeatEvent, KeyDownEvent].contains(event.runtimeType);

            switch (event.runtimeType) {
              case const (KeyDownEvent):
                _pressedAt = DateTime.now().millisecondsSinceEpoch;
                break;
              case const (KeyRepeatEvent):
                if (_pressedAt > 0 &&
                    DateTime.now().millisecondsSinceEpoch - _pressedAt > 750) {
                  widget.onLongPress?.call();
                  _pressedAt = -1;
                }
                break;
              case const (KeyUpEvent):
                if (_pressedAt > -1) {
                  widget.onPressed?.call();
                }
                _pressedAt = 0;

                break;
            }
          }

          if (pressed != _pressed) {
            setState(() => _pressed = pressed);
          }

          return KeyEventResult.ignored;
        },
        child: Listener(
          onPointerDown: (event) {
            if (!_focused) {
              setState(() => _focused = true);
            }
            if (!_pressed) {
              setState(() => _pressed = true);
            }
          },
          onPointerUp: (event) {
            if (_pressed) {
              setState(() => _pressed = false);
            }
            if (_focused) {
              setState(() => _focused = false);
            }
          },
          child: AnimatedScale(
            duration: kThemeAnimationDuration,
            scale: _focused && !_pressed
                ? 1.1
                : _pressed
                    ? 0.95
                    : 1.0,
            child: AnimatedContainer(
              duration: kThemeAnimationDuration,
              width: widget.width,
              height: widget.height,
              foregroundDecoration: BoxDecoration(
                border: _focused
                    ? Border.all(
                        color: theme.colorScheme.outline,
                        width: 2.0,
                      )
                    : Border.all(
                        color: theme.colorScheme.outline,
                        width: 0.0,
                      ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,

                /// постер
                image: widget.imageUrl.isEmpty
                    ? null
                    : DecorationImage(
                        image: widget.imageUrl.toProxyImageProvider(
                          maxWidth: widget.width.toInt(),
                        ),
                        fit: widget.imageUrl.endsWith('.svg')
                            ? BoxFit.none
                            : BoxFit.fitHeight,
                      ),

                /// цвет свечения
                boxShadow: [
                  if (_focused)
                    BoxShadow(
                      color: glowColor ??
                          theme.colorScheme.onSurface.withOpacity(0.62),
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                ],
                borderRadius: BorderRadius.circular(12.0),
                border: _focused
                    ? Border.all(
                        color: theme.colorScheme.onPrimaryContainer,
                        width: 2.0,
                      )
                    : null,
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: widget.width,
                height: _focused ? widget.height : 0.0,
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  /// scrim on top of image background
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1.0),
                      Colors.black.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.62],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScrollableText(
                      text: widget.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      enabled: _focused,
                    ),
                    if (widget.endWidget != null) widget.endWidget!,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
