import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  final Animation<double> overlayOpacity;
  final Widget child;

  const OverlayWidget({super.key, required this.overlayOpacity, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: overlayOpacity,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: overlayOpacity.value),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
