import 'package:flutter/cupertino.dart';

class AnimatedLoading extends StatelessWidget {
  final double size;

  const AnimatedLoading({super.key, this.size = 16.0});

  @override
  Widget build(context) {
    return Center(
      child: CupertinoActivityIndicator(radius: size),
    );
  }
}
