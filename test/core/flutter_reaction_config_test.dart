import 'package:flutter/material.dart';
import 'package:flutter_reactions/flutter_reactions.dart';
import 'package:flutter_reactions/src/core/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterReactionConfig', () {
    late bool originalIsMobile;

    setUp(() {
      originalIsMobile = AppConstants.isMobile;
      AppConstants.isMobile = true;
    });

    tearDown(() {
      AppConstants.isMobile = originalIsMobile;
    });

    test('uses default values when no params are provided', () {
      final config = FlutterReactionConfig();

      expect(config.debug, isFalse);
      expect(config.boxWidth, AppConstants.dimens.boxWidth);
      expect(config.boxHeight, AppConstants.dimens.boxHeight);
      expect(config.boxPadding, EdgeInsets.all(AppConstants.dimens.spacing));
      expect(config.itemConfig, isA<FlutterReactionItemConfig>());
      expect(config.itemConfig.iconHoverSize, AppConstants.dimens.iconHoverSize);
    });
    test('getBoxHeight returns active height when value is not null', () {
      final config = FlutterReactionConfig(boxHeight: 100);
      final height = config.getBoxHeight(FlutterReactionType.like);
      expect(height, AppConstants.dimens.boxHeightActive);
    });

    test('getBoxHeight returns base height when value is null', () {
      final config = FlutterReactionConfig(boxHeight: 100);
      final height = config.getBoxHeight(null);
      expect(height, 100);
    });
  });
}
