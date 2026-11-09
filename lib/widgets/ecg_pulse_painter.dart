import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EcgPulsePainter extends CustomPainter {
  final Color color;

  EcgPulsePainter({this.color = AppColors.primaryLime});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.25)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final h = size.height;
    final w = size.width;

    // Relative points matching ECG pulse:
    // M0 25 L40 25 L55 5 L70 45 L85 15 L95 35 L105 25 L160 25
    path.moveTo(0, h * 0.5);
    path.lineTo(w * 0.25, h * 0.5);
    path.lineTo(w * 0.35, h * 0.1);
    path.lineTo(w * 0.44, h * 0.9);
    path.lineTo(w * 0.53, h * 0.3);
    path.lineTo(w * 0.60, h * 0.7);
    path.lineTo(w * 0.66, h * 0.5);
    path.lineTo(w, h * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
