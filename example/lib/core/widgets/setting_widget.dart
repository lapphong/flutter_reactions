import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class SettingWidget extends StatelessWidget {
  final ValueChanged<AlignmentGeometry> onUpdateAlignment;
  final ValueChanged<FlutterReactionConfig> onUpdateConfig;
  final ValueChanged<bool> onUpdateExample2;

  const SettingWidget({
    super.key,
    required this.onUpdateAlignment,
    required this.onUpdateConfig,
    required this.onUpdateExample2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            20,
            (index) {
              return ListTile(title: Text(index.toString()));
            },
          ),
        ),
      ),
    );
  }
}
