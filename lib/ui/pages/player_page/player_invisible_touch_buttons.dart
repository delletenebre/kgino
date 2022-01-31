import 'package:flutter/material.dart';

class PlayerInvisibleTouchButtons extends StatelessWidget {
  final bool enabled;

  final Function()? onTap;

  final Function()? onReplay;

  final Function()? onForward;

  const PlayerInvisibleTouchButtons({
    Key? key,
    required this.enabled,
    this.onTap,
    this.onReplay,
    this.onForward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      children: [

        Flexible(
          child: GestureDetector(
            behavior: enabled ? HitTestBehavior.opaque : HitTestBehavior.translucent,
            excludeFromSemantics: true,

            onTap: () {
              onTap?.call();
            },

            onDoubleTap: () {
              onReplay?.call();
            },

          ),
        ),


        Flexible(
          child: Listener(
            behavior: enabled ? HitTestBehavior.opaque : HitTestBehavior.translucent,

            onPointerDown: (event) {
              onTap?.call();
            },

          ),
        ),


        Flexible(
          child: GestureDetector(
            behavior: enabled ? HitTestBehavior.opaque : HitTestBehavior.translucent,
            excludeFromSemantics: true,

            onTap: () {
              onTap?.call();
            },

            onDoubleTap: () {
              onForward?.call();
            },

          ),
        ),

      ],
    );
      
  }
}