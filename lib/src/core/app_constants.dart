import 'package:flutter/foundation.dart';

import 'app_dimens.dart';

final class AppConstants {
  static bool isMobile = defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  static AppDimens get dimens => AppDimens.current;

  static const double gap = 6.0;
  static const double spacing = 5.0;
  static const double dragThreshold = 6.0;

  static const Duration duration = Duration(milliseconds: 200);
}
