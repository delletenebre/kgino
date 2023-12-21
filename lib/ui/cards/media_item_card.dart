import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/media_item.dart';

class MediaItemCard extends HookWidget {
  static const width = 196.0;
  static const height = width / 16 * 9;

  final MediaItem mediaItem;
  final void Function(bool hasFocus)? onFocusChanged;
  final void Function() onTap;

  const MediaItemCard({
    super.key,
    required this.mediaItem,
    this.onFocusChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focused = useState(false);
    final imageUrl = mediaItem.poster;

    /// цвет свечения
    final glowColor = useState(theme.colorScheme.outline.withOpacity(0.62));

    /// вычисляем цвет свечения
    useEffect(() {
      if (1 == 2 &&
          imageUrl.isNotEmpty &&
          !imageUrl.endsWith('.svg') &&
          !imageUrl.startsWith('assets/')) {
        /// ^ если изображение есть и оно не векторное

        try {
          /// получаем цветовую палитру изображения
          ColorScheme.fromImageProvider(
                  provider: CachedNetworkImageProvider(imageUrl, maxWidth: 100))
              .then((colorScheme) {
            /// обновляем цвет свечения
            glowColor.value = colorScheme.primary.withOpacity(0.62);
          });
        } catch (exception) {
          debugPrint('PaletteGenerator FAIL');
        }
      }

      /// we could optionally return some "dispose" logic here
      return null;
    }, const []);

    return Focus(
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;
        onFocusChanged?.call(hasFocus);
      },
      onKeyEvent: (focusNode, event) {
        // if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.select]
        //     .contains(event.logicalKey)) {
        //   if (event is KeyUpEvent) {
        //     onTap.call();
        //   }
        // }

        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: onTap,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter,
                includeRepeats: false): onTap,
            const SingleActivator(LogicalKeyboardKey.select,
                includeRepeats: false): onTap,
          },
          child: AnimatedScale(
            duration: kThemeAnimationDuration,
            scale: focused.value ? 1.1 : 1.0,
            child: AnimatedContainer(
              duration: kThemeAnimationDuration,
              width: width,
              height: height,
              clipBehavior: Clip.antiAlias,
              foregroundDecoration: BoxDecoration(
                border: focused.value
                    ? Border.all(
                        color: theme.colorScheme.outline,
                        width: 3.0,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12.0),
              ),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,

                /// постер
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl, maxWidth: 200),
                  fit: BoxFit.cover,
                ),

                /// цвет свечения
                boxShadow: [
                  if (focused.value)
                    BoxShadow(
                      color: glowColor.value,
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                ],
                borderRadius: BorderRadius.circular(12.0),
                border: focused.value
                    ? Border.all(
                        color: theme.colorScheme.onPrimaryContainer,
                        width: 2.0,
                      )
                    : null,
              ),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.bottomLeft,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  /// scrim on top of image background
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.16),
                    ],
                    stops: const [0.24, 0.8],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mediaItem.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   'Title',
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: theme.textTheme.bodySmall?.copyWith(
                    //     color: theme.colorScheme.onSurfaceVariant,
                    //   ),
                    // ),
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
