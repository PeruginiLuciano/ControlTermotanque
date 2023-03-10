import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  num value;
  bool isTemp;

  CircleProgress(this.value, this.isTemp);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue = isTemp ? 110 : 100;
    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    Paint tempArc = Paint()
      ..strokeWidth = 14
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Paint maxArc = Paint()
      ..strokeWidth = 14
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Paint promArc = Paint()
      ..strokeWidth = 14
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);
    double angle = 2 * pi * (value / maximumValue);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, isTemp ? tempArc : maxArc);
  }

  bool fondo() {
    if (value > 70) {
      return true;
    } else {
      return false;
    }
  }
}
