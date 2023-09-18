import 'package:flutter/material.dart';

const appLogoWidth = 84.0;
const paddingSize = 24.0;

class TvUi {
  static const navigationBarSize = Size.fromHeight(32.0 + TvUi.vPadding * 2);

  static const columnWidth = 52.0;
  static const columnSpacing = 20.0;

  static const hPadding = 58.0;
  static const vPadding = 24.0;

  static const horizontalCardSize = Size(196.0, 110.0);
  static const verticalCardSize = Size(124.0, 186.0);

  static const backdropImageSize = Size(758.0, 428.0);

  static const cardListBottomSpacing = 86.0;
  static const cardListTitleHeight = 44.0;
  static final cardListHeight =
      cardListTitleHeight + horizontalCardSize.height + cardListBottomSpacing;

  static const featuredSize = Size(484.0, 316.0);
  static const featuredWidth = 484.0;
  static const featuredHeight = 316.0;
}
