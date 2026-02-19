import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<FlutterReactionType?> posts = List.filled(100, null);

  @override
  void dispose() {
    context.dispose(); // FlutterReactionOverlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            key: ValueKey(index),
            title: Text('post $index'),
            subtitle: Row(
              children: [
                Expanded(
                  child: Center(
                    child: _ReactionButton(
                      value: posts[index],
                      onChanged: (v) {
                        posts[index] = v;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.message_outlined),
                      Text('Comment', style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share_outlined),
                      Text('Share', style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  const _ReactionButton({super.key, required this.value, required this.onChanged});

  final FlutterReactionType? value;
  final ValueChanged<FlutterReactionType?> onChanged;

  @override
  Widget build(BuildContext context) {
    return FlutterReactionButton(
      config: FlutterReactionConfig(),
      value: value,
      onChanged: onChanged,
    );
  }
}
