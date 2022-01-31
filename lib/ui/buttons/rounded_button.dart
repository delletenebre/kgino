import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final Widget child;
  final Function()? onPressed;
  final FocusNode? focusNode;

  const RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool _hasFocus = false;

  final borderRadius = BorderRadius.circular(48.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final primaryColor = theme.colorScheme.primary;

    final focusColor = primaryColor.withOpacity(0.1);

    final highlightColor = primaryColor.withOpacity(0.25);

    return Material(
      borderRadius: borderRadius,
      type: MaterialType.transparency,
      
      child: InkWell(
        borderRadius: borderRadius,

        focusNode: widget.focusNode,

        onFocusChange: (hasFocus) {
          setState(() {
            _hasFocus = hasFocus;
          });
        },
        
        focusColor: focusColor,
        hoverColor: focusColor,
        highlightColor: highlightColor,
        splashColor: highlightColor,
        
        onTap: widget.onPressed,

        child: Ink(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: primaryColor.withOpacity(_hasFocus ? 1.0 : 0.25),
              width: 2.0,
              style: BorderStyle.solid
            ),
            
          ),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
            ],
          ),
        ),
      ),
    );
  }

}