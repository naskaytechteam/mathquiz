import 'dart:async';
import 'package:flutter/material.dart';

extension TimeDuration on Duration {
  String changeTimeintoString() {//could be change
    int sec = inSeconds - inMinutes * 60;
    return '$inMinutes:$sec';
  }
}

class TimeProvider extends ChangeNotifier {
  Duration duration = const Duration(minutes: 1);
  Timer? timer;
  bool isTimeFinished=false;


  void startTime() {
    if(timer!=null){
      timer!.cancel();
      duration=const Duration(minutes: 1);
      isTimeFinished=false;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decreaseOneSecond();
    });
  }

  void _decreaseOneSecond() {
    if (duration.inSeconds > 0) {
      int sec = duration.inSeconds-1;
      duration = Duration(seconds: sec);
      notifyListeners();
      return;
    }
    disposeTime();
    notifyListeners();
  }
  void disposeTime(){
    isTimeFinished=true;
    duration=const Duration(minutes: 1);
    timer!.cancel();
  }
}
