import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider extends ChangeNotifier {
  SharedPreferences? _prefs;

  SharedPreferences? get prefs => _prefs;

  bool getBool(String boolName) {
    bool? result = _prefs?.getBool(boolName);
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  int getInt(String intName) {
    int? result = _prefs?.getInt(intName);
    if (result != null) {
      return result;
    } else {
      return 0;
    }
  }

  void setSharedPref(SharedPreferences spref) {
    _prefs = spref;
    notifyListeners();
  }
}
