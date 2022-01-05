import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import './notification.dart' as notification;

class AlarmHelper {
  static runAlarm(context, hour, minute, id, {time}) async {
    await AndroidAlarmManager.oneShotAt(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minute,
        0,
      ),
      id,
      showAlarm,
      alarmClock: true,
    );

    // AndroidAlarmManager.periodic(const Duration(seconds: 5), id, showAlarm());
    if (time != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alarm for $time is enabled'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New alarm has been created'),
        ),
      );
    }
  }

  static cancelAlarm(id, {time, context}) {
    AndroidAlarmManager.cancel(id);
    if (time != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alarm for $time is disabled'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  static void showAlarm(alarmId) async {
    print('showAlarm function: $alarmId');
    // AudioPlayer player = AudioPlayer();

    // int result = await player.play(
    //   'notification.mp3',
    //   isLocal: true,
    // );

    // final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
    // await audioPlayer.open(Audio('assets/audios/notification.mp3'));
    // await audioPlayer.play();
    // await audioPlayer.stop();
    // await audioPlayer.dispose();

    // AssetsAudioPlayer.playAndForget(Audio("assets/audios/notification.mp3"));

    // FlutterRingtonePlayer.play(
    //   android: AndroidSounds.alarm,
    //   ios: IosSounds.glass,
    //   looping: true, // Android only - API >= 28
    //   volume: 1, // Android only - API >= 28
    //   asAlarm: true, // Android only - all APIs
    // );

    notification.sendNotification(alarmId);
  }
}
