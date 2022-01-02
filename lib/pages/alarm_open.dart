import 'package:flutter/material.dart';

class AlarmOpen extends StatelessWidget {
  final String payload;
  const AlarmOpen(this.payload, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Stat'),
      ),
      body: Center(
        child: Text(payload),
      ),
    );
  }
}
