import 'dart:convert';

import 'package:analog_alarm_clock/models/alarms_model_provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockModel with ChangeNotifier {
  ClockModel(id, hour, minute) {
    _hour = hour;
    _minute = minute;
  }

  // Clock hour and minute
  late int _hour;
  late int _minute;

  get hour => _hour;
  get minute => _minute;

  setHour(newHour) {
    _hour = newHour;
    notifyListeners();
  }

  setMinute(newMinute) {
    _minute = newMinute;
    notifyListeners();
  }

  alarmToString() {
    final formatter = NumberFormat("00", 'en_US');
    return 'Create new alarm for ${formatter.format(_hour)}:${formatter.format(_minute)}';
  }

  // Alarm things
  late int _currentId;
  get currentId => _currentId;
  void setCurrentId(id) {
    _currentId = id;
  }

  final List<AlarmsModel> _alarms = [];
  List<AlarmsModel> get alarms => _alarms;
  void addAlarms(id) async {
    AlarmsModel newAlarm = AlarmsModel(
      id: id,
      hour: _hour,
      minute: _minute,
      isEnabled: true,
    );
    _alarms.add(newAlarm);
    runAlarm(id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('CURRENT_ID', id);
    prefs.setString('ALARMS', jsonEncode(_alarms));

    notifyListeners();
  }

  runAlarm(id) async {
    print('runAlarm');
    await AndroidAlarmManager.oneShotAt(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _hour,
        _minute,
      ),
      id,
      printTest,
    );
  }

  void switchAlarm(id) {
    _alarms[_alarms.indexWhere((alarm) => alarm.id == id)].switchAlarm();
    notifyListeners();
  }

  void setAlarmFromJson(alarmJson) {
    List<dynamic> jsonResult = jsonDecode(alarmJson);

    for (var result in jsonResult) {
      AlarmsModel newAlarm = AlarmsModel(
        id: result['id'],
        hour: result['hour'],
        minute: result['minute'],
        isEnabled: result['isEnabled'],
      );

      _alarms.add(newAlarm);
    }

    notifyListeners();
  }

  void resetAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ALARMS', '');
    prefs.setInt('CURRENT_ID', 0);

    _currentId = 0;
    _alarms.clear();
    notifyListeners();
  }
}

printTest() {
  print('Alarm is triggered');
}
