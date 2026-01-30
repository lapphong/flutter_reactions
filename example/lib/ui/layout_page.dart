import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatefulWidget {
  final Widget child;
  final bool isSetting;
  final ValueChanged<bool?> onCloseSetting;
  final ValueSettingsBuilder value;
  final ValueChanged<ValueSettingsBuilder> onChanged;

  const LayoutPage({
    super.key,
    required this.isSetting,
    required this.onCloseSetting,
    required this.value,
    required this.onChanged,
    required this.child,
  });

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool get _isSettings => widget.isSetting;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMedium = constraints.maxWidth <= 900;

        final Widget content = ContainerWidget(
          onTap: () {
            if (_isSettings) {
              widget.onCloseSetting(false);
            }
          },
          padding: EdgeInsetsGeometry.all(context.padding),
          type: BoxType.content,
          isSettings: _isSettings,
          isMedium: isMedium,
          child: widget.child,
        );

        final Widget settingWidget = SettingWidget(
          value: widget.value,
          onChanged: widget.onChanged,
        );
        final Widget setting = ContainerWidget(
          type: BoxType.setting,
          isSettings: _isSettings,
          isMedium: isMedium,
          child: isMedium ? settingWidget : SizedBox.expand(child: settingWidget),
        );

        if (isMedium) {
          return Column(
            children: [
              content,
              if (_isSettings) setting,
            ],
          );
        }

        return Row(
          children: [
            content,
            if (_isSettings) setting,
          ],
        );
      },
    );
  }
}
