import 'dart:async';

enum TimerStatus { initial, starting, pause, stop }

enum TimerType { countdown, normal }

class RocketTimer {
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
    if (status == TimerStatus.initial || status == TimerStatus.pause) {
      status = TimerStatus.starting;
      if (type == TimerType.normal) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          duration++;
          _hours = duration ~/ 3600;
          _minutes = (duration % 3600) ~/ 60;
          _seconds = duration % 60;
        });
      } else if (type == TimerType.countdown) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          duration--;
          _hours = duration ~/ 3600;
          _minutes = (duration % 3600) ~/ 60;
          _seconds = duration % 60;
          if (duration == 0) {
            stop();
          }
        });
      }
    }
  }

  void pause() {
    if (status == TimerStatus.starting) {
      status = TimerStatus.pause;
      _timer.cancel();
    }
  }

  void stop() {
    if (status == TimerStatus.starting || status == TimerStatus.pause) {
      status = TimerStatus.stop;
      _timer.cancel();
    }
  }

  void reset() {
    status = TimerStatus.initial;
    duration = 0;
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    // reset the timer logic here
    _timer.cancel();
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
  }
}
