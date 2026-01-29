import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final BoxType type;
  final bool isSettings;
  final bool isMedium;
  final VoidCallback? onTap;
  final Widget child;

  const ContainerWidget({
    super.key,
    this.onTap,
    required this.type,
    required this.isSettings,
    required this.isMedium,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: type.getFlex(isMedium),
      child: GestureDetector(
        onTap: onTap,
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
          child: type == BoxType.content ? child : CustomBoxWidget(child: child),
        ),
      ),
    );
  }
}
