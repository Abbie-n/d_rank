import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Tekur',
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
  );
}
