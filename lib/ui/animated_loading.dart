import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class AnimatedLoading extends StatelessWidget {
  final double size;

  const AnimatedLoading({super.key, this.size = 24.0});

  @override
  Widget build(context) {
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: RiveAnimation.asset(
          'assets/animations/sun.riv',
          placeHolder: SvgPicture.asset(
            'assets/icons/sun.svg',
            colorFilter: const ColorFilter.mode(
              Color(0xffeeb76b),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
