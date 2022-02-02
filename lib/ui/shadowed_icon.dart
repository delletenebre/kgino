import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';

class ShadowedIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const ShadowedIcon(this.icon, {
    Key? key,
    this.size = 24.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedIcon(icon,
      color: theme.colorScheme.primary,
      size: size,
      shadows: [
        BoxShadow(
          blurRadius: 12.0,
          color: theme.scaffoldBackgroundColor,
        ),
      ],
    );
  }
}