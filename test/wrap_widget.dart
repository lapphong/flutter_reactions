import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

Widget wrap({double? triggerIconSize}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(child: WrapWidget(triggerIconSize: triggerIconSize)),
    ),
  );
}

class WrapWidget extends StatefulWidget {
  const WrapWidget({super.key, this.triggerIconSize});

  final double? triggerIconSize;

  @override
  State<WrapWidget> createState() => WrapWidgetState();
}

class WrapWidgetState extends State<WrapWidget> {
  FlutterReactionType? flutterReactionType;

  @override
  void dispose() {
    context.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterReactionButton(
      value: flutterReactionType,
      triggerIconSize: widget.triggerIconSize ?? 22,
      onChanged: (value) {
        setState(() {
          flutterReactionType = value;
        });
      },
    );
  }
}
