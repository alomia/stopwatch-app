import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  late Timer timer;
  bool _isTicking = false;

  void _onTick(Timer time) {
    if (mounted) {
      setState(() {
        ++seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("StopWatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$seconds ${_secondsText()}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onPressed: _isTicking ? null : _startTimer,
                child: const Text("Start"),
              ),
              const SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onPressed: _isTicking ? _stopTimer : null,
                child: const Text("Stop"),
              )
            ],
          )
        ],
      ),
    );
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);

    setState(() {
      seconds = 0;
      _isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() {
      _isTicking = false;
    });
  }

  String _secondsText() => seconds == 1 ? "Second" : "Seconds";

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
