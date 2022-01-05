import 'package:analog_alarm_clock/components/alarm_chart/chart_item.dart';
import 'package:analog_alarm_clock/models/chart_model.dart';
import 'package:flutter/material.dart';

class ChartList extends StatefulWidget {
  final List<ChartModel> charts;

  const ChartList({required this.charts, Key? key}) : super(key: key);

  @override
  State<ChartList> createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  late MediaQueryData query;
  late double height;
  late double width;
  late double chartHeight;
  int longestDuration = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    query = MediaQuery.of(context);
    height = query.size.height;
    width = query.size.width;
  }

  void getLongestDuration() {
    // Only taking the last 7 item
    for (var chart in widget.charts) {
      if (chart.duration > longestDuration) {
        longestDuration = chart.duration;
      }
    }

    setState(() {
      longestDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    getLongestDuration();
    chartHeight = height * 0.6;
    return Container(
      margin: EdgeInsets.only(top: width * 0.05),
      // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      height: chartHeight,
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(longestDuration.toString()), const Text('0')],
                ),
              ),
              Container(
                width: 1,
                // margin: const EdgeInsets.only(right: 6),
                color: Colors.black,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...widget.charts.reversed
                      .map(
                        (chart) => ChartItem(
                          itemWidth: width * 0.35,
                          itemHeight: (chart.duration) /
                              longestDuration *
                              chartHeight *
                              0.99,
                          year: chart.year,
                          month: chart.month,
                          day: chart.day,
                          hour: chart.hour,
                          minute: chart.minute,
                          duration: chart.duration,
                        ),
                      )
                      .toList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
