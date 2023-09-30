import 'package:flutter_test/flutter_test.dart';
import 'package:rocket_timer/rocket_timer.dart';

void main() {
  group('RocketTimer tests', () {
    test('Test initial values', () {
      RocketTimer timer = RocketTimer(
          duration: const Duration(seconds: 0),
          status: TimerStatus.initial,
          type: TimerType.normal);
      expect(timer.kDuration, 0);
      expect(timer.status, TimerStatus.initial);
      expect(timer.type, TimerType.normal);
      expect(timer.hours, 0);
      expect(timer.minutes, 0);
      expect(timer.seconds, 0);
      expect(timer.formattedDuration, '00:00:00');
    });

    test('Test incrementing timer in normal mode', () {
      RocketTimer timer = RocketTimer(
          duration: const Duration(seconds: 0), type: TimerType.normal);
      timer.start();
      Future.delayed(const Duration(seconds: 10), () {
        timer.pause();
        expect(timer.kDuration, 10);
        expect(timer.hours, 0);
        expect(timer.minutes, 0);
        expect(timer.seconds, 10);
        expect(timer.formattedDuration, '00:00:10');
      });
    });

    test('Test decrementing timer in countdown mode', () {
      RocketTimer timer = RocketTimer(
          duration: const Duration(seconds: 60), type: TimerType.countdown);
      timer.start();
      Future.delayed(const Duration(seconds: 10), () {
        expect(timer.kDuration, 50);
        expect(timer.hours, 0);
        expect(timer.minutes, 0);
        expect(timer.seconds, 50);
        expect(timer.formattedDuration, '00:00:50');
      });
      Future.delayed(const Duration(seconds: 60), () {
        expect(timer.kDuration, 0);
        expect(timer.hours, 0);
        expect(timer.minutes, 0);
        expect(timer.seconds, 0);
        expect(timer.formattedDuration, '00:00:00');
        expect(timer.status, TimerStatus.stop);
      });
    });

    test('Test switching between countdown and normal modes', () {
      RocketTimer timer = RocketTimer(
          duration: const Duration(seconds: 60), type: TimerType.normal);
      expect(timer.type, TimerType.normal);
      expect(timer.kDuration, 60);
      timer.switchMode();
      expect(timer.type, TimerType.countdown);
      expect(timer.kDuration, 60);
      timer.switchMode();
      expect(timer.type, TimerType.normal);
      expect(timer.kDuration, 60);
    });

    test('Test resetting the timer', () {
      RocketTimer timer = RocketTimer(
          duration: const Duration(seconds: 60), type: TimerType.countdown);
      expect(timer.status, TimerStatus.initial);
      expect(timer.kDuration, 60);
      timer.start();
      expect(timer.status, TimerStatus.starting);
      Future.delayed(const Duration(seconds: 10), () {
        timer.reset();
        expect(timer.status, TimerStatus.initial);
        expect(timer.kDuration, 0);
        expect(timer.hours, 0);
        expect(timer.minutes, 0);
        expect(timer.seconds, 0);
        expect(timer.formattedDuration, '00:00:00');
      });
    });
  });
}
