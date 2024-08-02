import 'package:collectrack/common/locale/locale_provider';
import 'package:collectrack/common/shared_preferences/shared_preferences_provider.dart';
import 'package:collectrack/common/theme/themes.dart';
import 'package:collectrack/common/theme/themes_provider.dart';
import 'package:collectrack/l10n/l10n.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/settings/settings_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final SettingsController controller =
        ref.read(providers.settingsControllerProvider.notifier);
    final SettingsModel model = ref.watch(providers.settingsControllerProvider);
    final LocaleProvider localeProvider = ref.watch(providers.localeProvider);

    final SharedPrefProvider _prefs = ref.watch(providers.sharePrefProvider);

    final ThemeProvider themeProvider = ref.watch(providers.themeProvider);

    bool _dailyfavorite = model.dailyFavorite;
    bool _biggerFont = model.biggerFont;

    Widget _sideClearance = const SizedBox(width: 15);

    return Scaffold(
        appBar: AppBar(
          title: Text(_stringBib.settings_appBarTitle),
          leading: Image.asset(
            'assets/images/small_logo.png',
            width: 256,
            height: 256,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  _sideClearance,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.navigate(context, 3);
                          },
                          child: Text(_stringBib.settings_helpCenter,
                              style: const TextStyle(fontSize: 24))),
                    ),
                  ),
                  _sideClearance
                ],
              ),
              //Favourite
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.horizontal(),
                ),
                child: Row(
                  children: [
                    _sideClearance,
                    Text(_stringBib.settings_dailyFavourite,
                        style: const TextStyle(fontSize: 16)),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Switch(
                          value: _dailyfavorite,
                          onChanged: (bool value) {
                            controller.switchDailyFavorite(ref);
                          },
                        ),
                      ),
                    ),
                    _sideClearance,
                  ],
                ),
              ),
              //Language
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.horizontal(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          children: [
                            _sideClearance,
                            Text(_stringBib.settings_selectLanguage,
                                style: const TextStyle(fontSize: 16)),
                            Expanded(
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                icon: const Icon(Icons.language),
                                items: L10n.all.map((locale) {
                                  return DropdownMenuItem(
                                    child: Center(
                                      child: Text(L10n.getString(
                                          locale.toLanguageTag())),
                                    ),
                                    value: locale,
                                    onTap: () {
                                      controller.switchLanguage(
                                          L10n.getIntFromStringCode(
                                              locale.toLanguageTag()));
                                      localeProvider.setLocale(locale);
                                    },
                                  );
                                }).toList(),
                                value: L10n.getLocaleFromInt(_prefs.getInt(
                                    'language')), //Localizations.localeOf(context),
                                onChanged: (_) {},
                              ),
                            ))),
                            _sideClearance
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.horizontal(),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Row(
                          children: [
                            _sideClearance,
                            Text(_stringBib.settings_selectTheme,
                                style: const TextStyle(fontSize: 16)),
                            Expanded(
                                child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: const Icon(
                                      Icons.display_settings_rounded),
                                  items: Themes.all.map((themes) {
                                    return DropdownMenuItem(
                                      child: Center(
                                        child: Text(Themes.getString(themes)),
                                      ),
                                      value: themes,
                                      onTap: () {
                                        controller.switchTheme(Themes.getInt(
                                            Themes.getString(themes)));
                                        themeProvider.setTheme(themes);
                                      },
                                    );
                                  }).toList(),
                                  value: Themes.getThemeFromInt(
                                      _prefs.getInt('theme')),
                                  onChanged: (_) {},
                                ),
                              ),
                            )),
                            _sideClearance,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(_stringBib.settings_creators),
              Text(_stringBib.settings_twitter),
              Text(_stringBib.settings_version),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: const CtNavigationBar(2));
  }
}

abstract class SettingsController extends StateNotifier<SettingsModel> {
  SettingsController(SettingsModel state) : super(state);
  void navigate(BuildContext context, int value);
  void switchDailyFavorite(WidgetRef ref);
  void switchLanguage(int language);
  void switchFont();
  void switchTheme(int theme);
}
