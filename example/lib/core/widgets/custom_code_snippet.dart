import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

class CustomCodeSnippet extends StatefulWidget {
  const CustomCodeSnippet({
    super.key,
    required this.label,
    required this.message,
  });

  final String label;
  final String message;

  @override
  State<CustomCodeSnippet> createState() => _CustomCodeSnippetState();
}

class _CustomCodeSnippetState extends State<CustomCodeSnippet> {
  @override
  void didUpdateWidget(covariant CustomCodeSnippet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != oldWidget.message) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.blue),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.message,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.topRight,
                  child: IconButton(
                    onPressed: () => context.onCopyText(widget.message),
                    icon: Icon(Icons.copy_outlined),
                    tooltip: 'Copy',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
