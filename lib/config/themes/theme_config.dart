import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      primaryColor: ColorLight.ocean,
      brightness: Brightness.light,
      primaryColorDark: ColorLight.oceanBlue,
      primaryColorLight: ColorLight.deepBlue,
      selectedRowColor: ColorLight.deepBlue,
      buttonTheme: const ButtonThemeData(
        buttonColor: ColorLight.ocean,
      ),
      colorScheme: const ColorScheme.light(
          primary: ColorLight.ocean,
          background: ColorLight.oceanDisabled,
          secondary: ColorLight.ocean),
      indicatorColor: ColorLight.black40,
      splashColor: ColorLight.black30,
      errorColor: ColorLight.red,
      disabledColor: ColorLight.oceanDisabled,
      unselectedWidgetColor: ColorLight.black50,
      hintColor: ColorLight.black20,
      dividerColor: ColorLight.black20,
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) =>
              (states.contains(MaterialState.disabled))
                  ? ColorLight.oceanDisabled
                  : ColorLight.ocean),
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
                      ? ColorLight.oceanDisabled.withOpacity(0.3)
                      : ColorLight.ocean.withOpacity(0.3)),
              elevation: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.disabled) ? 0 : 2),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontWeight: FontWeight.bold)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              backgroundColor: MaterialStateProperty.resolveWith((states) => (states.contains(MaterialState.disabled)) ? ColorLight.oceanDisabled : ColorLight.ocean),
              foregroundColor: MaterialStateProperty.all(ColorLight.white))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) =>
            (!states.contains(MaterialState.disabled))
                ? ColorLight.ocean.withOpacity(0.1)
                : null),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)),
        side: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? const BorderSide(color: ColorLight.oceanDisabled)
                : const BorderSide(color: ColorLight.ocean)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        foregroundColor: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? ColorLight.oceanDisabled
                : ColorLight.ocean),
      )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) =>
            (!states.contains(MaterialState.disabled))
                ? ColorLight.ocean.withOpacity(0.1)
                : null),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        foregroundColor: MaterialStateProperty.resolveWith((states) =>
            (states.contains(MaterialState.disabled))
                ? ColorLight.oceanDisabled
                : ColorLight.ocean),
      )),
      inputDecorationTheme: const InputDecorationTheme(fillColor: ColorLight.ocean, focusColor: ColorLight.ocean, labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorLight.black70), hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorLight.black50), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.black40)), border: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.black40)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorLight.ocean))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: ColorLight.ocean, foregroundColor: ColorLight.white),
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
  LinearGradient get primaryGradientDark => brightness == Brightness.light
      ? ColorLight.oceanGradientDark
      : ColorLight.oceanGradientDark;

  Color get secondaryRecommendation => brightness == Brightness.light
      ? ColorLight.lightPurple
      : ColorLight.lightPurple;

  Color get secondaryRecommendationDark =>
      brightness == Brightness.light ? ColorLight.purple : ColorLight.purple;

  List<Color> get donutChartPalette => brightness == Brightness.light
      ? [
          ColorLight.purple,
          ColorLight.lightBlue,
          ColorLight.red,
          ColorLight.ocean,
        ]
      : [
          ColorLight.purple,
          ColorLight.lightBlue,
          ColorLight.ocean,
          ColorLight.ocean,
        ];
  LinearGradient get expenseChartPalette => brightness == Brightness.light
      ? ColorLight.expenseGradient
      : ColorLight.expenseGradient;
  LinearGradient get incomeChartPalette => brightness == Brightness.light
      ? ColorLight.incomeGradient
      : ColorLight.incomeGradient;
  Color get errorColorLight => brightness == Brightness.light
      ? ColorLight.lightRed
      : ColorLight.lightRed;

  Color get warningColor =>
      brightness == Brightness.light ? ColorLight.yellow : ColorLight.yellow;
}
