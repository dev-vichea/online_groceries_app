import 'package:flutter/material.dart';
import 'package:online_groceries_app/utils/constants.dart';

class AppTheme {
  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Gilroy',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      secondary: Colors.grey.shade400,
      onSecondary: Colors.grey.shade800,
      tertiary: Colors.grey.shade900,
      onTertiary: Colors.grey.shade200,
      primaryFixed: Colors.black,
      secondaryFixed: Colors.grey.shade500,
      surface: Colors.grey.shade300,
    ),
  );

  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Gilroy',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      secondary: Colors.grey.shade800,
      onSecondary: Colors.grey.shade400,
      tertiary: Colors.grey.shade200,
      onTertiary: Colors.grey.shade900,
      primaryFixed: Colors.black,
      secondaryFixed: Colors.grey.shade500,
      surface: Colors.grey.shade700,
    ),
  );
}