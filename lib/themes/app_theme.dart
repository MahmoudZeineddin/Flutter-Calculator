import 'package:calculator/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: AppColors.darkText)),
  );
}
