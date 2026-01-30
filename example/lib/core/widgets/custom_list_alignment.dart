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
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(17),
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
              spacing: 20,
              runSpacing: 8,
              children: _alignments.entries.map((e) {
                return InkWell(
                  onTap: () {
                    setState(() => _value = e.key);
                    widget.onChanged(e.key);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<AlignmentGeometry>(value: e.key, activeColor: Colors.blue),
                      Text(e.value),
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
