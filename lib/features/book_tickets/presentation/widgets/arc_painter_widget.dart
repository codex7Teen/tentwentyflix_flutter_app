import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

//! WIDGET TO BUILD AN ARC IN SEATS GRID VIEW
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color =
              AppColors
                  .blueThemeColor // Match with theme
          ..strokeWidth = 0.4
          ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height,
    ); // Arc shape

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
