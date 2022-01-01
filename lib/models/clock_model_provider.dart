import 'package:analog_alarm_clock/models/alarms_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockModel with ChangeNotifier {
  ClockModel(id, hour, minute) {
    _hour = hour;
    _minute = minute;
  }

  late int _nextId;
  get nextId => _nextId;
  void setNextId(id) {
    _nextId = id;
  }

  // Alarm things
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('CURRENT_ID', id);

    notifyListeners();
  }

  void switchAlarm(id) {
    _alarms[_alarms.indexWhere((alarm) => alarm.id == id)].switchAlarm();
    notifyListeners();
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
}
