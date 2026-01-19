// coverage:ignore-file
import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final double dotSize;
  final Color dotColor;

  const DotWidget({super.key, required this.dotSize, required this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
      margin: const EdgeInsets.only(top: 3.0),
      width: dotSize,
      height: dotSize,
    );
  }
}
