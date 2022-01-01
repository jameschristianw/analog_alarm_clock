import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:analog_alarm_clock/models/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockLocation extends StatelessWidget {
  const ClockLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Left clock'),
          Consumer<MainProvider>(
            builder: (context, clock, child) => Switch(
              value: clock.isClockLeft,
              onChanged: (newValue) => clock.moveClock(),
              inactiveThumbColor: Colors.amber,
              activeTrackColor: Colors.grey,
            ),
          ),
          const Text('Right clock')
        ],
      ),
    );
  }
}
