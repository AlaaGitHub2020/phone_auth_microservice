library themes;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'colors.dart';

part 'light.dart';

/// Theme build context extension
extension ThemeDataExtension on ThemeData {
  /// Theme colors
  ThemeColors get color => extension<ThemeColors>()!;

  /// get theme from storage
  ThemeData get getAppTheme {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return hotelsExplorationLight;
  }
}
