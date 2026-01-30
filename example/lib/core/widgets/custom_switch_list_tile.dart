import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  late bool _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SwitchListTile(
        contentPadding: EdgeInsets.all(5),
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
      ),
    );
  }
}
