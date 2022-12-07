import 'package:flutter/material.dart';

class KrsChip extends StatelessWidget {
  final Widget child;
  final bool dense;
  final bool filled;
  final Color? borderColor;

  const KrsChip({
    super.key,
    required this.child,
    this.dense = false,
    this.filled = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color? backgroundColor;
    Color? foregroundColor;

    if (filled) {
      backgroundColor = theme.colorScheme.surface;
      foregroundColor = theme.colorScheme.onSurface;
    }

    return Container(
      height: dense ? 16.0 : 24.0,
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: dense ? 1.0 : 4.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          width: 1.0,
          color: borderColor ?? theme.colorScheme.outline,
        ),
      ),
      child: IconTheme(
        data: theme.iconTheme.copyWith(
          size: dense ? 10.0 : 12.0,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: foregroundColor,
            fontSize: dense ? 10.0 : 12.0,
          ),
          child: child,
        ),
      )
      ,
    );
  }
}