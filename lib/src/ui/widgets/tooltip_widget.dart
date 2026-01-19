// coverage:ignore-file
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
  final String message;
  final bool preferBelow;
  final Widget child;
  final bool visible; // for mobile

  const TooltipWidget({
    super.key,
    required this.message,
    this.preferBelow = false,
    required this.child,
    this.visible = false,
  });

  bool get isMobile => defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  BoxDecoration get decoration => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: preferBelow ? Colors.transparent : Colors.black.withValues(alpha: 0.5),
      );

  TextStyle textStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: preferBelow ? Colors.blue.withValues(alpha: 0.75) : Colors.white,
          fontWeight: FontWeight.w500,
        );
  }

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? _buildToolTipForMobile(context)
        : Tooltip(
            decoration: decoration,
            margin: const EdgeInsets.only(bottom: 20, left: 0),
            preferBelow: preferBelow,
            message: message,
            textStyle: textStyle(context),
            child: child,
          );
  }

  Widget _buildToolTipForMobile(BuildContext context) {
    const offset = Offset(0, -65);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        child,
        if (visible)
          Positioned(
            top: preferBelow ? offset.dy.abs() : offset.dy,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: decoration,
                child: Text(message, style: textStyle(context)),
              ),
            ),
          ),
      ],
    );
  }
}
