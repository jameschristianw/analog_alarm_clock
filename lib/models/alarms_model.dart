import 'package:flutter/material.dart';

class AlarmsModel with ChangeNotifier {
  late int _id, _year, _month, _day, _hour, _minute;
  late bool _isEnabled;

  AlarmsModel({
    required id,
    required year,
    required month,
    required day,
    required hour,
    required minute,
    required isEnabled,
  }) {
    _id = id;
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _isEnabled = isEnabled;
  }

  get id => _id;
  get year => _year;
  get month => _month;
  get day => _day;
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

  Map toJson() => {
        'id': _id,
        'year': _year,
        'month': _month,
        'day': _day,
        'hour': _hour,
        'minute': _minute,
        'isEnabled': _isEnabled,
      };
}
