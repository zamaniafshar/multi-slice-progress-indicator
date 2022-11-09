import 'package:flutter/material.dart';
import 'package:multi_slice_progress_indicator/extensions.dart';

class SliceProgressIndicatorPainter extends CustomPainter {
  SliceProgressIndicatorPainter({
    required this.shaderDeg,
    required this.colors,
    required this.radius,
  });
  final double radius;
  final double shaderDeg;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = size.makeShader(colors, shaderDeg)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(SliceProgressIndicatorPainter oldDelegate) {
    return shaderDeg != oldDelegate.shaderDeg ||
        oldDelegate.colors != colors ||
        oldDelegate.radius != radius;
  }
}
