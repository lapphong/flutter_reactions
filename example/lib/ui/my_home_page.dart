import 'package:example/ui/layout_page.dart';
import 'package:example/ui/next_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

import '../core/core.dart';

class MyHomePage extends StatefulWidget {
  final FlutterReactionCustomBuilder builder;

  const MyHomePage({super.key, required this.builder});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isSettings = false;

  final _value = ValueNotifier<ValueSettingsBuilder>((Alignment.center, FlutterReactionConfig(), false, 1.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Reaction Page'),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.0),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage())),
            icon: context.width > 400
                ? Text('Go to NextPage', style: TextStyle(color: Colors.white))
                : Icon(Icons.list_alt_outlined),
          ),
        ],
      ),
      body: LayoutPage(
        value: _value.value,
        onChanged: (e) => _value.value = e,
        isSetting: _isSettings,
        onCloseSetting: (value) => setState(() => _isSettings = value!),
        child: ValueListenableBuilder(
          valueListenable: _value,
          builder: (context, value, child) {
            return widget.builder(value.$1, value.$2, value.$3);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !_isSettings
          ? FloatingActionButton(
              onPressed: () => setState(() => _isSettings = !_isSettings),
              child: const Icon(Icons.settings_outlined),
            )
          : null,
    );
  }
}
