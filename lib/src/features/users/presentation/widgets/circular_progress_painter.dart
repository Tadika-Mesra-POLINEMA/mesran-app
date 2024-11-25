import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressPainter extends CustomPainter {
  final int capturedCount;
  final int totalCount;
  final double circleSize;
  final Color activeColor;
  final Color inactiveColor;

  CircularProgressPainter({
    required this.capturedCount,
    required this.totalCount,
    required this.circleSize,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final double radius = circleSize / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double segmentAngle = (2 * pi) / totalCount;

    for (int i = 0; i < totalCount; i++) {
      paint.color = i < capturedCount ? activeColor : inactiveColor;

      final double startAngle = (segmentAngle * i) - pi / 2;
      final double sweepAngle = segmentAngle - 0.05;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
