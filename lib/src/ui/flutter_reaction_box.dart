import 'package:flutter/material.dart' hide AnimatedSlide;

import '../core/core.dart';
import 'flutter_reaction_builder.dart';
import 'flutter_reaction_listener.dart';
import 'flutter_reaction_overlay.dart';
import 'widgets/flutter_reaction_item_widget.dart';

class FlutterReactionsBox extends StatefulWidget {
  const FlutterReactionsBox({
    super.key,
    required this.config,
    required this.value,
    required this.onChanged,
    required this.targetAnchor,
  });

  final FlutterReactionConfig config;
  final FlutterReactionType? value;
  final ValueChanged<FlutterReactionType?> onChanged;
  final ({GlobalKey key, Offset offset}) targetAnchor;

  @override
  State<FlutterReactionsBox> createState() => _FlutterReactionsBoxState();
}

class _FlutterReactionsBoxState extends State<FlutterReactionsBox> {
  FlutterReactionType? _flutterReactionType;

  FlutterReactionConfig get config => widget.config;

  ({GlobalKey key, Offset offset}) get targetAnchor => widget.targetAnchor;

  @override
  void initState() {
    super.initState();
    _flutterReactionType = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterReactionListener(
          targetKey: targetAnchor.key,
          onChanged: widget.onChanged,
        ),
        Positioned(
          top: targetAnchor.offset.dx,
          left: targetAnchor.offset.dy,
          child: Stack(
            key: boxKey,
            children: [
              Container(
                width: config.boxWidth,
                height: config.getBoxHeight(_flutterReactionType),
                decoration: config.boxDecoration,
              ),
              Container(
                width: config.boxWidth,
                height: config.getBoxHeight(_flutterReactionType),
                padding: config.boxPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: FlutterReactionType.values.mapIndexed(
                    (e, index) {
                      final isActive = _flutterReactionType == e;

                      return FlutterReactionItemWidget(
                        key: itemKeys[index],
                        type: e,
                        itemConfig: config.itemConfig,
                        isActive: isActive,
                        onTap: () async {
                          context.playAudio(AudioConstants.audioPick);
                          setState(() => _flutterReactionType = e);
                          widget.onChanged(e);
                          await Future.delayed(const Duration(milliseconds: 100));
                          context.hideReactionOverlay();
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
