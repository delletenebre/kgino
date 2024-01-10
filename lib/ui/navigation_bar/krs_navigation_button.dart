import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KrsNavigationButton extends HookWidget {
  final FocusNode? focusNode;

  /// в фокусе ли навигационный бар
  final bool active;

  /// страница выбрана
  final bool selected;

  /// при нажатии на кнопку
  final void Function() onSelected;
  final Widget child;

  const KrsNavigationButton({
    super.key,
    this.focusNode,
    required this.active,
    required this.selected,
    required this.onSelected,
    required this.child,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    final focusNode = this.focusNode ?? useFocusNode();

    final style = ButtonStyle(
      elevation: MaterialStateProperty.all(0.0),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24.0)),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.hovered)) {
          return theme.colorScheme.inverseSurface;
        }

        if (selected) {
          return theme.colorScheme.inverseSurface
              .withOpacity(active ? 1.0 : 0.62);
        }

        return Colors.transparent;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return theme.colorScheme.onInverseSurface;
        } else if (states.contains(MaterialState.hovered)) {
          return theme.colorScheme.onInverseSurface;
        }

        if (selected) {
          return theme.colorScheme.onInverseSurface;
        }

        return theme.colorScheme.onSurface;
      }),
      //overlayColor: MaterialStateProperty.all(Colors.red),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        );
      }),
    );

    return FilledButton(
      focusNode: focusNode,
      style: style,
      onFocusChange: (hasFocus) {
        onSelected.call();
      },
      onPressed: () {
        focusNode.requestFocus();
      },
      child: child,
    );
    return Container();
  }
}
