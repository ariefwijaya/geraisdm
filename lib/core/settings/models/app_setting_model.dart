import '../../../../config/themes/theme_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_setting_model.g.dart';

@JsonSerializable()
class AppSettingModel {
  @JsonKey(defaultValue: "id")
  final String? languageCode;
  @JsonKey(defaultValue: AppTheme.primaryLight)
  final AppTheme? appTheme;

  AppSettingModel({this.languageCode, this.appTheme});

  AppSettingModel copyWith({String? languageCode, AppTheme? appTheme}) {
    return AppSettingModel(
        languageCode: languageCode ?? this.languageCode,
        appTheme: appTheme ?? this.appTheme);
  }

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingModelToJson(this);
}
