import 'package:flutter_reactions/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDimens.current', () {
    test('AppConstants.dimens forwards to AppDimens.current', () {
      AppConstants.isMobile = true;
      expect(AppConstants.dimens, isA<MobileDimens>());

      AppConstants.isMobile = false;
      expect(AppConstants.dimens, isA<DesktopDimens>());
    });

    test('ImageConstants should expose all image paths', () {
      expect(ImageConstants.like, isNotEmpty);
      expect(ImageConstants.love, isNotEmpty);
      expect(ImageConstants.care, isNotEmpty);
      expect(ImageConstants.haha, isNotEmpty);
      expect(ImageConstants.wow, isNotEmpty);
      expect(ImageConstants.sad, isNotEmpty);
      expect(ImageConstants.angry, isNotEmpty);
    });
  });

  group('MobileDimens', () {
    const dimens = MobileDimens();

    test('returns correct base values', () {
      expect(dimens.boxWidth, 291.0);
      expect(dimens.boxHeight, 45.0);
      expect(dimens.iconSize, 35.0);
      expect(dimens.dotSize, 4.0);
      expect(dimens.spacing, 5.0);
    });

    test('calculates derived values correctly', () {
      expect(dimens.boxHeightActive, dimens.boxHeight + 7.0);
      expect(dimens.iconHoverSize, dimens.iconSize + 30.0);
    });
  });

  group('DesktopDimens', () {
    const dimens = DesktopDimens();

    test('returns correct base values', () {
      expect(dimens.boxWidth, 329.0);
      expect(dimens.boxHeight, 49.0);
      expect(dimens.iconSize, 39.0);
      expect(dimens.dotSize, 5.0);
      expect(dimens.spacing, 5.0);
    });

    test('calculates derived values correctly', () {
      expect(dimens.boxHeightActive, dimens.boxHeight + 8.0);
      expect(dimens.iconHoverSize, dimens.iconSize + 20.0);
    });
  });
}
