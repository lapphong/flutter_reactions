import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class CustomAnimationDirection extends StatefulWidget {
  const CustomAnimationDirection({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final Direction value;
  final ValueChanged<Direction> onChanged;

  @override
  State<CustomAnimationDirection> createState() => _CustomAnimationDirectionState();
}

class _CustomAnimationDirectionState extends State<CustomAnimationDirection> {
  late Direction _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8.0),
          RadioGroup<Direction>(
            groupValue: _value,
            onChanged: (e) {
              setState(() => _value = e!);
              widget.onChanged(e!);
            },
            child: Wrap(
              spacing: 30.0,
              runSpacing: 12.0,
              children: Direction.values.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      setState(() => _value = e);
                      widget.onChanged(e);
                    },
                    child: Row(
                      spacing: 8.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoRadio<Direction>(value: e, activeColor: Colors.blue),
                        Text(e.name),
                      ],
                    ),
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
