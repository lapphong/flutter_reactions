import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class CustomDisplayReaction extends StatefulWidget {
  const CustomDisplayReaction({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DisplayMode value;
  final ValueChanged<DisplayMode> onChanged;

  @override
  State<CustomDisplayReaction> createState() => _CustomDisplayReactionState();
}

class _CustomDisplayReactionState extends State<CustomDisplayReaction> {
  late DisplayMode _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8.0),
          RadioGroup<DisplayMode>(
            groupValue: _value,
            onChanged: (e) {
              setState(() => _value = e!);
              widget.onChanged(e!);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: DisplayMode.values.map((e) {
                return InkWell(
                  onTap: () {
                    setState(() => _value = e);
                    widget.onChanged(e);
                  },
                  child: Row(
                    spacing: 8.0,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoRadio<DisplayMode>(value: e, activeColor: Colors.blue),
                      Text(e.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
