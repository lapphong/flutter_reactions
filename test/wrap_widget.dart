import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

Widget wrap() {
  return const MaterialApp(
    home: Scaffold(
      body: Center(child: WrapWidget()),
    ),
  );
}

class WrapWidget extends StatefulWidget {
  const WrapWidget({super.key});

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
      onChanged: (value) {
        setState(() {
          flutterReactionType = value;
        });
      },
    );
  }
}
