import 'package:flutter/material.dart';
import 'package:flutter_store/themes/colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'NotoSansThai',
    useMaterial3: false,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primary),
    scaffoldBackgroundColor: icons,
  );

}