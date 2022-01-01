import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  // final DateTime dateTime;
  final BuildContext context;
  final int hour, minute;
  ClockPainter(this.context, this.hour, this.minute);

  DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

    var hourX = centerX + 60 * cos((hour * 30) * pi / 180);
    var hourY = centerY + 60 * sin((hour * 30) * pi / 180);

    var hourBrush = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    // Hour Line
    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      hourBrush,
    );

    var minuteX = centerX + 80 * cos(minute * 6 * pi / 180);
    var minuteY = centerY + 80 * sin(minute * 6 * pi / 180);

    var minuteBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    // Minute Line
    canvas.drawLine(
      center,
      Offset(minuteX, minuteY),
      minuteBrush,
    );

    var centerCircle = Paint()..color = Colors.amber;
    canvas.drawCircle(center, 8, centerCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
