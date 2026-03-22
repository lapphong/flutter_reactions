import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class CustomVisibleReactions extends StatefulWidget {
  const CustomVisibleReactions({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<FlutterReactionType> value;
  final ValueChanged<List<FlutterReactionType>> onChanged;

  @override
  State<CustomVisibleReactions> createState() => _CustomVisibleReactionsState();
}

class _CustomVisibleReactionsState extends State<CustomVisibleReactions> {
  late List<FlutterReactionType> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.value.isEmpty ? FlutterReactionType.values.toList() : [...widget.value];
  }

  void _toggle(FlutterReactionType type) {
    setState(() {
      if (_selected.contains(type)) {
        if (_selected.length <= 2) return;
        _selected.remove(type);
      } else {
        _selected.add(type);
        _selected.sort(
          (a, b) => FlutterReactionType.values.indexOf(a).compareTo(FlutterReactionType.values.indexOf(b)),
        );
      }
    });
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final isAllSelected = _selected.length == FlutterReactionType.values.length;

    return Tooltip(
      message: _selected.length <= 2 ? 'Select at least 2 items' : '',
      margin: EdgeInsets.only(top: 25.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
                CupertinoButton(
                  sizeStyle: CupertinoButtonSize.small,
                  foregroundColor: !isAllSelected ? Colors.blue : Colors.grey,
                  onPressed: isAllSelected
                      ? null
                      : () {
                          setState(() {
                            _selected = FlutterReactionType.values.toList();
                          });
                          widget.onChanged(_selected);
                        },
                  child: const Text('Reset'),
                ),
              ],
            ),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: FlutterReactionType.values.map((type) {
                final isSelected = _selected.contains(type);

                return _CustomCheckBox(
                  type: type,
                  value: isSelected,
                  onChanged: (_) => _toggle(type),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCheckBox extends StatelessWidget {
  const _CustomCheckBox({
    super.key,
    required this.type,
    required this.value,
    required this.onChanged,
  });

  final FlutterReactionType type;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoCheckbox(
              value: value,
              onChanged: (v) => onChanged(v!),
              tapTargetSize: Size.square(32.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: type.buildGif(),
            ),
            Text(type.label),
          ],
        ),
      ),
    );
  }
}
