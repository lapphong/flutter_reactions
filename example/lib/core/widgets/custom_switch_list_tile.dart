import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({
    super.key,
    required this.label,
    this.value,
    required this.onChanged,
  });

  final String label;
  final bool? value;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.all(10),
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.blue,
      title: Text(widget.label),
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.onChanged(_value);
        });
      },
    );
  }
}
