import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartItem extends StatelessWidget {
  final double itemHeight, itemWidth;
  final int hour, minute, duration;
  final int year, month, day;
  const ChartItem({
    Key? key,
    required this.itemHeight,
    required this.itemWidth,
    required this.hour,
    required this.year,
    required this.month,
    required this.day,
    required this.minute,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('00');

    return Container(
      width: itemWidth,
      padding: EdgeInsets.only(left: itemWidth * 0.25),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: itemWidth * 0.75,
                height: itemHeight,
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '$duration seconds\n',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '${formatter.format(day)}/${formatter.format(month)}/$year',
                    ),
                    Text(
                      '${formatter.format(hour)}:${formatter.format(minute)}',
                    ),
                  ],
                ),
              ),
              // Text('$hour:$minute')
            ],
          ),
        ],
      ),
    );
  }
}
