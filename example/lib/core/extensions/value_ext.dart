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

  FlutterReactionConfig adjustedScale(double e) {
    final temp = FlutterReactionConfig();
    final iconSize = (temp.boxHeight * e) - 10.0;

    return temp.copyWith(
      boxWidth: temp.boxWidth * e,
      boxHeight: temp.boxHeight * e,
      boxDecoration: temp.boxDecoration.copyWith(borderRadius: BorderRadius.all(Radius.circular(iconSize))),
      itemConfig: temp.itemConfig.copyWith(
        iconSize: iconSize,
        dotSize: temp.itemConfig.dotSize * e,
      ),
    );
  }

  String toCodeSnippet() {
    final radius = ($2.boxDecoration.borderRadius as BorderRadius).topLeft.x.toStringAsFixed(1);
    final color = $2.boxDecoration.color!.toARGB32().toRadixString(16);
    final item = $2.itemConfig;

    return 'FlutterReactionConfig(\n'
        '  debug: ${$2.debug},\n'
        '  boxWidth: ${$2.boxWidth.toStringAsFixed(1)},\n'
        '  boxHeight: ${$2.boxHeight.toStringAsFixed(1)},\n'
        '  boxDecoration: BoxDecoration(\n'
        '    borderRadius: BorderRadius.all(Radius.circular($radius)),\n'
        '    color: const Color(0x$color),\n'
        '  ),\n'
        '  itemConfig: FlutterReactionItemConfig(\n'
        '    iconSize: ${item.iconSize.toStringAsFixed(1)},\n'
        '    dotSize: ${item.dotSize.toStringAsFixed(1)},\n'
        '  ),\n'
        '),';
  }
}
