import 'package:flutter/material.dart';
import 'package:kgino/ui/buttons/rounded_button.dart';

class PlayerPlayPauseButton extends StatefulWidget {
  final Function() onPressed;
  final bool isPlaying;

  const PlayerPlayPauseButton({
    Key? key,
    required this.onPressed,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  State<PlayerPlayPauseButton> createState() => _PlayerPlayPauseButtonState();
}

class _PlayerPlayPauseButtonState extends State<PlayerPlayPauseButton> {
  double opacity = 0;
  double size = 96.0;

  static const animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((time) {
      setState(() {
        opacity = 1.0;
        size = 64.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = const Icon(Icons.play_arrow, key: ValueKey(1));

    if (!widget.isPlaying) {
      child = const Icon(Icons.pause, key: ValueKey(2));
    }

    return RoundedButton(
      onPressed: widget.onPressed,
      child: AnimatedSwitcher(
        duration: animationDuration,
        reverseDuration: Duration.zero,
        
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 2.5,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
        child: child,
      )
      // child: AnimatedOpacity(
      //   duration: animationDuration,
      //   opacity: opacity,
      //   child: AnimatedContainer(
      //     width: size,
      //     height: size,
          
      //     duration: animationDuration,
      //     child: FittedBox(
            
      //       child: child,
      //     ),
      //   ),
      // ),
    );
  }
}