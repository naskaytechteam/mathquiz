import 'package:flutter/material.dart';

class RippleEffectPainter extends CustomPainter{
  final double radius;
  const RippleEffectPainter(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint();
    paint.color=Colors.white70.withOpacity(0.1);
    Offset center=Offset(size.width/2, size.height/2);
    canvas.drawCircle(center, radius, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}