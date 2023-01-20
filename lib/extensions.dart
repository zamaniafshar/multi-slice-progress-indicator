import 'dart:math' as math;
import 'package:flutter/material.dart';

extension MathHelpers on num {
  double get toRad => this * (math.pi / 180.0);
}

extension SizeHelpers on Size {
  Offset get centerOffset => Offset(width / 2, height / 2);

  Rect get centerRect => Rect.fromCenter(center: centerOffset, width: width, height: height);

  Shader makeShader(List<Color> colors, double deg) {
    return SweepGradient(
      colors: colors,
      transform: GradientRotation(deg.toRad),
    ).createShader(centerRect);
  }
}
