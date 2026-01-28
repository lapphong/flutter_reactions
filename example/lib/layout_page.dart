import 'package:example/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class LayoutPage extends StatefulWidget {
  final Widget child;
  final bool isSetting;
  final ValueChanged<bool?> onCloseSetting;
  final ValueChanged<AlignmentGeometry> onUpdateAlignment;
  final ValueChanged<FlutterReactionConfig> onUpdateConfig;
  final ValueChanged<bool> onUpdateExample2;

  const LayoutPage({
    super.key,
    required this.isSetting,
    required this.onCloseSetting,
    required this.onUpdateAlignment,
    required this.onUpdateConfig,
    required this.onUpdateExample2,
    required this.child,
  });

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool get _isSettings => widget.isSetting;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isMedium = constraints.maxWidth <= 900;

            final Widget content = BoxWidget(
              type: BoxType.content,
              isSettings: _isSettings,
              isMedium: isMedium,
              child: widget.child,
            );

            final Widget settingWidget = SettingWidget(
              onUpdateAlignment: widget.onUpdateAlignment,
              onUpdateConfig: widget.onUpdateConfig,
              onUpdateExample2: widget.onUpdateExample2,
            );
            final Widget setting = BoxWidget(
              type: BoxType.setting,
              isSettings: _isSettings,
              isMedium: isMedium,
              child: isMedium ? Row(children: [settingWidget]) : settingWidget,
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
        ),
        if (_isSettings)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => widget.onCloseSetting(false),
            child: const SizedBox.expand(),
          ),
      ],
    );
  }
}
