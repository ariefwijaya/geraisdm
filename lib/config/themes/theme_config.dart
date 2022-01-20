import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'light_theme.dart';

/// Enumeration of available themes in the app
///
/// [AppTheme.primaryLight] for Light Theme
/// or [AppTheme.primaryDark] for Dark/Night Theme
enum AppTheme {
  /// Key of light theme apps
  primaryLight,

  /// Key of Dark theme apps
  primaryDark
}

// The array of Theme Data that keep Available themes
final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.primaryLight: ThemeData(
      primaryColor: ColorLight.maroon,
      brightness: Brightness.light,
      primaryColorDark: ColorLight.maroonLight,
      primaryColorLight: ColorLight.gold,
      selectedRowColor: ColorLight.gold,
      buttonTheme: const ButtonThemeData(
        buttonColor: ColorLight.maroon,
      ),
      colorScheme: const ColorScheme.light(
          primary: ColorLight.maroon,
          background: ColorLight.maroonDisabled,
          secondary: ColorLight.maroon),
      indicatorColor: ColorLight.black40,
      splashColor: ColorLight.black30,
      errorColor: ColorLight.red,
      disabledColor: ColorLight.maroonDisabled,
      unselectedWidgetColor: ColorLight.black50,
      hintColor: ColorLight.black20,
      dividerColor: ColorLight.black20,
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) =>
              (states.contains(MaterialState.disabled))
                  ? ColorLight.maroonDisabled
                  : ColorLight.maroon),
          checkColor: MaterialStateProperty.all(ColorLight.white),
          side: const BorderSide(color: ColorLight.black50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorLight.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorLight.black70),
        titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith((states) =>
                  (states.contains(MaterialState.disabled))
                      ? ColorLight.maroonDisabled.withOpacity(0.3)
                      : ColorLight.maroon.withOpacity(0.3)),
              elevation: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.disabled) ? 0 : 2),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontWeight: FontWeight.bold)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              backgroundColor: MaterialStateProperty.resolveWith((states) => (states.contains(MaterialState.disabled)) ? ColorLight.maroonDisabled : ColorLight.maroon),
              foregroundColor: MaterialStateProperty.all(ColorLight.white))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) =>
            (!states.contains(MaterialState.disabled))
                ? ColorLight.maroon.withOpacity(0.1)
                : null),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)),
        side: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? const BorderSide(color: ColorLight.maroonDisabled)
                : const BorderSide(color: ColorLight.maroon)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        foregroundColor: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? ColorLight.maroonDisabled
                : ColorLight.maroon),
      )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) =>
            (!states.contains(MaterialState.disabled))
                ? ColorLight.maroon.withOpacity(0.1)
                : null),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        foregroundColor: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? ColorLight.maroonDisabled
                : ColorLight.maroon),
      )),
      inputDecorationTheme: const InputDecorationTheme(fillColor: ColorLight.maroon, focusColor: ColorLight.maroon, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorLight.black70), hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorLight.black50), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.black40)), border: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.black40)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.maroon))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: ColorLight.maroon, foregroundColor: ColorLight.white),
      textTheme: GoogleFonts.montserratTextTheme(const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorLight.black60),
        bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorLight.black60),
        subtitle1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorLight.black60),
        subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorLight.black60),
        headline1: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
        headline2: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
        headline3: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
        headline4: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
        headline5: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
        headline6: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ColorLight.black70),
      ))),
  // Dark Theme Data that will be used in the future. Still not used.
  AppTheme.primaryDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  )
};

extension ColorSchemeExtension on ThemeData {
  Color get secondaryRecommendationDark =>
      brightness == Brightness.light ? ColorLight.purple : ColorLight.purple;
  Color get errorColorLight => brightness == Brightness.light
      ? ColorLight.lightRed
      : ColorLight.lightRed;
Color get successColor =>
      brightness == Brightness.light ? ColorLight.green : ColorLight.green;
  Color get warningColor =>
      brightness == Brightness.light ? ColorLight.yellow : ColorLight.yellow;
}
