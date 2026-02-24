import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0.5,
    this.max = 2.0,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.onDrag),
              child: Slider(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey.shade400,
                min: widget.min,
                max: widget.max,
                label: _value.toStringAsFixed(1),
                value: _value,
                onChanged: (value) {
                  final rounded = double.parse(value.toStringAsFixed(2));
                  setState(() {
                    _value = rounded;
                    widget.onChanged(rounded);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
