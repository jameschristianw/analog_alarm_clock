import 'dart:convert';

import 'package:analog_alarm_clock/models/alarms_model.dart';
import 'package:analog_alarm_clock/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/alarm.dart';

class ClockModel with ChangeNotifier {
  ClockModel(id, hour, minute) {
    _hour = hour;
    _minute = minute;
  }

  // Clock hour and minute
  late int _year;
  late int _month;
  late int _day;
  late int _hour;
  late int _minute;

  get hour => _hour;
  get minute => _minute;

  setHour(newHour) {
    _hour = newHour;
    setDateAsToday();
    notifyListeners();
  }

  setMinute(newMinute) {
    _minute = newMinute;
    setDateAsToday();
    notifyListeners();
  }

  setDate(year, month, day) {
    _year = year;
    _month = month;
    _day = day;
  }

  setDateAsToday() {
    _year = DateTime.now().year;
    _month = DateTime.now().month;
    _day = DateTime.now().day;
  }

  alarmToString() {
    final formatter = NumberFormat("00", 'en_US');
    return 'Create new alarm for ${formatter.format(_hour)}:${formatter.format(_minute)}';
  }

  // Alarms
  late int _currentId;
  get currentId => _currentId;
  void setCurrentId(id) {
    _currentId = id;
  }

  final List<AlarmsModel> _alarms = [];
  List<AlarmsModel> get alarms => _alarms;
  void addAlarms(context, id) async {
    print('alarm id: $id');
    AlarmsModel newAlarm = AlarmsModel(
      id: id,
      year: _year,
      month: _month,
      day: _day,
      hour: _hour,
      minute: _minute,
      isEnabled: true,
    );
    _alarms.add(newAlarm);
    AlarmHelper.runAlarm(context, _hour, _minute, id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('CURRENT_ID', id);
    prefs.setString('ALARMS', jsonEncode(_alarms));

    notifyListeners();
  }

  void switchAlarm(id) {
    _alarms[_alarms.indexWhere((alarm) => alarm.id == id)].switchAlarm();
    notifyListeners();
  }

  void setAlarmFromJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentId = prefs.getInt('CURRENT_ID') ?? 0;
    String alarms = prefs.getString('ALARMS') ?? '';

    setCurrentId(currentId);

    if (alarms.isNotEmpty) {
      List<dynamic> jsonResult = jsonDecode(alarms);

      for (var result in jsonResult) {
        AlarmsModel newAlarm = AlarmsModel(
          id: result['id'],
          year: result['year'],
          month: result['month'],
          day: result['day'],
          hour: result['hour'],
          minute: result['minute'],
          isEnabled: result['isEnabled'],
        );

        _alarms.add(newAlarm);
      }
    }

    notifyListeners();
  }

  void resetAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ALARMS', '');
    prefs.setInt('CURRENT_ID', 0);
    prefs.setString('CHARTS', '');
    prefs.setInt('CURRENT_CHART_ID', 0);

    for (var a in _alarms) {
      AlarmHelper.cancelAlarm(a.id);
    }

    _currentId = 0;
    _alarms.clear();
    notifyListeners();
  }

  // Charts
  late int _currentChartId;
  get currentChartId => _currentChartId;
  void setCurrentChartId(id) {
    _currentId = id;
  }

  final List<ChartModel> _charts = [];
  List<ChartModel> get charts => _charts;

  late AlarmsModel _selectedAlarm;
  late int _selectedDuration;

  void getSelectedAlarm(id) async {
    // setAlarmFromJson();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentId = prefs.getInt('CURRENT_ID') ?? 0;
    String alarms = prefs.getString('ALARMS') ?? '';

    setCurrentId(currentId);

    if (alarms.isNotEmpty) {
      List<dynamic> jsonResult = jsonDecode(alarms);

      for (var result in jsonResult) {
        AlarmsModel newAlarm = AlarmsModel(
          id: result['id'],
          year: result['year'],
          month: result['month'],
          day: result['day'],
          hour: result['hour'],
          minute: result['minute'],
          isEnabled: result['isEnabled'],
        );

        _alarms.add(newAlarm);
      }
    }
    _selectedAlarm = _alarms[_alarms.indexWhere((alarm) => alarm.id == id)];

    DateTime selectedAlarm = DateTime(
      _selectedAlarm.year,
      _selectedAlarm.month,
      _selectedAlarm.day,
      _selectedAlarm.hour,
      _selectedAlarm.minute,
    );
    DateTime now = DateTime.now();
    Duration duration = now.difference(selectedAlarm);

    print('duration: $duration seconds');

    ChartModel newCharts = ChartModel(
      id: id,
      year: _selectedAlarm.year,
      month: _selectedAlarm.month,
      day: _selectedAlarm.day,
      hour: _selectedAlarm.hour,
      minute: _selectedAlarm.minute,
      duration: duration.inSeconds,
    );
    _charts.add(newCharts);

    prefs.setInt('CURRENT_CHART_ID', id);
    prefs.setString('CHARTS', jsonEncode(_charts));

    notifyListeners();
  }

  void setNewChartData(id, selectedDuration) {
    _selectedAlarm = _alarms[_alarms.indexWhere((alarm) => alarm.id == id)];
    _selectedDuration = selectedDuration;
  }

  void setChartFromJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String alarmJson = prefs.getString('CHARTS') ?? '';

    if (alarmJson.isNotEmpty) {
      List<dynamic> jsonResult = jsonDecode(alarmJson);
      for (var result in jsonResult) {
        ChartModel newChart = ChartModel(
          id: result['id'],
          year: result['year'],
          month: result['month'],
          day: result['day'],
          hour: result['hour'],
          minute: result['minute'],
          duration: result['duration'],
        );

        _charts.add(newChart);
      }
    }

    notifyListeners();
  }

  void addToChart(id, duration, {hour, minute}) async {
    print('chart id: $id');

    ChartModel newCharts = ChartModel(
      id: id,
      hour: _selectedAlarm.hour,
      minute: _selectedAlarm.minute,
      duration: duration,
    );
    _charts.add(newCharts);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('CURRENT_CHART_ID', id);
    prefs.setString('CHARTS', jsonEncode(_charts));

    notifyListeners();
  }
}
