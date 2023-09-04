import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game/sprite.dart';
import 'package:flutter_game/utils.dart';
import 'package:provider/provider.dart';

class GameLoop extends StatefulWidget {
  const GameLoop({super.key});

  @override
  State<GameLoop> createState() => _GameLoopState();
}

typedef ElapsedTime = Duration;

class _GameLoopState extends State<GameLoop> {
  final _elapsedTime = ValueNotifier<ElapsedTime>(Duration.zero);

  @override
  void initState() {
    super.initState();

    _loop();
  }

  _loop() async {
    const targetFPS = 60;
    final durationPerFrame = 1.seconds ~/ targetFPS;
    print('durationPerFrame: ${durationPerFrame.inMicroseconds} us');

    final watch = Stopwatch()..start();
    Timer.periodic(durationPerFrame, (_) async {
      final elapsed = watch.elapsed;
      watch.reset();

      // Update _elapsedTime value will trigger rebuild for everybody listening
      // to it, which in turn do: 1) update state, and 2) render widget after
      // rebuild.
      _elapsedTime.value = elapsed;

      final sleepDuration = durationPerFrame - elapsed;
      if (sleepDuration.positive) {
        // print('sleep for ${sleepDuration.inMilliseconds} ms');
        await Future.delayed(sleepDuration);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<ElapsedTime>>(
      create: (_) => _elapsedTime,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Sprite(
              key: UniqueKey(),
              images: const [
                'girl-run-1.png',
                'girl-run-2.png',
                'girl-run-3.png',
                'girl-run-4.png',
                'girl-run-5.png',
                'girl-run-6.png',
                'girl-run-7.png',
                'girl-run-8.png',
              ],
              duration: 800.milliseconds,
            ),
          ),
        ),
      ),
    );
  }
}
