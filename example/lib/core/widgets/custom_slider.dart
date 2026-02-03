import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  final String label;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
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
                label: _value.round().toString(),
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    widget.onChanged(_value);
                  });
                },
              ),
            ),
          ),
          Text(
            _value.round().toString(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
