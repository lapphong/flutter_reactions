import 'app_constants.dart';

abstract final class AppDimens {
  double get boxWidth;
  double get boxHeight;
  double get boxHeightActive;
  double get iconSize;
  double get iconHoverSize;
  double get dotSize;
  double get spacing;

  static AppDimens get current {
    return AppConstants.isMobile ? const MobileDimens() : const DesktopDimens();
  }
}

final class MobileDimens implements AppDimens {
  const MobileDimens();

  @override
  double get boxWidth => 291.0;

  @override
  double get boxHeight => 45.0;

  @override
  double get iconSize => boxHeight - 10.0;

  @override
  double get dotSize => 4.0;

  @override
  double get spacing => 5.0;

  @override
  double get boxHeightActive => boxHeight + 7.0;

  @override
  double get iconHoverSize => iconSize + 30.0;
}

final class DesktopDimens implements AppDimens {
  const DesktopDimens();

  @override
  double get boxWidth => 329.0;

  @override
  double get boxHeight => 49.0;

  @override
  double get iconSize => boxHeight - 10.0;

  @override
  double get dotSize => 5.0;

  @override
  double get spacing => 5.0;

  @override
  double get boxHeightActive => boxHeight + 8.0;

  @override
  double get iconHoverSize => iconSize + 20.0;
}
