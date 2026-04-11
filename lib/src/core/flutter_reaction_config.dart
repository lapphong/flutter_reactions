// coverage:ignore-file
import 'package:flutter/material.dart';

import '../ui/flutter_reaction_builder.dart';
import 'app_constants.dart';

enum DisplayMode { image, gif }

class FlutterReactionConfig {
  final bool debug;
  final List<FlutterReactionType> reactions;
  final double boxWidth;
  final double boxHeight;
  final BoxDecoration boxDecoration;
  final EdgeInsetsGeometry boxPadding;
  final FlutterReactionItemConfig itemConfig;

  FlutterReactionConfig({
    this.debug = false,
    List<FlutterReactionType>? reactions,
    double? boxWidth,
    double? boxHeight,
    BoxDecoration? boxDecoration,
    EdgeInsetsGeometry? boxPadding,
    FlutterReactionItemConfig? itemConfig,
  })  : reactions = reactions ?? FlutterReactionType.values,
        boxWidth = boxWidth ?? AppConstants.dimens.boxWidth,
        boxHeight = boxHeight ?? AppConstants.dimens.boxHeight,
        boxDecoration = boxDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppConstants.dimens.iconSize)),
              color: const Color(0xff252525),
            ),
        boxPadding = boxPadding ?? EdgeInsets.all(AppConstants.dimens.spacing),
        itemConfig = itemConfig ?? FlutterReactionItemConfig();

  double get boxHeightActive => boxHeight + (AppConstants.isMobile ? 7.0 : 8.0);

  double getBoxHeight(FlutterReactionType? value) => value != null ? boxHeightActive : boxHeight;

  FlutterReactionConfig copyWith({
    bool? debug,
    List<FlutterReactionType>? reactions,
    double? boxWidth,
    double? boxHeight,
    BoxDecoration? boxDecoration,
    EdgeInsetsGeometry? boxPadding,
    FlutterReactionItemConfig? itemConfig,
  }) {
    return FlutterReactionConfig(
      debug: debug ?? this.debug,
      reactions: reactions ?? this.reactions,
      boxWidth: boxWidth ?? this.boxWidth,
      boxHeight: boxHeight ?? this.boxHeight,
      boxDecoration: boxDecoration ?? this.boxDecoration,
      boxPadding: boxPadding ?? this.boxPadding,
      itemConfig: itemConfig ?? this.itemConfig,
    );
  }
}

class FlutterReactionItemConfig {
  final double iconSize;
  final DisplayMode iconMode;
  final double iconPadding;
  final Curve scaleCurve;
  final Duration scaleDuration;
  final double dotSize;
  final Color dotColor;

  FlutterReactionItemConfig({
    double? iconSize,
    this.iconMode = DisplayMode.gif,
    this.iconPadding = AppConstants.spacing * 3.0,
    this.scaleCurve = Curves.easeOut,
    this.scaleDuration = AppConstants.duration,
    double? dotSize,
    this.dotColor = Colors.blue,
  })  : iconSize = iconSize ?? AppConstants.dimens.iconSize,
        dotSize = dotSize ?? AppConstants.dimens.dotSize;

  double get iconHoverSize => iconSize + (AppConstants.isMobile ? 30.0 : 20.0);

  FlutterReactionItemConfig copyWith({
    double? iconSize,
    DisplayMode? iconMode,
    double? iconPadding,
    Curve? scaleCurve,
    Duration? scaleDuration,
    double? dotSize,
    Color? dotColor,
  }) {
    return FlutterReactionItemConfig(
      iconSize: iconSize ?? this.iconSize,
      iconMode: iconMode ?? this.iconMode,
      iconPadding: iconPadding ?? this.iconPadding,
      scaleCurve: scaleCurve ?? this.scaleCurve,
      scaleDuration: scaleDuration ?? this.scaleDuration,
      dotSize: dotSize ?? this.dotSize,
      dotColor: dotColor ?? this.dotColor,
    );
  }
}
