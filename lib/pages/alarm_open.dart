import 'package:analog_alarm_clock/components/alarm_chart/chart_list.dart';
import 'package:analog_alarm_clock/models/clock_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmOpen extends StatefulWidget {
  final String alarmId;
  const AlarmOpen(this.alarmId, {Key? key}) : super(key: key);

  @override
  State<AlarmOpen> createState() => _AlarmOpenState();
}

class _AlarmOpenState extends State<AlarmOpen> {
  late int _id;
  late ClockModel clock;
  late int _duration;

  @override
  void initState() {
    super.initState();

    _id = int.parse(widget.alarmId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    clock = Provider.of<ClockModel>(context, listen: false);
    clock.setChartFromJson();
    clock.getSelectedAlarm(_id);

    // clock.setNewChartData(_id, subtraction.inSeconds);
  }

  // void addToChart() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String chartData = prefs.getString('CHARTS') ?? '';

  //   clock.addToChart(id, duration);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Stat'),
      ),
      body: Consumer<ClockModel>(
        builder: (context, chart, child) => ChartList(charts: chart.charts),
      ),
    );
  }
}
