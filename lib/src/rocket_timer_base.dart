import 'dart:async';

import 'package:flutter/foundation.dart';

enum TimerStatus { initial, starting, pause, stop }

enum TimerType { countdown, normal }

class RocketTimer extends ChangeNotifier {
  int duration;
  TimerStatus status;
  TimerType type;
  late Timer _timer;
  late int _hours;
  late int _minutes;
  late int _seconds;

  RocketTimer(
      {this.duration = 0,
      this.status = TimerStatus.initial,
      this.type = TimerType.normal}) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
    _hours = duration ~/ 3600;
    _minutes = (duration % 3600) ~/ 60;
    _seconds = duration % 60;
  }

  int get hours => _hours;

  int get minutes => _minutes;

  int get seconds => _seconds;

  String get formattedDuration =>
      '${_formatTime(_hours)}:${_formatTime(_minutes)}:${_formatTime(_seconds)}';

  String _formatTime(int time) => time < 10 ? '0$time' : '$time';

  void start() {
    _timer.cancel();
    if (status == TimerStatus.initial || status == TimerStatus.pause) {
      status = TimerStatus.starting;
      handleTimer();
      if (type == TimerType.normal) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          duration++;
          handleTimer();
        });
      } else if (type == TimerType.countdown) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (duration == 0) {
            stop();
          } else {
            duration--;
            handleTimer();
          }
        });
      }
    }
  }

  void handleTimer() {
    _hours = duration ~/ 3600;
    _minutes = (duration % 3600) ~/ 60;
    _seconds = duration % 60;
    notifyListeners();
  }

  void pause() {
    if (status == TimerStatus.starting) {
      status = TimerStatus.pause;
      _timer.cancel();
      notifyListeners();
    }
  }

  void stop() {
    if (status == TimerStatus.starting || status == TimerStatus.pause) {
      status = TimerStatus.stop;
      _timer.cancel();
      notifyListeners();
    }
  }

  void reset() {
    status = TimerStatus.initial;
    duration = 0;
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _timer.cancel();
    notifyListeners();
  }

  // method to switch between countdown and normal modes
  void switchMode() {
    if (type == TimerType.normal) {
      type = TimerType.countdown;
      duration = _hours * 3600 + _minutes * 60 + _seconds;
    } else {
      type = TimerType.normal;
      duration = _hours * 3600 + _minutes * 60 + _seconds;
    }
    pause();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
