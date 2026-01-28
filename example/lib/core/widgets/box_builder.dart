import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

enum BoxType { content, setting }

extension BoxTypeExt on BoxType {
  int getFlex(bool isMedium) {
    switch (this) {
      case BoxType.content:
        return isMedium ? 3 : 8;
      case BoxType.setting:
        return isMedium ? 2 : 3;
    }
  }

  BorderRadiusGeometry getBorderRadius(
    BuildContext context,
    bool isMedium,
    bool isSettings,
  ) {
    if (!isSettings) return BorderRadius.zero;

    final r = context.radius;

    if (!isMedium) return BorderRadius.all(r);

    return switch (this) {
      BoxType.content => BorderRadius.only(bottomLeft: r, bottomRight: r),
      BoxType.setting => BorderRadius.only(topLeft: r, topRight: r),
    };
  }

  EdgeInsetsGeometry getMargin(
    BuildContext context,
    bool isMedium,
    bool isSettings,
  ) {
    if (!isSettings) return EdgeInsets.zero;

    final padding = context.padding;

    if (isMedium) {
      return this == BoxType.setting ? EdgeInsets.only(top: padding * 2) : EdgeInsets.zero;
    }

    return EdgeInsets.all(padding);
  }
}
