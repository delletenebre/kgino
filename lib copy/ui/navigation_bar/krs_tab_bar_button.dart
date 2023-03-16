import 'package:flutter/material.dart';

class KrsTabBarButton extends StatelessWidget {
  final Widget? icon;
  final FocusNode focusNode;
  final String labelText;
  final Function(bool) onFocusChange;
  final VoidCallback? onPressed;
  final bool selected;
  final bool active;

  const KrsTabBarButton({
    super.key,
    this.icon,
    required this.focusNode,
    required this.labelText,
    required this.onFocusChange,
    required this.onPressed,
    required this.selected,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final label = Text(labelText);

    final styleOpacity = active ? 1.0 : 0.62;
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 24.0,
        )
      ),
      
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (selected) {
          if (active) {
            return theme.colorScheme.primary;
          } else {
            return theme.colorScheme.primary.withOpacity(0.12);
          }
        }

        return Colors.transparent;
      }),

      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (active) {
          if (selected) {
            return theme.colorScheme.onPrimary;
          } else {
            theme.colorScheme.onSecondaryContainer;
          }
        } else {
          theme.colorScheme.onSecondaryContainer.withOpacity(0.12);
        }
        
        return theme.colorScheme.onSecondaryContainer.withOpacity(styleOpacity);
      }),

      overlayColor: MaterialStateProperty.all(Colors.transparent),

      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        );
      }),
      
    );

    if (icon != null) {
      /// ^ если нужно отобразить иконку
      
      return TextButton.icon(
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        onPressed: onPressed,
        style: buttonStyle,
        icon: icon!,
        label: label,
      );

    } else {
      /// ^ если иконка не нужна

      return TextButton(
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        onPressed: onPressed,
        style: buttonStyle,
        child: label,
      );

    }
  }
}
