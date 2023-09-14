import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KrsTabBarButton extends HookConsumerWidget {
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
  Widget build(context, ref) {
    final theme = Theme.of(context);

    final focusState = useState(false);

    final tabsCubit = ref.watch(tabsProvider);

    final selected = tabsCubit.state == index;
    final focusNode = tabsCubit.focusNodes[index];
    void onFocusChange(hasFocus) {
      if (hasFocus) {
        tabsCubit.updateSelected(index);
      }

      focusState.value = hasFocus;
    }

    Color? backgroundColor;
    if (focusState.value) {
      backgroundColor = theme.colorScheme.primary.withOpacity(0.24);
    } else if (selected) {
      backgroundColor = theme.colorScheme.primary.withOpacity(0.12);
    }
    final foregroundColor = theme.textTheme.bodyMedium?.color;

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );

    return TextButton(
      style: buttonStyle,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onPressed: () {
        tabsCubit.unfocusAll();
        tabsCubit.updateSelected(index);
      },
      child: label,
    );
  }
}
