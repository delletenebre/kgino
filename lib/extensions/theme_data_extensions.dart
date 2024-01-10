import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:material_color_utilities/utils/math_utils.dart';

import '../resources/krs_theme.dart';

extension ThemeDataExtensions on ThemeData {
  Color _surfaceContainerColor(int lightTone, int darkTone) {
    final palette = CorePalette.of(KrsTheme.seedColor.value);
    return Color(palette.neutral
        .get(brightness == Brightness.light ? lightTone : darkTone));
  }

  Color get surfaceContainerLow => _surfaceContainerColor(96, 10);
  Color get surfaceContainer => _surfaceContainerColor(94, 12);
  Color get surfaceContainerHighest => _surfaceContainerColor(90, 22);

  Color successContainerColor() {
    final palette = CorePalette.of(Colors.green.value);
    return Color(palette.primary.get(brightness == Brightness.light ? 90 : 30));
  }

  Color onSuccessContainerColor() {
    final palette = CorePalette.of(Colors.green.value);
    return Color(palette.primary.get(brightness == Brightness.light ? 10 : 90));
  }

  static int harmonize(int designColor, int sourceColor) {
    final fromHct = Hct.fromInt(designColor);
    final toHct = Hct.fromInt(sourceColor);
    final differenceDegrees =
        MathUtils.differenceDegrees(fromHct.hue, toHct.hue);
    final rotationDegrees = min(differenceDegrees * 0.5, 15.0);
    final outputHue = MathUtils.sanitizeDegreesDouble(fromHct.hue +
        rotationDegrees * MathUtils.rotationDirection(fromHct.hue, toHct.hue));
    return Hct.from(outputHue, fromHct.chroma, fromHct.tone).toInt();
  }
}
