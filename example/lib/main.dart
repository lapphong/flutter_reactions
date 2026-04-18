import 'package:example/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

import 'ui/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterReactionTranslations.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // IMPORTANT ⚠️: Call this in parent widget dispose(). Do NOT call inside FlutterReactionButton or item widgets.
    // Dispose reaction overlay resources to avoid memory leaks.
    // Check method details to ensure correct usage.
    // You can either call context.dispose()
    context.dispose();

    // or use FlutterReactionOverlay.dispose() if using the context extension.
    // FlutterReactionOverlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1E90FF)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: MyHomePage(
        builder: (alignment, config, visibleExample2) {
          return Align(
            alignment: alignment,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Example1(config: config),
                if (visibleExample2) ...[
                  SizedBox(height: context.height / 4.5),
                  Example2(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class Example1 extends StatefulWidget {
  final FlutterReactionConfig config;

  const Example1({super.key, required this.config});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  FlutterReactionType? flutterReactionType;

  @override
  Widget build(BuildContext context) {
    return FlutterReactionButton(
      config: widget.config,
      value: flutterReactionType,
      onChanged: (value) {
        setState(() {
          flutterReactionType = value;
        });
        if (value == null) {
          debugPrint('No Reaction');
        } else {
          debugPrint(value.toString());
        }
      },
    );
  }
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  FlutterReactionType? flutterReactionType;

  final GlobalKey key = GlobalKey(); // IMPORTANT

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: key, // Required GlobalKey
      tooltip: 'Long press',
      onPressed: () {
        if (flutterReactionType != null) {
          setState(() {
            flutterReactionType = null;
          });
        }

        // Hide overlay using the static helper
        FlutterReactionOverlay.hideOverlay();

        // Or use the context extension
        // context.hideReactionOverlay();
      },
      onLongPress: () {
        // Show overlay using the static helper
        FlutterReactionOverlay.showOverlay(
          context,
          key: key, // Required GlobalKey
          value: flutterReactionType,
          onChanged: (value) {
            setState(() {
              flutterReactionType = value;
            });
          },
        );

        // Or use the context extension
        // context.showReactionOverlay(
        //   key: key, // Required GlobalKey
        //   value: flutterReactionType,
        //   onChanged: (value) {},
        // );
      },
      icon: flutterReactionType != null ? flutterReactionType!.buildDisplay() : Icon(Icons.home),
    );
  }
}
