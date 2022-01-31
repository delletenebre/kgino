import 'package:flutter/material.dart';

class PlayerInvisibleTouchButtons extends StatelessWidget {
  final bool enabled;

  final Function()? onTap;

  const PlayerInvisibleTouchButtons({
    Key? key,
    required this.enabled,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if (enabled) {
      /// ^ если виджет активен

      return Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: GestureDetector(
              excludeFromSemantics: true,

              onTap: () {
                onTap?.call();
              },

              onDoubleTap: () {
                debugPrint('onDoubleTap replay');
              },
              
            ),
          ),


          Flexible(
            child: GestureDetector(
              excludeFromSemantics: true,

              onTap: () {
                onTap?.call();
              },

            ),
          ),


          Flexible(
            child: GestureDetector(
              excludeFromSemantics: true,

              onTap: () {
                onTap?.call();
              },

              onDoubleTap: () {
                debugPrint('onDoubleTap forward');
              },

            ),
          ),
        ],
      );
      
    } else {
      /// ^ если виджет не должен обрабатывать нажатия
      
      return const SizedBox();

    }
  }
}