import 'package:collectrack/common/theme/themes/dark_theme.dart';
import 'package:collectrack/common/theme/themes/default_theme.dart';
import 'package:collectrack/common/theme/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _themeData;
  ThemeData? get theme => _themeData;

  void setTheme(ThemeData themeInput) {
    ThemeData themeData;
    if (themeInput == LightTheme.theme) {
      themeData = LightTheme.theme;
    } else if (themeInput == DefaultTheme.theme) {
      themeData = DefaultTheme.theme;
    } else if (themeInput == DarkTheme.theme) {
      themeData = DarkTheme.theme;
    } else {
      themeData = LightTheme.theme;
    }

    _themeData = themeData;
    notifyListeners();
  }

  void setStandardTheme() {
    _themeData = LightTheme.theme;
    notifyListeners();
  }
}
