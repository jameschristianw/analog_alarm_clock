import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'clock_painter.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({Key? key}) : super(key: key);

  final double clockSize = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: clockSize,
      width: clockSize,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/clock_face.png'),
          // scale: 1,
        ),
        borderRadius: BorderRadius.circular(125),
        color: Colors.white,
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Consumer<ClockModel>(
          builder: (context, clock, child) => CustomPaint(
            painter: ClockPainter(context, clock.hour, clock.minute),
          ),
        ),
      ),
    );
  }
}
