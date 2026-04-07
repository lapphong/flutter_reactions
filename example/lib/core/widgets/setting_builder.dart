import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

enum SettingBuilder {
  debug,
  example2,
  // displayReaction,
  alignment,
  scale,
  visibleReactions,
  snippet,
}

extension SettingBuilderExt on SettingBuilder {
  String get label {
    switch (this) {
      case SettingBuilder.debug:
        return 'debug';
      case SettingBuilder.example2:
        return 'Visible example 2';
      // case SettingBuilder.displayReaction:
      //   return 'Display reaction';
      case SettingBuilder.alignment:
        return 'Alignment:';
      case SettingBuilder.scale:
        return 'scale';
      case SettingBuilder.visibleReactions:
        return 'Visible reactions:';
      case SettingBuilder.snippet:
        return 'Code Snippet';
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
      // case SettingBuilder.displayReaction:
      //   return CustomDisplayReaction(
      //     label: label,
      //     value: value.$2.display,
      //     onChanged: (e) => onChanged.call(value.copyWith(config: value.$2.copyWith(display: e))),
      //   );
      case SettingBuilder.scale:
        return CustomSlider(
          label: label,
          value: value.$4,
          onChanged: (e) => onChanged.call(value.copyWith(config: value.adjustedScale(e), scale: e)),
        );
      case SettingBuilder.visibleReactions:
        return CustomVisibleReactions(
          label: label,
          value: value.$2.reactions,
          onChanged: (e) => onChanged.call(value.copyWith(config: value.$2.copyWith(reactions: e))),
        );
      case SettingBuilder.snippet:
        return CustomCodeSnippet(
          label: label,
          message: value.toCodeSnippet(),
        );
    }
  }
}
