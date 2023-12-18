import 'package:flutter/material.dart';

class KrsNavigationButton extends StatelessWidget {
  final bool active;

  final bool selected;
  final void Function() onSelected;
  final Widget child;

  const KrsNavigationButton({
    Key? key,
    required this.active,
    required this.selected,
    required this.onSelected,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    final style = ButtonStyle(
      elevation: MaterialStateProperty.all(0.0),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24.0)),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        // if (active) {
        //   if (states.contains(MaterialState.focused) ||
        //       states.contains(MaterialState.hovered)) {
        //     return theme.colorScheme.primary;
        //   } else {
        //     return theme.colorScheme.primary.withOpacity(0.62);
        //   }
        // }
        if (states.contains(MaterialState.focused)) {
          return theme.colorScheme.primary;
        } else if (states.contains(MaterialState.hovered)) {
          return theme.colorScheme.primary.withOpacity(0.8);
        } else if (active) {
          return theme.colorScheme.primary;
        }

        return Colors.transparent;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          if (active) {
            return theme.colorScheme.onPrimary;
          } else {
            theme.colorScheme.onSecondaryContainer;
          }
        } else {
          theme.colorScheme.onSecondaryContainer.withOpacity(0.12);
        }

        return theme.colorScheme.onSecondaryContainer;
      }),
      // overlayColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        );
      }),
    );

    return FilledButton(
      style: style,
      onFocusChange: (hasFocus) {
        onSelected.call();
      },
      onPressed: () {
        onSelected.call();
      },
      child: child,
    );
    return Container();
  }
}
