import 'package:flutter/material.dart';

class KikaClosedCaption extends StatelessWidget {
  /// Creates a a new closed caption, designed to be used with
  /// [VideoPlayerValue.caption].
  ///
  /// If [text] is null or empty, nothing will be displayed.
  const KikaClosedCaption({super.key, this.text, this.textStyle});

  /// The text that will be shown in the closed caption, or null if no caption
  /// should be shown.
  /// If the text is empty the caption will not be shown.
  final String? text;

  /// Specifies how the text in the closed caption should look.
  ///
  /// If null, defaults to [DefaultTextStyle.of(context).style] with size 36
  /// font colored white.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final String? text = this.text;
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    final TextStyle effectiveTextStyle = textStyle ??
        DefaultTextStyle.of(context).style.copyWith(
          fontSize: 24.0,
          color: const Color(0xffffd700),
          shadows: const [
            Shadow(
              blurRadius: 48.0,
            ),
            Shadow(
              blurRadius: 32.0,
            ),
            Shadow(
              blurRadius: 24.0,
            ),
            Shadow(
              blurRadius: 24.0,
            ),
            Shadow(
              blurRadius: 2.0,
            ),
          ],
        );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            //color: const Color(0xB8000000),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(text, style: effectiveTextStyle),
          ),
        ),
      ),
    );
  }
}
