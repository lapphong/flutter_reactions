import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../flutter_reaction_builder.dart';
import 'widgets.dart';

class FlutterReactionItemWidget extends StatefulWidget {
  final FlutterReactionType type;
  final FlutterReactionItemConfig itemConfig;
  final bool isActive;
  final VoidCallback onTap;

  const FlutterReactionItemWidget({
    super.key,
    required this.type,
    required this.itemConfig,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<FlutterReactionItemWidget> createState() => FlutterReactionItemWidgetState();
}

class FlutterReactionItemWidgetState extends State<FlutterReactionItemWidget> with TickerProviderStateMixin {
  late final Animation<double> _scaleAnimation;
  late final AnimationController _scaleController;

  late final Animation<double> _pressAnimation;
  late final AnimationController _pressController;

  late final Animation<double> _pressOverlayOpacity;

  FlutterReactionType get e => widget.type;
  FlutterReactionItemConfig get config => widget.itemConfig;

  double padding = 0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: config.scaleDuration);
    _pressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));

    _scaleAnimation = Tween(begin: 1.0, end: config.iconHoverSize / config.iconSize).animate(
      CurvedAnimation(parent: _scaleController, curve: config.scaleCurve),
    );
    _pressAnimation = Tween(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInCubic),
    );
    _pressOverlayOpacity = Tween(begin: 0.0, end: 0.15).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void onFocus() {
    _scaleController.forward();
    setState(() => padding = config.iconPadding);
  }

  void onUnfocus() {
    _scaleController.reverse();
    setState(() => padding = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => onFocus(),
          onExit: (_) => onUnfocus(),
          child: GestureDetector(
            onTapDown: (_) {
              _pressController.forward();
            },
            onTapUp: (_) {
              onUnfocus();
              _pressController.reverse();
              widget.onTap.call();
            },
            onTapCancel: () {
              onUnfocus();
              _pressController.reverse();
            },
            child: TooltipWidget(
              message: e.label,
              visible: padding != 0,
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _scaleController,
                  _pressController,
                ]),
                builder: (context, child) {
                  final scale = _scaleAnimation.value * _pressAnimation.value;

                  return Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomCenter,
                    child: child,
                  );
                },
                child: AnimatedPadding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  duration: const Duration(milliseconds: 100),
                  child: OverlayWidget(
                    overlayOpacity: _pressOverlayOpacity,
                    child: e.gifBuild(iconSize: config.iconSize),
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.isActive,
          child: DotWidget(dotSize: config.dotSize, dotColor: config.dotColor),
        ),
      ],
    );
  }
}
