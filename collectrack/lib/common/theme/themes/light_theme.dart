import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    //brightness
    brightness: Brightness.light,

    //primary color
    primarySwatch: const MaterialColor(0xFFD0E454, {
      50: Color.fromRGBO(208, 228, 84, 1),
      100: Color.fromRGBO(208, 228, 84, 20),
      200: Color.fromRGBO(208, 228, 84, 40),
      300: Color.fromRGBO(208, 228, 84, 60),
      400: Color.fromRGBO(208, 228, 84, 80),
      500: Color.fromRGBO(208, 228, 84, 100),
      600: Color.fromRGBO(208, 228, 84, 120),
      700: Color.fromRGBO(208, 228, 84, 140),
      800: Color.fromRGBO(208, 228, 84, 160),
      900: Color.fromRGBO(208, 228, 84, 180),
    }),
    primaryColor: const Color.fromRGBO(208, 228, 84, 1),
    scaffoldBackgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Colors.white54,


    //TextButton
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    )),

    //normal button
    buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromRGBO(208, 228, 84, 1),
        textTheme: ButtonTextTheme.primary),

    //floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromRGBO(208, 228, 84, 1).withOpacity(0.8),
      shape: const CircleBorder(side: BorderSide(color: Colors.black)),
    ),

    //App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(208, 228, 84, 1),
      centerTitle: true,
    ),

    //Icon
    iconTheme: const IconThemeData(color: Color.fromRGBO(208, 228, 84, 1)),

    //Slider
    sliderTheme: const SliderThemeData(
        thumbColor: Colors.green,
        overlayColor: Color.fromRGBO(208, 228, 84, 1),
        valueIndicatorColor: Colors.green,
        activeTrackColor: Color.fromRGBO(208, 228, 84, 1),
        inactiveTrackColor: Color.fromRGBO(208, 228, 84, 1)),

    //elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                        color: Color.fromRGBO(208, 228, 84, 1)))),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(208, 228, 84, 1)),
            overlayColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(208, 228, 84, 1).withOpacity(0.5)))),

    //bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(208, 228, 84, 1),
      selectedItemColor: Color.fromRGBO(52, 60, 28, 1),
      selectedIconTheme: IconThemeData(color: Color.fromRGBO(52, 60, 28, 1)),
      unselectedItemColor: Colors.black,
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
