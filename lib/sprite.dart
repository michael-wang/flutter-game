import 'package:flutter/widgets.dart';
import 'package:flutter_game/game_loop.dart';
import 'package:flutter_game/utils.dart';
import 'package:provider/provider.dart';

class Sprite extends StatefulWidget {
  static const assetPrefix = 'assets/images/';
  // Image asset names
  final List<String> images;
  // how long does it take to finish one round of images.
  final Duration duration;

  const Sprite({
    super.key,
    required this.images,
    required this.duration,
  });

  @override
  State<Sprite> createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  late Duration _frameDuration;
  var _elapsed = Duration.zero;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _frameDuration = widget.duration ~/ widget.images.length;
  }

  @override
  Widget build(BuildContext context) {
    final delta = context.watch<ValueNotifier<ElapsedTime>>().value;
    _elapsed += delta;
    print(
        'sprite elapsed: ${delta.inMicroseconds} us, frame elapsed: ${_elapsed.inMicroseconds} use, duration per frame: ${_frameDuration.inMicroseconds} us');

    switch (_elapsed.compareTo(_frameDuration)) {
      case < 0: // No change (elapsed time < target frame elapsed time).
        break;
      case >= 0:
        final indexOffset = (_elapsed / _frameDuration).round();
        int newIndex = _index + indexOffset;
        newIndex %= widget.images.length;
        print(
            'elapsed: $delta, indexOffset: $indexOffset, oldIndex: $_index, newIndex: $newIndex');
        _index = newIndex;
        _elapsed = Duration.zero;
    }

    final asset = widget.images[_index];
    return Image.asset(Sprite.assetPrefix + asset);
  }
}
