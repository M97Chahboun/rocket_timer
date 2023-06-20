import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocket_timer/rocket_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rocket Timer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  RocketTimer? _timer;
  late TextEditingController _durationController;
  bool _isCountdown = false;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController();
    _timer = RocketTimer(
        duration: 0,
        type: _isCountdown ? TimerType.countdown : TimerType.normal);
  }

  @override
  void dispose() {
    _durationController.dispose();
    _timer!.dispose();
    super.dispose();
  }

  void _startTimer() {
    int duration = int.tryParse(_durationController.text) ?? 0;
    setState(() {
      if (_timer!.status == TimerStatus.initial) {
        _timer!.duration = duration;
      }
      _timer!.start();
    });
  }

  void _pauseTimer() {
    _timer?.pause();
    setState(() {});
  }

  void _stopTimer() {
    _timer?.stop();
    setState(() {});
  }

  void _resetTimer() {
    _timer?.reset();
    _durationController.text = '';
  }

  void _switchTimerType(bool value) {
    _timer?.switchMode();
    setState(() {
      _isCountdown = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Countdown mode'),
                Switch(
                  value: _isCountdown,
                  onChanged: _switchTimerType,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: 'Duration (in seconds)',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 20),
            if (_timer != null)
              RocketTimerBuilder(
                  timer: _timer!,
                  builder: (context) {
                    return Text(
                      _timer!.formattedDuration,
                      style: Theme.of(context).textTheme.displayLarge,
                    );
                  }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _pauseTimer,
                  child: const Text('Pause'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
