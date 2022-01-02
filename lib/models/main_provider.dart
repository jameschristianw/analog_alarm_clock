import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainProvider with ChangeNotifier {
  // Clock location
  bool _isClockLeft = true;

  get isClockLeft => _isClockLeft;

  void moveClock() {
    _isClockLeft = !_isClockLeft;
    notifyListeners();
  }

  // // Notification
  // late FlutterLocalNotificationsPlugin _plugin;

  // MainProvider(plugin) {
  //   _plugin = plugin;
  // }

  // FlutterLocalNotificationsPlugin get plugin => _plugin;
}
