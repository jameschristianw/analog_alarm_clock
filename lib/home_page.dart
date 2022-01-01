import 'package:analog_alarm_clock/components/alarm_list/alarm_list.dart';
import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:analog_alarm_clock/models/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/clock_header/clock_header.dart';
import 'components/clock_header/clock_location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initializeData(context);
  }

  void _initializeData(context) async {
    _prefs = await SharedPreferences.getInstance();
    int currentId = _prefs.getInt('CURRENT_ID') ?? 0;
    String alarms = _prefs.getString('ALARMS') ?? '';

    ClockModel clock = Provider.of<ClockModel>(context, listen: false);
    clock.setCurrentId(currentId);

    // MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    // provider.setCurrentId(currentId);

    if (alarms.isNotEmpty) {
      clock.setAlarmFromJson(alarms);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analog Alarm App'),
        actions: [
          Consumer<ClockModel>(
            builder: (context, clock, child) => TextButton(
              onPressed: () async {
                clock.resetAlarms();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Alarms has been reset'),
                  ),
                );
              },
              child: const Text(
                'Reset Alarms',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        height: double.infinity,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ClockHeader(),
                ClockLocation(),
                AlarmList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
