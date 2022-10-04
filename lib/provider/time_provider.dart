import 'dart:async';
import 'package:flutter/material.dart';

extension TimeDuration on Duration {
  String getTime() {
    int sec = inSeconds - inMinutes * 60;
    return '$inMinutes:$sec';
  }
}

class TimeProvider extends ChangeNotifier {
  Duration duration = const Duration(minutes: 1);
  late Timer timer;

  TimeProvider(){
    updateTime();
  }

  void updateTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      decreaseOneSecond();
    });
  }

  void decreaseOneSecond() {
    if (duration.inSeconds > 0) {
      int sec = duration.inSeconds-1;
      duration = Duration(seconds: sec);
      notifyListeners();
      return;
    }
    timer.cancel();
  }
}
