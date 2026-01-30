import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get width => screenSize.width;

  double get height => screenSize.height;

  double get safeTop => MediaQuery.of(this).padding.top;

  double get padding => 15;

  Radius get radius => Radius.circular(30);
}
