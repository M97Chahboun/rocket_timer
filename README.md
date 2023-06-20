# Rocket Timer

The rocket_timer package provides a RocketTimer class for implementing countdown or normal timers in Flutter applications, as well as a RocketTimerBuilder widget for building widgets that respond to changes in a RocketTimer object. It supports starting, pausing, stopping, resetting, and switching between countdown and normal modes, and is easy to use and customize.

## Usage

To use the `RocketTimer` class, simply create a new instance of it and call its methods to control the timer:

```dart
import 'package:rocket_timer/rocket_timer.dart';

final RocketTimer timer = RocketTimer(duration: 60, type: TimerType.countdown);

// Start the timer
timer.start();

// Pause the timer
timer.pause();

// Stop the timer
timer.stop();

// Reset the timer
timer.reset();

// Switch between countdown and normal modes
timer.switchMode();
```

To display the timer in a widget, you can use the `RocketTimerBuilder` widget which listens to changes in a `RocketTimer` object and rebuilds the widget tree accordingly:

```dart
import 'package:flutter/material.dart';
import 'package:rocket_timer/rocket_timer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RocketTimer _rocketTimer = RocketTimer(duration: 60, type: TimerType.countdown);

  @override
  void dispose() {
    _rocketTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RocketTimerBuilder(
          timer: _rocketTimer,
          builder: (BuildContext context) {
            return Text(
              _rocketTimer.formattedDuration,
              style: Theme.of(context).textTheme.headline1,
            );
          },
        ),
      ),
    );
  }
}
```

## API Reference

See the full API reference for the `RocketTimer` class and the `RocketTimerBuilder` widget in the `rocket_timer` [package](https://pub.dev/packages/flutter_rocket) documentation.