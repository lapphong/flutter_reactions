import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListAlignment extends StatefulWidget {
  const CustomListAlignment({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final AlignmentGeometry value;
  final ValueChanged<AlignmentGeometry> onChanged;

  @override
  State<CustomListAlignment> createState() => _CustomListAlignmentState();
}

class _CustomListAlignmentState extends State<CustomListAlignment> {
  late AlignmentGeometry _value = widget.value;

  static final Map<Alignment, String> _alignments = {
    Alignment.center: 'Center',
    Alignment.topLeft: 'Top Left',
    Alignment.topRight: 'Top Right',
    Alignment.bottomLeft: 'Bottom Left',
    Alignment.bottomRight: 'Bottom Right',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          RadioGroup<AlignmentGeometry>(
            groupValue: _value,
            onChanged: (e) {
              setState(() => _value = e!);
              widget.onChanged(e!);
            },
            child: Wrap(
              spacing: 30.0,
              runSpacing: 12.0,
              children: _alignments.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      setState(() => _value = e.key);
                      widget.onChanged(e.key);
                    },
                    child: Row(
                      spacing: 8.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoRadio<AlignmentGeometry>(value: e.key, activeColor: Colors.blue),
                        Text(e.value),
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
