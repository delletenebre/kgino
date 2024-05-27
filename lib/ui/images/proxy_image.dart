import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../extensions/string_extensions.dart';

class ProxyImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderUrl;

  const ProxyImage({
    super.key,
    required this.imageUrl,
    this.placeholderUrl,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.proxyImageUrl;

    return url.startsWith('assets')
        ? url.endsWith('svg')
            ? SvgPicture.asset(
                url,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            : Image.asset(
                url,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
        : CachedNetworkImage(
            imageUrl: url,
            fadeOutDuration: kThemeAnimationDuration * 2,
            fadeInDuration: Duration.zero,
            placeholder: placeholderUrl != null
                ? (context, url) => Image.network(
                      placeholderUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                : null,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          );
  }
}
