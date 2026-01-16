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
    this.hasLabel = true,
    this.child,
  });

  final FlutterReactionConfig? config;
  final FlutterReactionType? value;
  final ValueChanged<FlutterReactionType?> onChanged;
  final bool hasLabel;
  final Widget? child;

  @override
  State<FlutterReactionButton> createState() => _FlutterReactionButtonState();
}

class _FlutterReactionButtonState extends State<FlutterReactionButton> with FlutterReactionMixin {
  @override
  FlutterReactionType? get flutterReactionType => widget.value;

  @override
  Rect get widgetRect => widgetKey.currentContext!.getRenderObjectInfo.$1;

  void _onChangedReactionType(FlutterReactionType? value) async {
    setState(() => flutterReactionType = value);
    widget.onChanged(value);
  }

  @override
  void dispose() {
    context.dispose();
    super.dispose();
  }

  @override
  void showReactionOverlay() {
    context.showReactionOverlay(
      config: widget.config,
      value: flutterReactionType,
      onChanged: _onChangedReactionType,
    );
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
          key: widgetKey,
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
              onChanged: _onChangedReactionType,
            );
          },
          onTap: () => onTap(onChanged: _onChangedReactionType),
          onDoubleTap: () => onDoubleTap(onChanged: _onChangedReactionType),
          child: widget.child ?? _buildReactionWidget(),
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
          flutterReactionType != null
              ? flutterReactionType!.imageBuild()
              : const Icon(Icons.thumb_up_alt_rounded, color: Colors.grey),
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
