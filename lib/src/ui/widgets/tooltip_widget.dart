import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
  final String message;
  final bool preferBelow;
  final Widget child;

  const TooltipWidget({
    super.key,
    required this.message,
    this.preferBelow = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: preferBelow ? Colors.transparent : Colors.black.withValues(alpha: 0.5),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 0),
      preferBelow: preferBelow,
      message: message,
      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: preferBelow ? Colors.blue.withValues(alpha: 0.75) : Colors.white,
            fontWeight: FontWeight.w500,
          ),
      child: child,
    );
  }
}
