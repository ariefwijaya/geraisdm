import 'dart:math';

import '../../../../core/app_setting.dart';
import 'package:easy_localization/easy_localization.dart';

class FormatHelper {
  FormatHelper._();
  static String formatCurrency(
    num number,
    String locale, {
    String? symbol,
    int decimalDigits = 0,
  }) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol ?? AppSetting.currencySymbol,
      decimalDigits: decimalDigits,
    ).format(number);
  }

  static String formatCurrencyCompact(num number, String locale,
      {String? symbol}) {
    return NumberFormat.compactCurrency(
            locale: locale,
            symbol: symbol ?? AppSetting.currencySymbol,
            decimalDigits: 0)
        .format(number);
  }

  static String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    const length = 20;
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += number;
    if (isSpecial) chars += special;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join();
  }

  static String enumName(Object o) => o.toString().split('.').last;
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalizeFirst).join(" ");
  String get capitalizeFirst => "${this[0].toUpperCase()}${substring(1)}";
}
