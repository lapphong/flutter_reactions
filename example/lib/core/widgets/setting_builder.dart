import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

enum SettingBuilder { debug, example2 }

extension SettingBuilderExt on SettingBuilder {
  String get label {
    switch (this) {
      case SettingBuilder.debug:
        return 'debug';
      case SettingBuilder.example2:
        return 'Visible example 2';
    }
  }

  Widget build({
    required ValueSettingsBuilder value,
    required ValueChanged<ValueSettingsBuilder> onChanged,
  }) {
    switch (this) {
      case SettingBuilder.debug:
        return CustomSwitchListTile(
          label: label,
          value: value.$2.debug!,
          onChanged: (e) => onChanged.call((value.$1, value.$2.copyWith(debug: e), value.$3)),
        );
      case SettingBuilder.example2:
        return CustomSwitchListTile(
          label: label,
          value: value.$3,
          onChanged: (e) => onChanged.call((value.$1, value.$2, e)),
        );
    }
  }
}
