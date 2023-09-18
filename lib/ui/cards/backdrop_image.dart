import 'package:flutter/material.dart';

import '../../resources/constants.dart';

class BackdropImage extends StatelessWidget {
  final String imageUrl;
  const BackdropImage(
    this.imageUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (rect) {
          const alignment = Alignment(0.575, -1.0);

          return const RadialGradient(
            center: alignment,
            radius: 1.0,
            // focal: alignment,
            // focalRadius: 0.62,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
            transform: GradientOval(),
          ).createShader(rect);
        },

        /// постер фильма
        child: Opacity(
          opacity: 1.0,
          child: SizedBox.fromSize(
            size: TvUi.backdropImageSize,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

class GradientOval extends GradientTransform {
  const GradientOval();

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final scale = bounds.right / bounds.bottom;
    final oldWidth = bounds.bottom;
    final newWidth = oldWidth * scale;

    return Matrix4.identity()
      ..scale(scale, 1.0)
      ..translate(-(newWidth - oldWidth) / 2, 0.0);
  }
}
