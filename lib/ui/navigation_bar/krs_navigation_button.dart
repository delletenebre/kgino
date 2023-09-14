import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KrsNavigationButton extends HookWidget {
  final String label;
  final IconData? icon;
  final void Function(bool hasFocus)? onFocusChange;
  final bool selected;

  const KrsNavigationButton({
    super.key,
    this.label = '',
    this.icon,
    this.onFocusChange,
    this.selected = false,
  });

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    final focusNode = useFocusNode();

    final animationController = useAnimationController(
      duration: kThemeAnimationDuration,
    );
    final colorAnimation = useAnimation<Color?>(ColorTween(
      begin: theme.colorScheme.onSurface,
      end: theme.colorScheme.onInverseSurface,
    ).animate(animationController));

    final backgroundColorAnimation = useAnimation<Color?>(ColorTween(
      begin: Colors.transparent,
      end: theme.colorScheme.inverseSurface,
    ).animate(animationController));

    final foregroundColor = Color(colorAnimation!.value);
    final backgroundColor = Color(backgroundColorAnimation!.value);

    if (selected) {
      animationController.animateTo(1.0);
    } else {
      animationController.animateTo(0.0);
    }

    Widget child = Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 6.0),
            child: Icon(
              icon,
              size: 22.0,
              color: Color(colorAnimation.value),
            ),
          ),
        Text(
          label,
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
      ],
    );

    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      child: Material(
        borderRadius: BorderRadius.circular(32.0),
        color: backgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            focusNode.requestFocus();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 6.0,
            ),
            height: 32.0,
            child: child,
          ),
        ),
      ),
    );
  }
}
