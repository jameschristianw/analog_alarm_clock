import 'package:flutter/material.dart';

class AlarmsModel with ChangeNotifier {
  late int _id, _hour, _minute;
  late bool _isEnabled;

  AlarmsModel({
    id = 0,
    hour = 0,
    minute = 0,
    isEnabled = 0,
  }) {
    _id = id;
    _hour = hour;
    _minute = minute;
    _isEnabled = isEnabled;
  }

  get id => _id;
  get hour => _hour;
  get minute => _minute;
  get isEnabled => _isEnabled;

  void setId(id) {
    _id = id;
  }

  void setHour(hour) {
    _hour = hour;
  }

  void setMinute(minute) {
    _minute = minute;
  }

  void switchAlarm() {
    _isEnabled = !_isEnabled;
    // notifyListeners();
  }
}
