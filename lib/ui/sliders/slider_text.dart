import 'package:flutter/material.dart';

class SliderText extends StatelessWidget {
  final String text;
  final double fontSize;

  const SliderText({
    Key? key,
    this.text = '',
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (text.isEmpty) {

      return const SizedBox();
    
    } else {

      return Text(text,
        style: TextStyle(
          fontSize: fontSize,
          shadows: [
            Shadow(
              color: theme.bottomAppBarColor,
            ),
            Shadow(
              blurRadius: 2.0,
              color: theme.bottomAppBarColor,
            ),
            Shadow(
              blurRadius: 4.0,
              color: theme.bottomAppBarColor,
            ),
            Shadow(
              blurRadius: 6.0,
              color: theme.bottomAppBarColor,
            ),
            Shadow(
              blurRadius: 8.0,
              color: theme.bottomAppBarColor,
            ),
            Shadow(
              blurRadius: 10.0,
              color: theme.bottomAppBarColor,
            ),
          ],
        ),
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      );

    }

  }
}