import 'package:flutter/material.dart';

class LanguageModel {
  LanguageModel({required this.languageCode, required this.name});

  String languageCode;
  String name;

  String get localeTag {
    return languageCode;
  }

  Locale toLocale() {
    return Locale(languageCode, '');
  }

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
        languageCode: json['languageCode'] as String,
        name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageCode'] = languageCode;
    data['name'] = name;
    return data;
  }
}

class SettingLanguageModel {
  SettingLanguageModel({required this.lang});

  String lang;

  factory SettingLanguageModel.fromJson(Map<String, dynamic> json) {
    return SettingLanguageModel(lang: json['lang'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lang'] = lang;
    return data;
  }
}
