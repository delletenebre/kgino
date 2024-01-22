import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kgino/extensions/string_extensions.dart';

class ProxyImage extends StatelessWidget {
  final String imageUrl;

  const ProxyImage({
    super.key,
    required this.imageUrl,
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
            fit: BoxFit.cover,
            alignment: Alignment.center,
          );
  }
}
