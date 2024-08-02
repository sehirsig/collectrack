import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,

    //primary color
    primarySwatch: const MaterialColor(0xB3FFFFFF, {
      50: Color.fromARGB(179, 255, 255, 255),
      100: Color.fromARGB(165, 255, 255, 255),
      200: Color.fromARGB(150, 255, 255, 255),
      300: Color.fromARGB(135, 255, 255, 255),
      400: Color.fromARGB(110, 255, 255, 255),
      500: Color.fromARGB(95, 255, 255, 255),
      600: Color.fromARGB(80, 255, 255, 255),
      700: Color.fromARGB(65, 255, 255, 255),
      800: Color.fromARGB(50, 255, 255, 255),
      900: Color.fromARGB(35, 255, 255, 255),
    }),
    primaryColor: Colors.white54,
    primaryColorDark: Colors.white54,
    //backgroundColor: Colors.white70,
    dividerColor: Colors.white54,

    //toggleableActiveColor: Colors.white,
    colorScheme: const ColorScheme.dark(),

    //elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.white70))),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white54),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white70),
            overlayColor: WidgetStateProperty.all<Color>(
                Colors.white54.withOpacity(0.5)))),

    //SwitchListTile
    switchTheme: SwitchThemeData(
      overlayColor: WidgetStateProperty.all<Color>(Colors.white38),
      splashRadius: 20,
    ),

    //floating action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white10,
      shape: CircleBorder(side: BorderSide(color: Colors.white38)),
    ),

    //bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white10,
      selectedItemColor: Colors.white70,
      selectedIconTheme: IconThemeData(color: Colors.white70),
      unselectedItemColor: Colors.white30,
      unselectedIconTheme: IconThemeData(color: Colors.white30),
    ),
  );
}
