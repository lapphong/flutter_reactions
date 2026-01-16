import 'package:flutter/material.dart';

abstract class AnimationControllerState<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final controller = AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

enum Direction { left, right, top, bottom }

extension DirectionExt on Direction {
  (Offset, Offset) toOffsets() {
    var begin = Offset.zero;
    const end = Offset.zero;

    switch (this) {
      case Direction.left:
        begin = const Offset(-1, 0);
        break;
      case Direction.right:
        begin = const Offset(1, 0);
        break;
      case Direction.top:
        begin = const Offset(0, -1);
        break;
      case Direction.bottom:
        begin = const Offset(0, 1);
        break;
    }
    return (begin, end);
  }
}
