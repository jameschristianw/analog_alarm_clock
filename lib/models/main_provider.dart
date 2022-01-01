import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  // Clock location
  bool _isClockLeft = true;

  get isClockLeft => _isClockLeft;

  void moveClock() {
    _isClockLeft = !_isClockLeft;
    notifyListeners();
  }
}
