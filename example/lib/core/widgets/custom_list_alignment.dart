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

  static const List<Alignment> _alignments = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
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
              spacing: 40,
              runSpacing: 8,
              children: _alignments.map((e) {
                return InkWell(
                  onTap: () {
                    setState(() => _value = e);
                    widget.onChanged(e);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<AlignmentGeometry>(value: e, activeColor: Colors.blue),
                        Text(e.toString().split('.').last),
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
