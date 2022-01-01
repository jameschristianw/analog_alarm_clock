import 'package:analog_alarm_clock/models/alarms_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'models/clock_model_provider.dart';

import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'models/main_provider.dart';

void main() async {
  runApp(const MyApp());

  await AndroidAlarmManager.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analog Alarm App',
      themeMode: ThemeMode.light,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ClockModel(
              0,
              DateTime.now().hour,
              DateTime.now().minute,
            ),
          ),
          ChangeNotifierProvider(create: (context) => MainProvider()),
          ChangeNotifierProvider(create: (context) => AlarmsModel())
        ],
        child: const Home(),
      ),
    );
  }
}
