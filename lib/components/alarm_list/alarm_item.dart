import 'package:analog_alarm_clock/models/alarms_model_provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmItem extends StatelessWidget {
  final AlarmsModel alarm;
  final Function onSwitch;
  const AlarmItem({Key? key, required this.alarm, required this.onSwitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("00", 'en_US');
    final String time =
        '${formatter.format(alarm.hour)}:${formatter.format(alarm.minute)}';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: alarm.isEnabled,
              onChanged: (newValue) {
                onSwitch(alarm.id);
                if (newValue) {
                  AndroidAlarmManager.oneShotAt(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      alarm.hour,
                      alarm.minute,
                      0,
                    ),
                    alarm.id,
                    printTest,
                  );
                } else {
                  AndroidAlarmManager.cancel(alarm.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Alarm for $time is disabled'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

printTest() {
  print('Alarm is triggered asdasd');
}
