import 'package:flutter/material.dart';
import 'package:gritstone_machine_test/constants/app_relates.dart';

enum AppThemes {
  darkTheme,
  lightTheme,
}

class AppTheme {
  // Define the default light theme

  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  static const Color lightPrimaryColor = Colors.green;
  static const Color lightSecondaryColor = Colors.white;
  static const Color darkPrimaryColor = Colors.black;
  static const Color darkSecondaryColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    // fontFamily: AppConst.fontPoppins,
    cardColor: Colors.white,
    highlightColor: lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimaryColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
        // Your text styles for the light theme
        ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(lightSecondaryColor),
      trackColor: MaterialStateProperty.all(lightSecondaryColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      background: Colors.white,
      tertiary: lightPrimaryColor,
    ).copyWith(background: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    // fontFamily: AppConst.fontPoppins,
    highlightColor: Colors.white,
    cardColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimaryColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    // iconButtonTheme: IconButtonThemeData(
    //     style: ButtonStyle(
    //         shape: MaterialStatePropertyAll(CircleBorder()),
    //         foregroundColor: MaterialStatePropertyAll(Colors.white),
    //         backgroundColor: MaterialStatePropertyAll(Colors.white))),
    textTheme: const TextTheme(),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.cyan),
      trackColor: MaterialStateProperty.all(Colors.grey),
    ),
    colorScheme: const ColorScheme.dark(
      primary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      background: Colors.black,
      tertiary: Colors.white,
    ).copyWith(background: Colors.black),
  );
}
