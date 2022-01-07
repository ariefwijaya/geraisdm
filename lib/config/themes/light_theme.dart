import 'package:flutter/material.dart';

/// Classes containing the light theme Color Palette
class ColorLight {
  ColorLight._();

  static const Color maroon = Color(0xFFb01418);
  static const Color maroonLight = Color(0xFFf03a36);
  static const Color maroonDisabled = Color(0xFFE5C5C5);
  static const Color gold = Color(0xFFf5a325);

  static const Color yellow = Color(0xFFFFC526);
  static const Color green = Color(0xFF32D07B);
  static const Color red = Color(0xFFFF5959);
  static const Color lightBlue = Color(0xFF1DC6FC);
  static const Color lightPurple = Color(0xFFA292D2);
  static const Color purple = Color(0xFF8355CF);
  static const Color lightRed = Color(0xFFFF7171);

  static const Color black70 = Color(0xFF232931);
  static const Color black60 = Color(0xFF586371);
  static const Color black50 = Color(0xFFA5AAB0);
  static const Color black40 = Color(0xFFEDF0F4);
  static const Color black30 = Color(0xFFF4F8FC);
  static const Color black20 = Color(0xFFF8F9FB);
  static const Color white = Color(0xFFF8F9FB);

  static MaterialColor black = MaterialColor(
    black70.value,
    const <int, Color>{
      100: white,
      200: black20,
      300: black30,
      400: black40,
      500: black50,
      600: black60,
      700: black70,
    },
  );
}
