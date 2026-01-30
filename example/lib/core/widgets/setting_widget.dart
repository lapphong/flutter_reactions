import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

class SettingWidget extends StatefulWidget {
  final ValueSettingsBuilder value;
  final ValueChanged<ValueSettingsBuilder> onChanged;

  const SettingWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  late ValueSettingsBuilder _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomBoxWidget(
            width: double.infinity,
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: context.radius, topRight: context.radius),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Config',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          ...SettingBuilder.values.map((e) {
            return e.build(
              value: _value,
              onChanged: (e) {
                setState(() => _value = e);
                widget.onChanged(_value);
              },
            );
          }),
        ],
      ),
    );
  }
}
