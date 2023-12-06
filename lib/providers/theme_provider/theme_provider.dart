import 'package:flutter/material.dart';

import '../../constants/theme.dart';
import '../../service/shared_preference_helper.dart';

class ThemeProvider extends ChangeNotifier {
  static const String fontPoppins = 'Poppins-Regular';
  static const String fontKalam = 'Kalam-Regular';
  ThemeData _currentTheme =
      AppTheme.lightTheme; // Use your light theme as the initial theme

  ThemeData get currentTheme => _currentTheme;

  ThemeProvider._() {
    loadTheme();
  }

  // Singleton instance
  static final ThemeProvider _instance = ThemeProvider._();

  // Factory constructor to provide access to the singleton instance
  factory ThemeProvider() {
    return _instance;
  }

  String _selectedFont = 'Kalam-Regular'; // Initial font

  String get selectedFont => _selectedFont;

  void changeFont(String font) async {
    _selectedFont = font;
    await SharedPreferenceHelper.saveAppFont(font);
    final textTheme = _currentTheme.textTheme.copyWith(
      // Apply the font to the text styles in the theme
      titleMedium: TextStyle(fontFamily: font),
      bodyLarge: TextStyle(fontFamily: font),
      bodyMedium: TextStyle(fontFamily: font),
      displayLarge: TextStyle(fontFamily: font),
      labelLarge: TextStyle(fontFamily: font),
      bodySmall: TextStyle(fontFamily: font),
      displayMedium: TextStyle(fontFamily: font),
      displaySmall: TextStyle(fontFamily: font),
      headlineMedium: TextStyle(fontFamily: font),
      headlineSmall: TextStyle(fontFamily: font),
      titleLarge: TextStyle(fontFamily: font),
      headlineLarge: TextStyle(fontFamily: font),
      // Add more text styles here as needed
    );
    _currentTheme = _currentTheme.copyWith(
      textTheme: textTheme,
    );
    await SharedPreferenceHelper.saveAppTheme(
      _currentTheme == AppTheme.darkTheme.copyWith(
        textTheme: textTheme,
      ) ? AppThemes.darkTheme : AppThemes.lightTheme,
    );
    notifyListeners();
  }

  void toggleTheme() async {
    final currentFont = _selectedFont;

    // Update the _currentTheme variable
    _currentTheme = _currentTheme == AppTheme.lightTheme
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;

    // Save the updated theme preference
    await SharedPreferenceHelper.saveAppTheme(_currentTheme == AppTheme.darkTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);

    notifyListeners();
  }




  Future<ThemeData> loadTheme() async {
    // Load the theme preference from shared preferences when the model is created
    final themePreference = await SharedPreferenceHelper.getAppTheme();
    // final appFont = await SharedPreferenceHelper.getAppFont();
    _currentTheme = themePreference == AppThemes.darkTheme
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
    notifyListeners();
    return _currentTheme;
  }

  // void toggleTheme() async {
  //   final font = _selectedFont;
  //   // final textTheme = _currentTheme.textTheme.copyWith(
  //   //   // Apply the font to the text styles in the theme
  //   //   titleMedium: TextStyle(fontFamily: font),
  //   //   bodyLarge: TextStyle(fontFamily: font),
  //   //   bodyMedium: TextStyle(fontFamily: font),
  //   //   displayLarge: TextStyle(fontFamily: font),
  //   //   labelLarge: TextStyle(fontFamily: font),
  //   //   bodySmall: TextStyle(fontFamily: font),
  //   //   displayMedium: TextStyle(fontFamily: font),
  //   //   displaySmall: TextStyle(fontFamily: font),
  //   //   headlineMedium: TextStyle(fontFamily: font),
  //   //   headlineSmall: TextStyle(fontFamily: font),
  //   //   titleLarge: TextStyle(fontFamily: font),
  //   //   headlineLarge: TextStyle(fontFamily: font),
  //   //   // Add more text styles here as needed
  //   // );
  //   //
  //   // _currentTheme = _currentTheme.copyWith(
  //   //   textTheme: textTheme,
  //   // );
  //   final appTheme = await SharedPreferenceHelper.getAppTheme();
  //   _currentTheme = _currentTheme == AppTheme.lightTheme
  //       ? AppTheme.darkTheme
  //       : AppTheme.lightTheme;
  //   await SharedPreferenceHelper.saveAppTheme(
  //       _currentTheme == AppTheme.darkTheme
  //           ? AppThemes.darkTheme
  //           : AppThemes.lightTheme);
  //   notifyListeners();
  // }
}
