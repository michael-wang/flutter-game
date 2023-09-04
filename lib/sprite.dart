import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_game/utils.dart';

class Sprite extends StatefulWidget {
  static const assetPrefix = 'assets/images/';
  // Mapping from int state to asset name (without assetPrefix).
  final Map<int, String> state2Asset;

  const Sprite({super.key, required this.state2Asset});

  @override
  State<Sprite> createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  int _state = 0;

  @override
  void initState() {
    super.initState();
    _loop();
  }

  _loop() {
    final totalDuration = 1500.ms;
    final totalImages = widget.state2Asset.keys.length;
    Timer.periodic(totalDuration ~/ totalImages, (_) {
      setState(() {
        _state = (_state + 1) % totalImages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // For now we just map _state of value: [0 - #assets-1) into key.
    final key = widget.state2Asset.keys.toList()[_state];
    final asset = widget.state2Asset[key];
    if (asset == null) {
      return const Placeholder();
    }
    return Image.asset(Sprite.assetPrefix + asset);
  }
}
