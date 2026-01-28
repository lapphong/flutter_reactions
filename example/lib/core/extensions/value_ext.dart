import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

typedef FlutterReactionCustomBuilder =
    Widget Function(AlignmentGeometry alignment, FlutterReactionConfig config, bool visibleExample2);

typedef ValueSettingsBuilder = (AlignmentGeometry, FlutterReactionConfig, bool);

extension ValueExt on ValueNotifier<ValueSettingsBuilder> {
  void updateAlignment(AlignmentGeometry alignment) {
    value = (alignment, value.$2, value.$3);
  }

  void updateConfig(FlutterReactionConfig config) {
    value = (value.$1, config, value.$3);
  }

  void updateExample2(bool example2) {
    value = (value.$1, value.$2, example2);
  }
}
