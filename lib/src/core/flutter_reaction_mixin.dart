import 'dart:async';

import 'package:flutter/material.dart';

import '../ui/flutter_reaction_builder.dart';
import '../ui/flutter_reaction_overlay.dart';
import 'core.dart';

mixin FlutterReactionMixin<T extends StatefulWidget> on State<T> {
  FlutterReactionType? flutterReactionType;
  Timer? _timer;

  bool _allow = true;

  late Rect widgetRect;

  Rect get boxRect => boxKey.currentContext!.getRenderObjectInfo.$1;

  void showReactionOverlay() {} // coverage:ignore-line

  /// Handles tap-based reaction logic (tap / double tap)
  void _handleReactionTap({
    required FlutterReactionType reaction,
    required ValueChanged<FlutterReactionType?> onChanged,
  }) {
    FlutterReactionType? value;
    if (flutterReactionType != null && flutterReactionType != reaction) {
      value = null;
    } else {
      value = flutterReactionType != reaction ? reaction : null;
    }
    if (value != null) {
      context.playAudio(AudioConstants.audioShortPressLike);
    }
    onChanged(value);
    context.hideReactionOverlay();
    _allow = false;
  }

  void onTap({required ValueChanged<FlutterReactionType?> onChanged}) {
    _handleReactionTap(
      reaction: FlutterReactionType.like,
      onChanged: onChanged,
    );
  }

  void onDoubleTap({required ValueChanged<FlutterReactionType?> onChanged}) {
    _handleReactionTap(
      reaction: FlutterReactionType.love,
      onChanged: onChanged,
    );
  }

  /// Handles hover logic (desktop / web)
  ///
  /// Opens the overlay when hovering inside the widget
  /// and closes it when leaving both widget and overlay area.
  void onPointerHover(
    PointerEvent event, {
    bool isOpen = true,
  }) {
    final position = event.position;

    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      final isInWidget = widgetRect.contains(position);
      if (isOpen) {
        if (_allow && isInWidget) {
          showReactionOverlay();
        }
      } else {
        final isInBox = boxRect.inflate(AppConstants.gap).contains(position);
        if (!isInWidget && !isInBox) {
          context.hideReactionOverlay(playAudio: true);
        }
      }
    });
  }

  /// Resets hover state when pointer exits the widget
  void onExit(PointerEvent event) {
    _timer?.cancel();
    _allow = true;
  }

  // ---------------------------------------------------------------------------
  // Mobile gesture handling (drag to select reaction)
  // ---------------------------------------------------------------------------

  /// Index of the currently focused reaction item while dragging
  int? _focusIndex;
  bool _isDragging = false;

  /// Initial press position to determine drag threshold
  Offset? _pressPosition;

  /// Records initial press position for drag detection
  void onPointerDown(PointerEvent event) {
    if (!AppConstants.isMobile) return;
    _pressPosition = event.position;
    _isDragging = false;
  }

  /// Handles pointer move events for drag-based reaction selection (mobile only)
  void onPointerMove(PointerEvent event) {
    if (!AppConstants.isMobile || itemKeys.first.currentState == null) return;

    // Detect drag start
    if (_pressPosition != null && !_isDragging) {
      final delta = event.position - _pressPosition!;
      if (delta.distance > AppConstants.dragThreshold) {
        _isDragging = true;
      }
    }

    if (!_isDragging) return;

    final position = event.position;

    // If pointer is outside the allowed drag area, clear focus
    if (!context.isInsideReactionDragArea(position: position, boxRect: boxRect)) {
      _clearFocusItem();
      return;
    }

    // Calculate focused item based on horizontal position
    final localX = position.dx - boxRect.left;
    final itemWidth = boxRect.width / itemKeys.length;
    final index = (localX ~/ itemWidth).clamp(0, itemKeys.length - 1);

    _switchFocusItem(index);
  }

  /// Switches focus to a new reaction item
  void _switchFocusItem(int index) {
    if (_focusIndex == index) return;

    if (_focusIndex != null) {
      itemKeys[_focusIndex!].currentState?.onUnfocus();
    }

    _focusIndex = index;
    context.playAudio(AudioConstants.audioFocus);
    itemKeys[index].currentState?.onFocus();
  }

  /// Clears the currently focused reaction item
  void _clearFocusItem() {
    if (_focusIndex != null) {
      itemKeys[_focusIndex!].currentState?.onUnfocus();
      _focusIndex = null;
    }
  }

  /// Handles pointer release for drag-based selection (mobile only)
  void onPointerUp(
    PointerEvent event, {
    bool autoClose = true,
    required ValueChanged<FlutterReactionType?> onChanged,
  }) async {
    if (!AppConstants.isMobile) return;

    // No dragging - tap outside closes overlay
    if (!_isDragging) {
      if (autoClose) context.hideReactionOverlay(playAudio: true);
      _resetDragState();
      return;
    }

    // Dragging but no reaction item is selected
    if (_focusIndex == null) {
      _resetDragState();
      return;
    }

    // Dragging and a reaction item is selected
    final value = FlutterReactionType.values[_focusIndex!];
    context.playAudio(AudioConstants.audioPick);
    onChanged(value);
    await Future.delayed(const Duration(milliseconds: 100));
    context.hideReactionOverlay();

    _resetDragState();
  }

  /// Resets drag-related state
  void _resetDragState() {
    _pressPosition = null;
    _isDragging = false;
    _clearFocusItem();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
