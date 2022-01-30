import 'package:flutter/material.dart';
import 'package:kgino/ui/buttons/circle_button.dart';

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

    Widget child = const Icon(Icons.play_arrow);

    if (!widget.isPlaying) {
      child = const Icon(Icons.pause);
    }

    return Material(
      color: Colors.transparent,

      borderRadius: BorderRadius.circular(96.0),
      
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            //color: _hasFocus ? theme.colorScheme.primary : Colors.transparent,
            width: 2.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(48.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(96.0),
          onTap: widget.onPressed,
          child: AnimatedOpacity(
            duration: animationDuration,
            opacity: opacity,
            child: AnimatedContainer(
              width: size,
              height: size,
              
              duration: animationDuration,
              child: FittedBox(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
    // CircleButton(
    //   onPressed: widget.onPressed,
    //   child: AnimatedOpacity(
    //     duration: animationDuration,
    //     opacity: opacity,
    //     child: AnimatedContainer(
    //       width: size,
    //       height: size,
          
    //       duration: animationDuration,
    //       child: FittedBox(
    //         child: child,
    //       ),
    //     ),
    //   ),
      
    //   // AnimatedSize(
    //   //   duration: animationDuration,
    //   //   child: AnimatedOpacity(
    //   //     duration: animationDuration,
    //   //     opacity: opacity,
    //   //     child: child
    //   //   ),
    //   // ),
    // );
  }
}