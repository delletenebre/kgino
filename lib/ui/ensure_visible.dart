import 'package:flutter/material.dart';

class EnsureVisible extends StatelessWidget {
  final Widget child;
  final double alignment;

  const EnsureVisible({super.key, required this.child, this.alignment = 0.0});

  @override
  Widget build(context) => Focus(
        canRequestFocus: false,
        onFocusChange: (focused) {
          if (focused) {
            Scrollable.ensureVisible(
              context,
              alignment: alignment,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          }
        },
        child: child,
      );
}
