import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

extension StringExtensions on String {
  Duration toDuration() {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    final parts = split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    seconds = int.parse(parts[parts.length - 1]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  String get proxyImageUrl {
    if (startsWith('assets')) {
      return this;
    } else {
      if (kIsWeb) {
        return 'https://app.iuk.edu.kg/functions/v1/corsproxy/?url=$this';
      } else {
        return this;
      }
    }
  }

  ImageProvider toProxyImageProvider({int? maxWidth}) {
    final proxyUrl = proxyImageUrl;
    return proxyUrl.endsWith('.svg')
        ? Svg(
            proxyUrl,
            source: proxyUrl.startsWith('assets/')
                ? SvgSource.asset
                : SvgSource.network,
          )
        : proxyUrl.startsWith('assets/')
            ? Image.asset(proxyUrl).image
            : CachedNetworkImageProvider(proxyUrl, maxWidth: maxWidth);
  }
}
