import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

enum SettingBuilder { debug, example2, alignment, width }

extension SettingBuilderExt on SettingBuilder {
  String get label {
    switch (this) {
      case SettingBuilder.debug:
        return 'debug';
      case SettingBuilder.example2:
        return 'Visible example 2';
      case SettingBuilder.alignment:
        return 'Alignment';
      case SettingBuilder.width:
        return 'width';
    }
  }

  Widget build(
    BuildContext context, {
    required ValueSettingsBuilder value,
    required ValueChanged<ValueSettingsBuilder> onChanged,
  }) {
    switch (this) {
      case SettingBuilder.alignment:
        return CustomListAlignment(
          label: label,
          value: value.$1,
          onChanged: (e) => onChanged.call((e, value.$2, value.$3)),
        );
      case SettingBuilder.debug:
        return CustomSwitchListTile(
          label: label,
          value: value.$2.debug,
          onChanged: (e) => onChanged.call((value.$1, value.$2.copyWith(debug: e), value.$3)),
        );
      case SettingBuilder.example2:
        return CustomSwitchListTile(
          label: label,
          value: value.$3,
          onChanged: (e) => onChanged.call((value.$1, value.$2, e)),
        );
      case SettingBuilder.width:
        return CustomSlider(
          label: label,
          value: value.$2.boxWidth,
          onChanged: (e) => onChanged.call((value.$1, value.$2.copyWith(boxWidth: e), value.$3)),
          min: context.isMobile ? 260.0 : 315.0,
          max: context.isMobile ? 380 : 1000.0,
        );
    }
  }
}
