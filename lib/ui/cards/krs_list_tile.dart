import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../resources/constants.dart';

class KrsListTile extends HookWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function() onTap;
  final bool selected;

  const KrsListTile({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.imageUrl = '',
    this.onFocusChange,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focused = useState(false);

    return Focus(
      onFocusChange: (hasFocus) {
        /// при получении фокуса
        focused.value = hasFocus;

        onFocusChange?.call(hasFocus);
      },
      onKeyEvent: (focusNode, event) {
        if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.select]
            .contains(event.logicalKey)) {
          if (event is KeyUpEvent) {
            onTap.call();
          }
        }

        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: kThemeAnimationDuration,
          scale: focused.value ? 1.1 : 1.0,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            clipBehavior: Clip.antiAlias,
            width: TvUi.horizontalCardSize.width,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: focused.value
                  ? theme.colorScheme.inverseSurface
                  : selected
                      ? theme.colorScheme.secondaryContainer
                      : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: AnimatedDefaultTextStyle(
              duration: kThemeAnimationDuration,
              style: TextStyle(
                color: focused.value
                    ? theme.colorScheme.surface
                    : selected
                        ? theme.colorScheme.onSecondaryContainer
                        : theme.colorScheme.onSurface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24.0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
