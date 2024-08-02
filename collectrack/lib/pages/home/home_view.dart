import 'dart:io';

import 'package:collectrack/common/shared_preferences/shared_preferences_provider.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/home/home_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final HomeController controller =
        ref.read(providers.homeControllerProvider.notifier);
    final HomeModel model = ref.watch(providers.homeControllerProvider);

    final SharedPrefProvider _prefs = ref.watch(providers.sharePrefProvider);

    bool _showcase = _prefs.getBool('favourite');
    String _objectName = model.objectName;
    String _objectImage = model.objectImage;

    //global variables
    double _nameFontSize = 20;
    double _pictureSize = 200;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _stringBib.home_appBarTitle,
          ),
          leading: Image.asset(
            'assets/images/small_logo.png',
            width: 256,
            height: 256,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_stringBib.home_welcomeText,
                  textAlign: TextAlign.center, textScaleFactor: 1.5),
              const SizedBox(height: 20),
              Text(
                _stringBib.home_helpText,
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
              _showcase
                  ? InkWell(
                      onTap: () {
                        controller.getFavoriteObject();
                      },
                      child: Card(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.info),
                            title: Text(_stringBib.home_favObjectTitle),
                            subtitle: Text(_stringBib.home_favObjectText),
                          ),
                          (_objectImage == "")
                              ? Image.asset('assets/images/small_logo.png',
                                  width: _pictureSize, height: _pictureSize)
                              : Image.file(File(_objectImage),
                                  width: _pictureSize, height: _pictureSize),
                          Text(_objectName,
                              style: TextStyle(fontSize: _nameFontSize)),
                        ],
                      )))
                  : InkWell(
                      onTap: () {
                        controller.getDailyObject();
                      },
                      child: Card(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.info),
                            title: Text(_stringBib.home_dailyObjectTitle),
                            subtitle: Text(_stringBib.home_dailyObjectText),
                          ),
                          (_objectImage == "")
                              ? Image.asset('assets/images/small_logo.png',
                                  width: _pictureSize, height: _pictureSize)
                              : Image.file(File(_objectImage),
                                  width: _pictureSize, height: _pictureSize),
                          Text(_objectName,
                              style: TextStyle(fontSize: _nameFontSize))
                        ],
                      ))),
            ],
          ),
        ),
        bottomNavigationBar: const CtNavigationBar(0));
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);
  void navigate(BuildContext context, int value);
  void switchShowcase();
  void getDailyObject();
  void getFavoriteObject();
}
