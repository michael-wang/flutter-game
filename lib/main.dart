import 'package:flutter/material.dart';
import 'package:flutter_game/sprite.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Sprite(
            state2Asset: {
              1: 'girl-run-1.png',
              2: 'girl-run-2.png',
              3: 'girl-run-3.png',
              4: 'girl-run-4.png',
              5: 'girl-run-5.png',
              6: 'girl-run-6.png',
              7: 'girl-run-7.png',
              8: 'girl-run-8.png',
            },
          ),
        ),
      ),
    );
  }
}
