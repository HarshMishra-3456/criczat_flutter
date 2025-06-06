// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;

class AllCoustomTheme {
  static bool isLight = true;

  static ThemeData getThemeData() {
    if (isLight) {
      return buildLightTheme();
    } else {
      return buildDarkTheme();
    }
  }

  static Color getTextThemeColors() {
    if (isLight) {
      return Color(0xFF9E9E9E);
    } else {
      return Color(0xFF636466);
    }
  }

  static Color getBlackAndWhiteThemeColors() {
    if (isLight) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color getReBlackAndWhiteThemeColors() {
    if (isLight) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static ThemeData buildDarkTheme() {
    Color primaryColor = (globals.primaryColorString);
    Color secondaryColor = (globals.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      popupMenuTheme: PopupMenuThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(color: Colors.black),
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[850],
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      platform: TargetPlatform.iOS, colorScheme: colorScheme.copyWith(background: Colors.grey[850]),
    );
  }

  static ThemeData buildLightTheme() {
    Color primaryColor = (globals.primaryColorString);
    Color secondaryColor = (globals.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFEFF1F4),
      cardColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ), colorScheme: colorScheme.copyWith(background: const Color(0xFFFFFFFF)),
    );
  }
}
