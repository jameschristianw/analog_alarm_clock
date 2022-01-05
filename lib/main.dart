import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'models/clock_model_provider.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'models/main_provider.dart';

import '../helper/notification.dart' as notification;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    notification.initNotifications(_key);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // notification.initNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _key,
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
        ],
        child: const Home(),
      ),
    );
  }
}
