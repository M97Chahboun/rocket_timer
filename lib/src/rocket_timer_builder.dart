import 'package:flutter/widgets.dart';
import 'package:rocket_timer/rocket_timer.dart';

class RocketTimerBuilder extends StatelessWidget {
  final RocketTimer timer;
  final Widget Function(BuildContext) builder;
  const RocketTimerBuilder(
      {super.key, required this.timer, required this.builder});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timer,
      builder: (BuildContext context, Widget? child) {
        return builder(context);
      },
    );
  }
}
