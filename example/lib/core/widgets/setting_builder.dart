import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

enum SettingBuilder { debug, example2, alignment, scale }

extension SettingBuilderExt on SettingBuilder {
  String get label {
    switch (this) {
      case SettingBuilder.debug:
        return 'debug';
      case SettingBuilder.example2:
        return 'Visible example 2';
      case SettingBuilder.alignment:
        return 'Alignment';
      case SettingBuilder.scale:
        return 'scale';
    }
  }

  Widget build({
    required ValueSettingsBuilder value,
    required ValueChanged<ValueSettingsBuilder> onChanged,
  }) {
    switch (this) {
      case SettingBuilder.alignment:
        return CustomListAlignment(
          label: label,
          value: value.$1,
          onChanged: (e) => onChanged.call(value.copyWith(alignment: e)),
        );
      case SettingBuilder.debug:
        return CustomSwitchListTile(
          label: label,
          value: value.$2.debug,
          onChanged: (e) => onChanged.call(value.copyWith(config: value.$2.copyWith(debug: e))),
        );
      case SettingBuilder.example2:
        return CustomSwitchListTile(
          label: label,
          value: value.$3,
          onChanged: (e) => onChanged.call(value.copyWith(visible: e)),
        );
      case SettingBuilder.scale:
        return CustomSlider(
          label: label,
          value: value.$4,
          onChanged: (e) => onChanged.call(
            value.copyWith(config: value.$2.adjustedScale(e), scale: e),
          ),
        );
    }
  }
}
