import 'package:analog_alarm_clock/components/alarm_list/alarm_list.dart';
import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/clock_header/clock_header.dart';
import '../components/clock_header/clock_location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    ClockModel clock = Provider.of<ClockModel>(context, listen: false);
    clock.setAlarmFromJson();
  }

  // void startServiceInPlatform() async {
  //   if (Platform.isAndroid) {
  //     var methodChannel = MethodChannel('com.example');
  //     String data = await methodChannel.invokeMethod('startService');
  //     debugPrint(data);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // startServiceInPlatform();

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
