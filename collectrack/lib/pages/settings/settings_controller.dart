import 'package:collectrack/common/providers.dart';
import 'package:collectrack/common/shared_preferences/shared_preferences_provider.dart';
import 'package:collectrack/pages/home/home_view.dart';
import 'package:collectrack/pages/settings/settings_model.dart';
import 'package:collectrack/pages/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsControllerImplementation extends SettingsController {
  final SharedPrefProvider _sharedPref;

  SettingsControllerImplementation(
      {required SharedPrefProvider sharedPref, SettingsModel? model})
      : _sharedPref = sharedPref,
        super(
          model ??
              SettingsModel(
                biggerFont: sharedPref.getBool('biggerFont'),
                language: sharedPref.getInt('language'),
                dailyFavorite: sharedPref.getBool('favourite'),
                theme: sharedPref.getInt('theme'),
              ),
        );

  @override
  void navigate(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/list-collections');
        break;
      case 2:
        //No need here, this is THIS page.
        //Navigator.pushNamed(context, '/settings');
        break;
      case 3:
        Navigator.pushNamed(context, '/help-center');
        break;
    }
  }

  @override
  void switchDailyFavorite(WidgetRef ref) {
    _sharedPref.prefs?.setBool('favourite', !state.dailyFavorite);
    state = state.copyWith(dailyFavorite: !state.dailyFavorite);
    final HomeController homecontroller =
        ref.read(providers.homeControllerProvider.notifier);
    homecontroller.switchShowcase();
  }

  @override
  void switchFont() {
    _sharedPref.prefs?.setBool('biggerFont', !state.biggerFont);
    state = state.copyWith(biggerFont: !state.biggerFont);
  }

  @override
  void switchLanguage(int language) {
    _sharedPref.prefs?.setInt('language', language);
    state = state.copyWith(language: language);
  }

  @override
  void switchTheme(int theme) {
    _sharedPref.prefs?.setInt('theme', theme);
    state = state.copyWith(theme: theme);
  }
}
