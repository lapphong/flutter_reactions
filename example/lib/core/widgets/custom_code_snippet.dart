import 'package:example/core/core.dart';
import 'package:flutter/material.dart';

class CustomCodeSnippet extends StatelessWidget {
  const CustomCodeSnippet({
    super.key,
    required this.label,
    required this.message,
  });

  final String label;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
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
                  child: Text(message, style: Theme.of(context).textTheme.bodyLarge),
                ),
                Align(
                  alignment: AlignmentGeometry.topRight,
                  child: IconButton(
                    onPressed: () => context.onCopyText(message),
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
