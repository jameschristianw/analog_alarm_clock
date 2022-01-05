import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:analog_alarm_clock/pages/alarm_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initNotifications(GlobalKey<NavigatorState> key) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  // final IOSInitializationSettings initializationSettingsIOS =
  // IOSInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (value) => selectNotification(
      value ?? "-----",
      key,
    ),
  );
}

void selectNotification(String payload, GlobalKey<NavigatorState> key) async {
  debugPrint('notification payload: $payload');
  await key.currentState!.push(
    MaterialPageRoute<void>(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ClockModel(
          0,
          DateTime.now().hour,
          DateTime.now().minute,
        ),
        child: AlarmOpen(payload),
      ),
    ),
  );
}

void sendNotification(alarmId) {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'ANALOG_ALARM_CLOCK',
    'Analog Alarm Clock Chanel Name',
    channelDescription: 'Analog Alarm Clock Descriptop',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    // playSound: false,
    sound: RawResourceAndroidNotificationSound('notification'),
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.show(
    alarmId,
    'Analog Alarm App',
    'Your alarm at ${DateTime.now().hour}:${DateTime.now().minute} is up!',
    platformChannelSpecifics,
    payload: alarmId.toString(),
  );
}
