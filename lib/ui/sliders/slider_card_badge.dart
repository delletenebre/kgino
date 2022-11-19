import 'package:flutter/material.dart';

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

extension SliderCardBadgeExtensions on String {
  Widget content({required double size}) {
    switch (this) {
      
      case 'Новое':
        return Text('новое',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case 'Топ':
        return Text('топ',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case 'Обновлено':
        return Icon(Icons.cached,
          size: size,
        );

      case 'Временно':
        return Icon(Icons.access_time,
          size: size,
        );

      case 'Финал':
        return Text('финал',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case 'Подборка':
        return Text('подборка',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case 'Важно':
        return Text('важно',
          style: TextStyle(
            fontSize: size,
          ),
        );

      case 'Новогоднее':
        return Icon(Icons.ac_unit,
          size: size,
        );

      default:
        return Text(this);
    }

  }

  Color color() {
    switch (this) {
      
      case 'Новое':
        return Colors.green.shade700;

      case 'Топ':
        return Colors.orange.shade700;

      case 'Финал':
      case 'Подборка':
        return Colors.blue.shade700;

      case 'Важно':
      case 'Новогоднее':
        return Colors.red.shade700;

      case 'Обновлено':
      case 'Временно':
      default:
        return Colors.grey.shade700;
    }
  }
}