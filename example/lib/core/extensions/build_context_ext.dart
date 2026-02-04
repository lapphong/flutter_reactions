import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension BuildContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get width => screenSize.width;

  double get height => screenSize.height;

  double get safeTop => MediaQuery.of(this).padding.top;

  double get padding => 15;

  Radius get radius => Radius.circular(30);

  void onCopyText(String? text) {
    Clipboard.setData(ClipboardData(text: text ?? '')).then((value) {
      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.green),
            SizedBox(width: 5),
            Text('Copied to clipboard'),
          ],
        ),
        duration: Duration(milliseconds: 300),
      );
      ScaffoldMessenger.of(this).showSnackBar(snackBar);
    });
  }
}
