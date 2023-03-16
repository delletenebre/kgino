import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/tabs_cubit.dart';

class KrsTabBarButton extends StatelessWidget {
  final int index;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget label;
  final bool selected;

  const KrsTabBarButton({
    super.key,
    required this.index,
    required this.onPressed,
    this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tabsCubit = GetIt.instance<TabsCubit>();

    final selected = tabsCubit.state == index;
    final focusNode = tabsCubit.focusNodes[index];
    void onFocusChange(hasFocus) {
      if (hasFocus) {
        tabsCubit.updateSelected(index);
      }
    }

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 24.0,
        )
      ),
      
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return theme.colorScheme.primary.withOpacity(0.24);
        }
        
        if (selected) {
          return theme.colorScheme.primary.withOpacity(0.12);
        }

        return null;
      }),
    );

    if (icon != null) {
      /// ^ если нужно отобразить иконку
      
      return TextButton.icon(
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        style: buttonStyle,
        onPressed: onPressed,
        icon: icon!,
        label: label,
      );

    } else {
      /// ^ если иконка не нужна

      return TextButton(
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        style: buttonStyle,
        onPressed: onPressed,
        child: label,
      );

    }
  }
}
