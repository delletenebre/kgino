import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KikaListTile extends HookWidget {
  final FocusNode? focusNode;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final String imageUrl;
  final void Function(bool hasFocus)? onFocusChange;
  final void Function()? onSelect;
  final bool selected;
  final bool showSelectedIcon;
  final bool dense;

  const KikaListTile({
    super.key,
    this.focusNode,
    this.title = '',
    this.subtitle = '',
    this.imageUrl = '',
    this.onFocusChange,
    this.onSelect,
    this.selected = false,
    this.showSelectedIcon = false,
    this.dense = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focused = useState(false);

    return Focus(
      focusNode: focusNode,
      autofocus: selected,
      onFocusChange: (hasFocus) {
        /// при получении фокуса
        focused.value = hasFocus;

        onFocusChange?.call(hasFocus);
      },
      onKeyEvent: (focusNode, event) {
        if (HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.select) ||
            HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
          if (event is KeyDownEvent) {
            onSelect?.call();
          }
        }

        return KeyEventResult.ignored;
      },
      child: AnimatedScale(
        duration: kThemeAnimationDuration,
        scale: focused.value
            ? dense
                ? 1.05
                : 1.1
            : 1.0,
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.symmetric(
            vertical: dense ? 10.0 : 12.0,
            horizontal: dense ? 12.0 : 16.0,
          ),
          decoration: BoxDecoration(
            color: focused.value
                ? theme.colorScheme.inverseSurface
                : selected
                    ? theme.colorScheme.secondaryContainer
                    : Colors.transparent,
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: dense ? 20.0 : 24.0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: dense ? 14.0 : 16.0,
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
                        ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
                if (showSelectedIcon && selected)
                  Icon(
                    Icons.check_outlined,
                    size: 18.0,
                    color: focused.value
                        ? theme.colorScheme.surface
                        : theme.colorScheme.onSecondaryContainer,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
