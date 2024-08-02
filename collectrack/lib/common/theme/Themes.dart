import 'package:collectrack/common/theme/themes/dark_theme.dart';
import 'package:collectrack/common/theme/themes/default_theme.dart';
import 'package:collectrack/common/theme/themes/light_theme.dart';
import 'package:flutter/material.dart';

class Themes {
  static final all = [
    LightTheme.theme,
    DefaultTheme.theme,
    DarkTheme.theme,
  ];

  static int getInt(String name) {
    switch (name) {
      case "Standard":
        return 0;
      case "Default":
        return 1;
      case "Dark":
        return 2;
      default:
        return 0;
    }
  }

  static String getString(ThemeData themeData) {
    if (themeData == LightTheme.theme) {
      return "Standard";
    } else if (themeData == DefaultTheme.theme) {
      return "Default";
    } else if (themeData == DarkTheme.theme) {
      return "Dark";
    } else {
      return "Standard";
    }
  }

  static ThemeData getThemeFromInt(int data) {
    switch (data) {
      case 0:
        return LightTheme.theme;
      case 1:
        return DefaultTheme.theme;
      case 2:
        return DarkTheme.theme;
      default:
        return LightTheme.theme;
    }
  }
}
