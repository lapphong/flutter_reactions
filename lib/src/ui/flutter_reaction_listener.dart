import 'package:flutter/material.dart';

import '../core/core.dart';
import 'flutter_reaction_builder.dart';

class FlutterReactionListener extends StatefulWidget {
  final GlobalKey targetKey;
  final ValueChanged<FlutterReactionType?> onChanged;

  const FlutterReactionListener({
    super.key,
    required this.targetKey,
    required this.onChanged,
  });

  @override
  State<FlutterReactionListener> createState() => _FlutterReactionListenerState();
}

class _FlutterReactionListenerState extends State<FlutterReactionListener> with FlutterReactionMixin {
  @override
  Rect get widgetRect => widget.targetKey.currentContext!.getRenderObjectInfo.$1;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: (event) => onPointerUp(event, onChanged: widget.onChanged),
      onPointerHover: (event) => onPointerHover(event, isOpen: false),
      child: const SizedBox.expand(),
    );
  }

  // DEBUG
  // Rect? _boxRect;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!mounted) return;
  //     setState(() {
  //       _boxRect = boxKey.currentContext?.getRenderObjectInfo.$1;
  //     });
  //   });
  // }

  // DEBUG
  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: [
  //       Listener(
  //         behavior: HitTestBehavior.translucent,
  //         onPointerDown: onPointerDown,
  //         onPointerMove: onPointerMove,
  //         onPointerUp: (event) => onPointerUp(event, onChanged: widget.onChanged),
  //         onPointerHover: (event) => onPointerHover(event, isOpen: false),
  //         child: const SizedBox.expand(),
  //       ),
  //       if (_boxRect != null) ReactionDragAreaDebug(boxRect: _boxRect!),
  //     ],
  //   );
  // }
}

class ReactionDragAreaDebug extends StatelessWidget {
  final Rect boxRect;

  const ReactionDragAreaDebug({super.key, required this.boxRect});

  @override
  Widget build(BuildContext context) {
    final extendAbove = boxRect.height * 2.0;
    final extendBelow = boxRect.height * 2.5;
    final top = boxRect.top - extendAbove;
    final height = boxRect.height + extendAbove + extendBelow;

    return Positioned(
      left: boxRect.left,
      top: top,
      width: boxRect.width,
      height: height,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}
