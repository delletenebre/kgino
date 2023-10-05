import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/constants.dart';

class BackdropImage extends StatelessWidget {
  final String imageUrl;
  const BackdropImage(
    this.imageUrl, {
    super.key,
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
          child: imageUrl.startsWith('assets')
              ? imageUrl.endsWith('svg')
                  ? SvgPicture.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
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
