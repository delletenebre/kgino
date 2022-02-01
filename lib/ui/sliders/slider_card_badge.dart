import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

class SliderCardBadge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double size;


  const SliderCardBadge({
    Key? key,
    required this.child,
    this.color,
    this.size = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor = color ?? theme.cardColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32.0)
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        child: child,
      ) ,
    );
  }
}

extension SliderCardBadgeExtensions on TskgBagdeType {
  Widget content({required double size}) {
    switch (this) {
      
      case TskgBagdeType.newest:
        return Text('новое',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case TskgBagdeType.top:
        return Text('топ',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case TskgBagdeType.updated:
        return Icon(Icons.cached,
          size: size,
        );

      case TskgBagdeType.temporarily:
        return Icon(Icons.access_time,
          size: size,
        );

      case TskgBagdeType.finale:
        return Text('финал',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case TskgBagdeType.compilation:
        return Text('подборка',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case TskgBagdeType.important:
        return Text('важно',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case TskgBagdeType.newyear:
        return Icon(Icons.ac_unit,
          size: size,
        );

      case TskgBagdeType.unknown:
        break;
    }

    return const Text('');
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