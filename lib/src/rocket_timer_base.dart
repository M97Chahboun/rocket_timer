import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rocket_timer/src/extensions.dart';

enum TimerStatus { initial, starting, pause, stop }

enum TimerType { countdown, normal }

/// A timer class that can be used to implement a countdown or a normal timer.
/// It supports starting, pausing, stopping, resetting, and switching between countdown and normal modes.
class RocketTimer extends ChangeNotifier {
  int duration;
  TimerStatus status;
  TimerType type;
  late Timer _timer;
  late int _hours;
  late int _minutes;
  late int _seconds;

  /// Creates a new [RocketTimer] object with the given [duration], [status], and [type].
  ///
  /// The [duration] is the initial duration of the timer in seconds.
  /// The [status] is the initial status of the timer.
  /// The [type] is the initial type of the timer.
  RocketTimer({
    this.duration = 0,
    this.status = TimerStatus.initial,
    this.type = TimerType.normal,
  }) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
    handleTimer();
  }

  /// Gets the number of hours in the timer's duration.
  int get hours => _hours;

  /// Gets the number of minutes in the timer's duration.
  int get minutes => _minutes;

  /// Gets the number of seconds in the timer's duration.
  int get seconds => _seconds;

  /// Gets the formatted duration of the timer in the format "HH:MM:SS".
  String get formattedDuration =>
      '${_hours.formatTime}:${_minutes.formatTime}:${_seconds.formatTime}';

  /// Starts the timer.
  ///
  /// If the timer is in the initial or pause state, it will start counting up or down based on the timer type.
  /// If the timer is already running, this method has no effect.
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

  /// Handles the timer logic by updating the `_hours`, `_minutes`, and `_seconds` properties based on the current `duration` and notifying any listeners of the changes.
  void handleTimer() {
    _hours = duration.hours;
    _minutes = duration.minutes;
    _seconds = duration.seconds;
    notifyListeners();
  }

  /// Pauses the timer.
  ///
  /// If the timer is currently running, it will pause counting up or down.
  /// If the timer is not running, this method has no effect.
  void pause() {
    if (status == TimerStatus.starting) {
      status = TimerStatus.pause;
      _timer.cancel();
      notifyListeners();
    }
  }

  /// Stops the timer.
  ///
  /// If the timer is currently running or paused, it will be stopped and reset to 0.
  /// If the timer is already stopped, this method has no effect.
  void stop() {
    if (status == TimerStatus.starting || status == TimerStatus.pause) {
      status = TimerStatus.stop;
      _timer.cancel();
      notifyListeners();
    }
  }

  /// Resets the timer to its initial state with a duration of 0.
  ///
  /// If the timer is currently running or paused, it will be stopped and reset to 0.
  /// If the timer is already in its initial state, this method has no effect.
  void reset() {
    status = TimerStatus.initial;
    duration = 0;
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _timer.cancel();
    notifyListeners();
  }

  /// Switches the timer between countdown and normal modes.
  ///
  /// If the timer is currently in normal mode, it will switch to countdown mode and vice versa.
  /// This method also pauses the timer.
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

  /// Disposes of the timer object.
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
