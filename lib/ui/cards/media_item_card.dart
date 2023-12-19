import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MediaItemCard extends HookWidget {
  final FocusNode? focusNode;
  final Widget child;
  const MediaItemCard({
    super.key,
    this.focusNode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focused = useState(false);

    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        focused.value = hasFocus;
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: 240,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.lightGreen,
            boxShadow: [
              if (focused.value)
                BoxShadow(
                    //color: _glowColor!.withOpacity(0.62),
                    blurRadius: 20.0,
                    spreadRadius: 4.0),
            ],
            borderRadius: BorderRadius.circular(12.0),
            border: focused.value
                ? Border.all(
                    color: theme.colorScheme.onPrimaryContainer,
                    width: 3.0,
                  )
                : null),
        child: child,
      ),
    );
  }
}
