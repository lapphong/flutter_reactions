import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

typedef FlutterReactionCustomBuilder =
    Widget Function(AlignmentGeometry alignment, FlutterReactionConfig config, bool visibleExample2);

typedef ValueSettingsBuilder = (AlignmentGeometry, FlutterReactionConfig, bool);

extension ValueExt on ValueNotifier<ValueSettingsBuilder> {
  void updateValue(ValueSettingsBuilder e) {
    value = (e.$1, e.$2, e.$3);
  }
}
