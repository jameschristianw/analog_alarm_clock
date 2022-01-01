import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:analog_alarm_clock/models/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_title.dart';
import 'clock_face/clock_face.dart';
import 'clock_picker.dart';

class ClockHeader extends StatelessWidget {
  const ClockHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, clock, child) => Column(
        children: [
          const Center(child: AlarmTitle()),
          Row(
            textDirection:
                clock.isClockLeft ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ClockFace(),
              ClockPicker(),
            ],
          ),
        ],
      ),
    );
  }
}
