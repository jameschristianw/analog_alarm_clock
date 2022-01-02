import 'package:analog_alarm_clock/pages/alarm_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      value ?? "Something went wrong with notif",
      key,
    ),
  );
}

void selectNotification(String payload, GlobalKey<NavigatorState> key) async {
  // if (payload != null) {
  debugPrint('notification payload: $payload');
  // FlutterRingtonePlayer.stop();
  // }
  await key.currentState!.push(
    MaterialPageRoute<void>(builder: (context) => AlarmOpen(payload)),
  );
}

void sendNotification() {
  // AssetsAudioPlayer.playAndForget(Audio("assets/audios/notification.mp3"));
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
    0,
    'Alarm Title',
    'Alarm Body',
    platformChannelSpecifics,
  );
}
