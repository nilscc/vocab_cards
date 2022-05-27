import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color? color;
  final bool left;

  TrianglePainter({
    this.color,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = (color ?? Colors.grey).withAlpha(150)
      ..strokeWidth = 2.0;
    Path path = Path();

    if (left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
