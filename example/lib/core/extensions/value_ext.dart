import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

typedef FlutterReactionCustomBuilder =
    Widget Function(AlignmentGeometry alignment, FlutterReactionConfig config, bool visibleExample2);

typedef ValueSettingsBuilder = (AlignmentGeometry, FlutterReactionConfig, bool, double);

extension ValueSettingsCopy on ValueSettingsBuilder {
  ValueSettingsBuilder copyWith({
    AlignmentGeometry? alignment,
    FlutterReactionConfig? config,
    bool? visible,
    double? scale,
  }) {
    return (alignment ?? $1, config ?? $2, visible ?? $3, scale ?? $4);
  }
}
