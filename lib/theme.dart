import 'package:flutter/material.dart';

const primaryColor = Color(0xffff8b7d);
const double kSectionSpacingSm = 8.0;
const double kSectionSpacingMd = 12.0;
const double kSectionSpacingLg = 16.0;

const double kScreenPadding = 16.0;
const double kScreenPaddingLg = 24.0;

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      primaryColor: const Color(0xffff8b7d),
      secondaryHeaderColor: const Color(0xFFfa7364));
}
