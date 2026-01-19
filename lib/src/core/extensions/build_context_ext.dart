import 'package:flutter/material.dart';

import '../core.dart';

extension BuildContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size; // coverage:ignore-line

  double get safeTop => MediaQuery.of(this).padding.top; // coverage:ignore-line

  (Rect, Offset, Size) get getRenderObjectInfo {
    final renderBox = findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    return (offset & size, offset, size);
  }

  /// Calculates the adjusted position for the reaction box relative to a target widget.
  ///
  /// The box is shown above the target by default, or below if there is not enough space.
  /// It is centered horizontally, clamped within screen bounds, and adapted for mobile layouts.
  ///
  /// Returns [Offset.zero] if the provided [GlobalKey] is not mounted.
  Offset calculateReactionBoxPosition({
    required GlobalKey key,
    required Size overlaySize,
  }) {
    final targetInfo = key.currentContext?.getRenderObjectInfo;
    if (targetInfo == null) return Offset.zero;

    final (_, targetOffset, targetSize) = targetInfo;

    const double gap = AppConstants.gap;

    double top = targetOffset.dy - overlaySize.height - gap;
    if (top < safeTop + kToolbarHeight) {
      top = targetOffset.dy + targetSize.height + gap;
    }

    double left = targetOffset.dx + targetSize.width / 2 - overlaySize.width / 2;
    if (AppConstants.isMobile) {
      left = (screenSize.width - overlaySize.width) / 2;
    } else {
      left = left.clamp(gap, screenSize.width - overlaySize.width - gap);
    }

    return Offset(top, left);
  }

  /// Returns true if the pointer is within the allowed drag area of the reaction box.
  ///
  /// Used for mobile drag-to-select behavior.
  bool isInsideReactionDragArea({
    required Offset position,
    required Rect boxRect,
  }) {
    final extendAbove = boxRect.height * 2.0;
    final extendBelow = boxRect.height * 2.5;

    final top = boxRect.top - extendAbove;
    final bottom = boxRect.bottom + extendBelow;

    return position.dy >= top && position.dy <= bottom;
  }
}
