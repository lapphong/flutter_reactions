import 'package:flutter/material.dart';

import '../core/core.dart';

enum FlutterReactionType { like, love, care, haha, wow, sad, angry }

extension FlutterReactionTypeExt on FlutterReactionType {
  String get label {
    return FlutterReactionTranslations.text(name) ?? defaultLabel;
  }

  String get defaultLabel {
    switch (this) {
      case FlutterReactionType.like:
        return 'Like';
      case FlutterReactionType.love:
        return 'Love';
      case FlutterReactionType.care:
        return 'Care';
      case FlutterReactionType.haha:
        return 'Haha';
      case FlutterReactionType.wow:
        return 'Wow';
      case FlutterReactionType.sad:
        return 'Sad';
      case FlutterReactionType.angry:
        return 'Angry';
    }
  }

  Color get textColor {
    switch (this) {
      case FlutterReactionType.like:
        return Colors.blue;
      case FlutterReactionType.love || FlutterReactionType.care:
        return Colors.redAccent;
      case FlutterReactionType.haha || FlutterReactionType.wow || FlutterReactionType.sad:
        return Colors.yellow;
      case FlutterReactionType.angry:
        return Colors.deepOrange;
    }
  }

  Widget imageBuild({double iconSize = 24.0}) {
    final String assetPath = switch (this) {
      FlutterReactionType.like => ImageConstants.like,
      FlutterReactionType.love => ImageConstants.love,
      FlutterReactionType.care => ImageConstants.care,
      FlutterReactionType.haha => ImageConstants.haha,
      FlutterReactionType.wow => ImageConstants.wow,
      FlutterReactionType.sad => ImageConstants.sad,
      FlutterReactionType.angry => ImageConstants.angry,
    };

    return Image.asset(assetPath, width: iconSize, height: iconSize, package: 'flutter_reactions');
  }

  Widget gifBuild({required double iconSize}) {
    final String assetPath = switch (this) {
      FlutterReactionType.like => GifConstants.like,
      FlutterReactionType.love => GifConstants.love,
      FlutterReactionType.care => GifConstants.care,
      FlutterReactionType.haha => GifConstants.haha,
      FlutterReactionType.wow => GifConstants.wow,
      FlutterReactionType.sad => GifConstants.sad,
      FlutterReactionType.angry => GifConstants.angry,
    };

    return Image.asset(assetPath, width: iconSize, height: iconSize, package: 'flutter_reactions');
  }
}
