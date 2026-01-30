import 'package:flutter/material.dart';

class CustomBoxWidget extends StatelessWidget {
  const CustomBoxWidget({
    super.key,
    this.width,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    required this.child,
  });

  final double? width;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white, strokeAlign: 1, width: 3),
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
    );
  }
}
