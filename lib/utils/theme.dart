import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    cardColor: Colors.grey.shade200,

    colorScheme: ColorScheme.light(
      primary: Colors.red,
      secondary: Colors.redAccent,
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: Colors.grey,

    colorScheme: ColorScheme.dark(
      primary: Colors.red,
      secondary: Colors.redAccent,
    ),

    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}