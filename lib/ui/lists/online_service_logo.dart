import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/kika_theme.dart';

class OnlineServiceLogo extends StatelessWidget {
  final String logo;
  const OnlineServiceLogo(this.logo, {super.key});

  @override
  Widget build(BuildContext context) {
    return logo.endsWith('.svg')
        ? SvgPicture.asset(
            logo,
            height: kListTitleHeight / 3.0,

            fit: BoxFit.scaleDown,
            // colorFilter: ColorFilter.mode(
            //     Colors.grey, BlendMode.srcIn),
            excludeFromSemantics: true,
          )
        : Image.asset(
            logo,
            height: kListTitleHeight / 3.0,
            fit: BoxFit.scaleDown,
            excludeFromSemantics: true,
          );
  }
}
