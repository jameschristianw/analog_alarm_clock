import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  // Clock location
  bool _isClockLeft = true;

  get isClockLeft => _isClockLeft;

  void moveClock() {
    _isClockLeft = !_isClockLeft;
    notifyListeners();
  }

  // Alarms
  late int _currentId;
  get currentId => _currentId;
  void setCurrentId(id) {
    _currentId = id;
  }
}
