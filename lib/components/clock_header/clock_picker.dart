import 'package:analog_alarm_clock/models/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../models/clock_model_provider.dart';

class ClockPicker extends StatelessWidget {
  const ClockPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClockModel clock = Provider.of<ClockModel>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text('Hour'),
                NumberPicker(
                  value: clock.hour,
                  itemWidth: 50,
                  maxValue: 23,
                  itemHeight: 30,
                  minValue: 0,
                  onChanged: (newHour) => clock.setHour(newHour),
                  infiniteLoop: true,
                ),
              ],
            ),
            const Text(':'),
            Column(
              children: [
                const Text('Minute'),
                NumberPicker(
                  value: clock.minute,
                  itemWidth: 50,
                  maxValue: 59,
                  minValue: 0,
                  itemHeight: 30,
                  onChanged: (newMinute) => clock.setMinute(newMinute),
                  infiniteLoop: true,
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            clock.addAlarms(clock.currentId);
            clock.setCurrentId(clock.currentId + 1);
          },
          child: const Text('Save Alarm'),
        ),
      ],
    );
  }
}
