import 'package:flutter/material.dart';

import '../../resources/kika_theme.dart';
import '../images/proxy_image.dart';

class BackdropImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderUrl;

  const BackdropImage({
    super.key,
    required this.imageUrl,
    this.placeholderUrl,
  });

  @override
  Widget build(context) {
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
        child: SizedBox.fromSize(
          size: TvUi.backdropImageSize,
          child: ProxyImage(
            imageUrl: imageUrl,
            placeholderUrl: placeholderUrl,
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
