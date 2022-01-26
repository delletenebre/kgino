import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

class SliderCardBadge extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;


  const SliderCardBadge({
    Key? key,
    required this.icon,
    this.color,
    this.size = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor = color ?? theme.cardColor;

    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32.0)
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        child: Icon(icon,
          size: size,
        ),
      ) ,
    );
  }
}

extension SliderCardBadgeExtensions on TskgBagdeType {
  IconData icon() {
    switch (this) {
      
      case TskgBagdeType.newest:
        return Icons.new_releases;

      case TskgBagdeType.top:
        return Icons.star;

      case TskgBagdeType.updated:
        return Icons.cached;

      case TskgBagdeType.temporarily:
        return Icons.access_time;

      case TskgBagdeType.finale:
        return Icons.check_circle_outline;

      case TskgBagdeType.compilation:
        // TODO: Handle this case.
        break;
      case TskgBagdeType.important:
        // TODO: Handle this case.
        break;
      case TskgBagdeType.newyear:
        return Icons.ac_unit;

      case TskgBagdeType.unknown:
        // TODO: Handle this case.
        break;
    }

    return Icons.ac_unit;
  }

  Color color() {
    switch (this) {
      
      case TskgBagdeType.newest:
        return Colors.green.shade700;

      case TskgBagdeType.top:
        return Colors.orange.shade700;

      case TskgBagdeType.updated:
      case TskgBagdeType.temporarily:
      case TskgBagdeType.unknown:
        return Colors.grey.shade700;

      case TskgBagdeType.finale:
        return Colors.blue.shade700;

      case TskgBagdeType.compilation:
        return Colors.blue.shade700;

      case TskgBagdeType.important:
      case TskgBagdeType.newyear:
        return Colors.red.shade700;

    }
  }
}