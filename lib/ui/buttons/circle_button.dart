import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final Widget child;
  final Function()? onPressed;

  const CircleButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(48.0),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: _hasFocus ? theme.colorScheme.primary : Colors.transparent,
            width: 2.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(48.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(48.0),

          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },

          focusColor: theme.colorScheme.primary.withOpacity(0.1),
          
          onTap: widget.onPressed,

          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.child,
            ),
          ),
          
        ),
      ),
    );
  }
}