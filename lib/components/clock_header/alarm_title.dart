import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmTitle extends StatelessWidget {
  const AlarmTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockModel>(
      builder: (context, clock, child) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          clock.alarmToString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
