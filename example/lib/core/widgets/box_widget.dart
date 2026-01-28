import 'package:example/core/widgets/box_builder.dart';
import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final BoxType type;
  final bool isSettings;
  final bool isMedium;
  final Widget child;

  const BoxWidget({
    super.key,
    required this.type,
    required this.isSettings,
    required this.isMedium,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: type.getFlex(isMedium),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: type.getMargin(context, isMedium, isSettings),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: type.getBorderRadius(context, isMedium, isSettings),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              offset: const Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
