import 'package:analog_alarm_clock/components/alarm_list/alarm_item.dart';
import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmList extends StatefulWidget {
  const AlarmList({Key? key}) : super(key: key);

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    ClockModel clock = Provider.of<ClockModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('Alarm List'),
          ),
          if (clock.alarms.isNotEmpty)
            ...clock.alarms.map(
              (alarm) => AlarmItem(
                alarm: alarm,
                onSwitch: (id) => clock.switchAlarm(id),
              ),
            ),
          if (clock.alarms.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(child: Text('No Alarm Data')),
            )
        ],
      ),
    );
  }
}
