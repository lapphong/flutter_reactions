import 'package:flutter/material.dart';

import '../core/core.dart';
import 'flutter_reaction_builder.dart';
import 'flutter_reaction_overlay.dart';
import 'widgets/widgets.dart';

class FlutterReactionButton extends StatefulWidget {
  /// A fully handled reaction button widget.
  ///
  /// `FlutterReactionButton` already manages all core reaction interactions
  /// across platforms, including:
  /// - Tap / Double tap
  /// - Long press to open reaction overlay
  /// - Pointer hover, move, and release handling
  /// - Overlay positioning based on widget layout
  ///
  /// It works consistently on mobile, web, and desktop without
  /// requiring additional gesture or overlay logic from the consumer.
  const FlutterReactionButton({
    super.key,
    this.config,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.mode = DisplayMode.image,
    this.hasLabel = true,
    this.child,
  });

  final FlutterReactionConfig? config;
  final FlutterReactionType? value;
  final ValueChanged<FlutterReactionType?> onChanged;
  final double? size;
  final DisplayMode mode;
  final bool hasLabel;
  final Widget? child;

  @override
  State<FlutterReactionButton> createState() => _FlutterReactionButtonState();
}

class _FlutterReactionButtonState extends State<FlutterReactionButton>
    with FlutterReactionMixin, SingleTickerProviderStateMixin {
  @override
  FlutterReactionType? get flutterReactionType => widget.value;

  ValueChanged<FlutterReactionType?> get onChanged => widget.onChanged;

  final GlobalKey globalKey = GlobalKey();

  @override
  Rect get widgetRect => globalKey.currentContext!.getRenderObjectInfo.$1;

  @override
  FlutterReactionConfig? get config => widget.config ?? FlutterReactionOverlay.defaultConfig;

  late final AnimationController _scaleController;

  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.4).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.4, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_scaleController);
  }

  @override
  void showReactionOverlay() {
    context.showReactionOverlay(
      key: globalKey,
      config: widget.config,
      value: flutterReactionType,
      onChanged: onChanged,
    );
  }

  @override
  void didUpdateWidget(covariant FlutterReactionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != null) {
      _scaleController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TooltipWidget(
      preferBelow: true,
      message: (flutterReactionType == null && !AppConstants.isMobile)
          ? (FlutterReactionTranslations.text('tap_to_like') ?? 'Tap to like')
          : '',
      child: MouseRegion(
        onEnter: onPointerHover,
        onExit: onExit,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          key: globalKey,
          onLongPressStart: (details) {
            showReactionOverlay();
            onPointerDown(PointerDownEvent(position: details.globalPosition));
          },
          onLongPressMoveUpdate: (details) {
            onPointerMove(PointerMoveEvent(position: details.globalPosition));
          },
          onLongPressEnd: (details) {
            onPointerUp(
              PointerUpEvent(position: details.globalPosition),
              autoClose: false,
              onChanged: onChanged,
            );
          },
          onTap: () => onTap(onChanged: onChanged),
          onDoubleTap: () => onDoubleTap(onChanged: onChanged),
          child: _buildReactionWidget(),
        ),
      ),
    );
  }

  Widget _buildReactionWidget() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(AppConstants.spacing * 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: flutterReactionType != null
                ? flutterReactionType!.buildDisplay(mode: widget.mode, size: widget.size)
                : (widget.child ?? Icon(Icons.thumb_up_alt_rounded, color: Colors.grey, size: widget.size)),
          ),
          if (flutterReactionType != null && widget.hasLabel)
            Padding(
              padding: const EdgeInsets.only(left: AppConstants.spacing),
              child: Text(
                flutterReactionType!.label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: flutterReactionType!.textColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
