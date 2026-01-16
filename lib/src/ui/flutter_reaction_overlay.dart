import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import 'flutter_reaction_box.dart';
import 'flutter_reaction_builder.dart';
import 'widgets/widgets.dart';

extension FlutterReactionOverlayExt on BuildContext {
  /// Returns the shared audio player used by the reaction overlay.
  AudioPlayer get _player => FlutterReactionOverlay._player;

  void playAudio(String asset) async {
    try {
      await _player.play(AssetSource(asset));
    } catch (e) {
      debugPrint('[FlutterReactionOverlayExt] playAudio: $e');
    }
  }

  /// Shows the reaction overlay anchored to a widget.
  ///
  /// When calling this method directly, you must provide a [GlobalKey]
  /// that is attached to the target widget.
  ///
  /// An assertion error will be thrown if the key is missing or not mounted.
  void showReactionOverlay({
    GlobalKey? key,
    FlutterReactionConfig? config,
    required FlutterReactionType? value,
    required ValueChanged<FlutterReactionType?> onChanged,
  }) {
    FlutterReactionOverlay.showOverlay(this, key: key, config: config, value: value, onChanged: onChanged);
  }

  /// Hides the reaction overlay.
  ///
  /// If [playAudio] is true, a closing sound effect will be played.
  void hideReactionOverlay({bool playAudio = false}) {
    FlutterReactionOverlay.hideOverlay(playAudio: playAudio);
  }

  /// Disposes resources used by the reaction overlay.
  ///
  /// This method should be called when the reaction overlay is no longer used.
  /// Calling any overlay-related method after this may result in errors.
  void dispose() {
    FlutterReactionOverlay.dispose();
  }
}

/// Internal anchor key for [FlutterReactionButton].
///
/// Used automatically by the button when no [GlobalKey] is provided.
final GlobalKey widgetKey = GlobalKey();

/// Internal key for the reaction box widget.
///
/// Used internally for layout and interaction handling.
final GlobalKey boxKey = GlobalKey();

/// Internal keys for [FlutterReactionItemWidgetState].
///
/// These keys are used internally to manage focus, hover, and drag interactions
/// for each reaction item inside the reaction box.
final List<GlobalKey<FlutterReactionItemWidgetState>> itemKeys =
    FlutterReactionType.values.map((e) => GlobalKey<FlutterReactionItemWidgetState>()).toList();

class FlutterReactionOverlay {
  /// Shared audio player.
  static final _player = AudioPlayer()..audioCache = AudioCache(prefix: 'packages/flutter_reactions/');

  /// Default configuration.
  static final defaultConfig = FlutterReactionConfig();

  /// Current active overlay entry.
  static OverlayEntry? _overlayEntry;

  /// Displays the reaction overlay.
  ///
  /// Can be called directly without using the [BuildContext] extension.
  /// The overlay is positioned relative to the widget associated
  /// with the provided [GlobalKey].
  ///
  /// An assertion error will be thrown if the resolved key is not
  /// attached to the widget tree.
  static void showOverlay(
    BuildContext context, {
    GlobalKey? key,
    FlutterReactionConfig? config,
    required FlutterReactionType? value,
    required ValueChanged<FlutterReactionType?> onChanged,
  }) async {
    if (_overlayEntry != null) return;

    final targetKey = key ?? widgetKey;
    assert(
      targetKey.currentContext != null,
      'GlobalKey is required. '
      'Attach it to the target widget, or pass it to context.showReactionOverlay(key: yourGlobalKey) '
      'when not using FlutterReactionButton, ',
    );

    await FlutterReactionTranslations.load();

    final cf = config ?? defaultConfig;
    final offset = context.calculateReactionBoxPosition(
      key: targetKey,
      overlaySize: Size(cf.boxWidth, cf.getBoxHeight(value)),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return FlutterReactionsBox(
          config: cf,
          value: value,
          onChanged: onChanged,
          targetAnchor: (key: targetKey, offset: offset),
        );
      },
    );

    context.playAudio(AudioConstants.audioSoundBoxUp);
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  /// Removes the reaction overlay if it is currently displayed.
  static void hideOverlay({bool playAudio = false}) async {
    if (playAudio) {
      await _player.play(AssetSource(AudioConstants.audioSoundBoxDown));
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void dispose() async {
    hideOverlay();
    await _player.dispose();
  }
}
