import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('de'),
    const Locale('en'),
  ];

  static int getIntFromStringCode(String code) {
    switch (code) {
      case 'de':
        return 0;
      case 'en':
        return 1;
      default:
        return 0;
    }
  }

  static String getStringFromInt(int code) {
    switch (code) {
      case 0:
        return "Deutsch";
      case 1:
        return "English";
      default:
        return "Deutsch";
    }
  }

  static Locale getLocaleFromInt(int code) {
    switch (code) {
      case 0:
        return const Locale('de');
      case 1:
        return const Locale('en');
      default:
        return const Locale('de');
    }
  }

  static String getString(String code) {
    switch (code) {
      case 'de':
        return "Deutsch";
      case 'en':
        return "English";
      default:
        return "Deutsch";
    }
  }
}
