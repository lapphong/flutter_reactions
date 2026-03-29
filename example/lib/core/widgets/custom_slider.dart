import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value = widget.value;

  @override
  Widget build(BuildContext context) {
    final isDefault = _value == 1.0;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(showValueIndicator: ShowValueIndicator.onDrag),
              child: Slider(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey.shade400,
                min: 0.5,
                max: 2.0,
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
          CupertinoButton(
            sizeStyle: CupertinoButtonSize.small,
            foregroundColor: !isDefault ? Colors.blue : Colors.grey,
            onPressed: isDefault
                ? null
                : () {
                    setState(() {
                      _value = 1.0;
                      widget.onChanged(_value);
                    });
                  },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
