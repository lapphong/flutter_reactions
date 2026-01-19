import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import 'flutter_reaction_builder.dart';
import 'flutter_reaction_overlay.dart';

class FlutterReactionListener extends StatefulWidget {
  final bool? debug;
  final GlobalKey targetKey;
  final ValueChanged<FlutterReactionType?> onChanged;

  const FlutterReactionListener({
    super.key,
    this.debug,
    required this.targetKey,
    required this.onChanged,
  });

  @override
  State<FlutterReactionListener> createState() => _FlutterReactionListenerState();
}

class _FlutterReactionListenerState extends State<FlutterReactionListener> with FlutterReactionMixin {
  @override
  Rect get widgetRect => widget.targetKey.currentContext!.getRenderObjectInfo.$1;

  // DEBUG
  Rect? _boxRect;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _boxRect = boxKey.currentContext?.getRenderObjectInfo.$1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgetDebug(
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: onPointerDown,
        onPointerMove: onPointerMove,
        onPointerUp: (event) => onPointerUp(event, onChanged: widget.onChanged),
        onPointerHover: (event) => onPointerHover(event, isOpen: false),
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _buildWidgetDebug({required Widget child}) {
    return Stack(
      children: [
        child,
        if (_boxRect != null && widget.debug == kDebugMode && AppConstants.isMobile)
          _ReactionDragAreaDebug(boxRect: _boxRect!), // coverage:ignore-line
      ],
    );
  }
}

// coverage:ignore-start
class _ReactionDragAreaDebug extends StatelessWidget {
  final Rect boxRect;

  const _ReactionDragAreaDebug({required this.boxRect});

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
// coverage:ignore-end
